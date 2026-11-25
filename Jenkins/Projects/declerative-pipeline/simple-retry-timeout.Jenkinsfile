pipeline {
    agent any

    environment {
        RETRY_COUNT = '0' // Initialize retry count to 0
    }

    stages {
        stage('Simulate External Connection') {
            steps {
                script {
                    retry(3) { // Retry up to 3 times if this block fails
                        // Increment the RETRY_COUNT environment variable
                        env.RETRY_COUNT = (env.RETRY_COUNT.toInteger() + 1).toString()
                        
                        timeout(time: 90, unit: 'SECONDS') { // Timeout each attempt after 90 seconds
                            echo "Attempt #${env.RETRY_COUNT}: Connecting to external resource..."

                            // Simulated command: Replace with real connection command
                            sh '''
                                echo "Trying to connect..."
                                sleep 100  # Simulate a long-running connection (100 seconds)
                                echo "Connection failed!"
                                exit 1    # Simulate failure for retry
                            '''
                        }
                    }
                }
            }
        }
    }

    post {
        success {
            echo "Connection successful after ${env.RETRY_COUNT} attempt(s)!"
        }
        failure {
            echo "Connection failed after ${env.RETRY_COUNT} attempt(s)."
        }
    }
}
