pipeline {
    agent any
    stages {
        stage('List Environment Variables') {
            steps {
                script {
                    echo "Listing all Jenkins built-in environment variables:"
                }
                sh '''
                echo "Environment Variables:"
                echo "-----------------------"
                # Iterate through all environment variables
                printenv | sort
                '''
            }
        }
    }
}
