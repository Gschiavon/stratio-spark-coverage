@Library('libpipelines@master') _

hose {
    EMAIL = 'support'
    SLACKTEAM = 'stratiosecurity'
    MODULE = 'stratio-spark-coverage'
    REPOSITORY = 'stratio-spark-coverage'
    DEVTIMEOUT = 300
    RELEASETIMEOUT = 200

    PKGMODULESNAMES = ['stratio-spark-coverage']

    DEV = { config ->

        doCompile(conf: config)
        doPackage(conf: config)
        doDocker(conf: config)

    }

}