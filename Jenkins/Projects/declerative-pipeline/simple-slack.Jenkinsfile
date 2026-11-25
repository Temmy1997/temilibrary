pipeline{
    agent any
    stages{
        stage('Build'){
            steps{
                echo 'Build the code'
            }
        }
        stage('Notify'){
            steps{
                echo 'Send notification'
                slackSend channel: 'devops', message: 'Build has completed.'
            }
        }
    }
}