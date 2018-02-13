#!/bin/bash

############################################################
#
# $1 : tiempo en segundos que durará la prueba
#
#
# $2 : cada cuántos minutos se lanzan los jobs
#
############################################################

dir=$(pwd)


### Limpiar posibles restos anteriores

rm -f conf.sh.BAK conf.shE conf.sh.ORIG get-end-date.sh sso.py test-end-date test-launcher.sh test-runner.sh


### Modificar el fichero de la configuración para poder reemplazar la Cookie

cp "$dir/conf.sh" "$dir/conf.sh.ORIG"
sed -iE 's/^COOKIE.*/COOKIE="Cookie: SSOID=s1; XXXXX"/' "$dir/conf.sh"
rm -f "$dir/conf.shE"
cp "$dir/conf.sh" "$dir/conf.sh.BAK"


### Crear fichero con la fecha de fin de la ejecución

now=$(date +%s)
end=$(date +%s --date="@$((now + $1))")
echo "$end" > "$dir/test-end-date"


### Crear el fichero que lanza los jobs contra el Spark dispatcher

cat << EOT | tee -a $dir/test-runner.sh > /dev/null
#!/bin/bash

#cd server
#sudo python -m SimpleHTTPServer 6666 &
#cd ..
source conf.sh

echo "Running postgres acceptance job"
bash postgres/json-composer.sh
curl -k -XPOST -H "Cookie:\${COOKIE}" -d @postgres/body.json \$SPARK_DISPATCHER_URL

echo "Running structured streaming acceptance job"
bash structured-streaming/json-composer.sh
curl -k -XPOST -H "Cookie:\${COOKIE}" -d @structured-streaming/body.json \$SPARK_DISPATCHER_URL

echo "Running elastic acceptance job"
bash elastic/json-composer.sh
curl -k -XPOST -H "Cookie:\${COOKIE}" -d @elastic/body.json \$SPARK_DISPATCHER_URL

echo "Running hdfs acceptance job"
bash hdfs/json-composer.sh
curl -k -XPOST -H "Cookie:\${COOKIE}" -d @hdfs/body.json \$SPARK_DISPATCHER_URL

#sleep 90
sleep 5

rm -f */body.json

#kill %1 > /dev/null
EOT
sudo chmod +x "$dir/test-runner.sh"


### Crear el fichero que lanza la ejecución del TEST

cat << EOT | tee -a $dir/test-launcher.sh > /dev/null
#!/bin/bash

dir=\$(pwd)

cookie=\$(python3 \$dir/sso.py https://fulle1.labs.stratio.com/login admin 1234)
i=0

while [[ -z \$cookie && "\$i" -gt 10 ]]
do
    cookie=\$(python3 sso.py https://fulle1.labs.stratio.com/login admin 1234)
    i=\$((\$i+1))
done

if [[ "\$i" -gt 10 ]]; then
    exit
fi

sed -iE "s/XXXXX/\$cookie/" conf.sh

\$dir/test-runner.sh

cp \$dir/conf.sh.BAK \$dir/conf.sh

tend=\$(cat test-end-date)
tnow=\$(date +%s)
if [[ "\$tend" -gt "\$tnow" ]]; then
    echo "\$dir/test-launcher.sh" | at now + $2 minutes
else
    kill -9 \$(ps faux | grep "_ python -m SimpleHTTPServer" | grep -v "grep" | awk '{print \$2}')
    exit
fi
EOT
sudo chmod +x "$dir/test-launcher.sh"


### Crear el fichero Python que obtiene la Cookie

cat << EOT | tee -a $dir/sso.py > /dev/null
import json
import requests
import sys
from bs4 import BeautifulSoup
from http.cookiejar import Cookie, CookieJar
from requests.packages.urllib3.exceptions import InsecureRequestWarning
requests.packages.urllib3.disable_warnings(InsecureRequestWarning)

def login_in_dcos(url, username, password):
    """
    Function that simulates the login in DCOS flow with SSO to obtain a valid
    cookie that will be used to make requests to Marathon
    """
    # First request to mesos master to be redirected to gosec sso login
    # page and be given a session cookie
    r = requests.Session()

    try:
        first_response = r.get(url, verify=False)
    except Exception as e:
        return ""

    callback_url = first_response.url

    # Parse response body for hidden tags needed in the data of our login post request
    body = first_response.text
    parser = BeautifulSoup(body, "lxml")
    hidden_tags = [tag.attrs for tag in parser.find_all("input", type="hidden")]
    data = {tag['name']: tag['value'] for tag in hidden_tags
            if tag['name'] == 'lt' or tag['name'] == 'execution'}

    # Add the rest of needed fields and login credentials in the data of
    # our login post request and send it
    data.update(
        {'_eventId': 'submit',
         'submit': 'LOGIN',
         'username': username,
         'password': password
        }
    )

    try:
        login_response = r.post(callback_url, data=data, verify=False)
    except Exception as e:
        return ""

    # Obtain dcos cookie from response
    try:
        return login_response.history[-1].cookies
    except Exception as e:
        return ""

def main():
    cookie = login_in_dcos(sys.argv[1], sys.argv[2], sys.argv[3])
    #print("dcos-acs-info-cookie=" + dict(cookie)["dcos-acs-info-cookie"])
    #print("dcos-acs-auth-cookie=" + dict(cookie)["dcos-acs-auth-cookie"])
    if not cookie:
        print("")
    else:
        finalcookie="dcos-acs-auth-cookie=" + dict(cookie)["dcos-acs-auth-cookie"] + "; dcos-acs-info-cookie=" + dict(cookie)["dcos-acs-info-cookie"]
        print(finalcookie)

if __name__ == "__main__":
    main()
EOT


### Lanzar toda la ejecución

cd "$dir/server"
sudo python -m SimpleHTTPServer 6666 &
cd ..
bash "$dir/test-launcher.sh"
