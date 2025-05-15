pipeline {
    agent any
    environment {
        AWS_DEFAULT_REGION = "us-east-1"
    }

    stages {
        stage('Build') {
            steps {
                withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'bda47056-5d9a-4c9c-88d0-c9e7b7de34f5', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    echo "Build stage
                }
            }
        }
        stage('Test') {
            steps {
                echo "Testing stage"
            }
        }
        stage('Deploy to S3') {
            steps {
                echo "Deploying"
                withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'bda47056-5d9a-4c9c-88d0-c9e7b7de34f5', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    echo "AWS Credentials are in scope for deployment"
                    sh 'aws s3 cp ./index.html s3://pjenkins-bucket'
                }
            }
        }
    }

    post {
        success {
            echo "success"
        }
        failure {
            echo "failure"
        }
    }
}
