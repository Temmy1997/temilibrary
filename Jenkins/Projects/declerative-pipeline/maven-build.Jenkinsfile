pipeline{
    agent any
    tools{
        maven 'maven-3.9.9'
    }
    stages{
        stage('Maven version'){
            steps{
                sh 'mvn --version'
            }
        }
    }
}