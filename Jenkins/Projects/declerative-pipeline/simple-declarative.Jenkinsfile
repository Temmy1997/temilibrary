pipeline {
    agent any
    triggers{
        cron('0 3 * * 1-5')
    }

    stages {
        stage('SCM'){
            steps{
                git branch: 'main', url: 'https://github.com/FeynmanFan/declarative-pipelines.git'
            }
        }
        stage('build') {
            steps {
                echo 'build the code'
                // build the code
            }
        }

        stage('Package') {
            when {
                expression {
                    return params.branch == "release"
                }
            }
            steps {
                echo 'Packaging the code for release'
            }
        }
    }
}