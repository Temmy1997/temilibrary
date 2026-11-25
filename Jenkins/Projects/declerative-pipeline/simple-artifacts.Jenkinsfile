pipeline{
    agent any

    environment{
        ARTIFACT_SOURCE_DIRECTORY = "tests/*.xml"
    }
    stages{
        stage('Build'){
            steps{
                echo 'Build the code'
            }
        }
        stage('Test'){
            steps{
                echo 'Execute unit tests'
                sh 'mkdir -p tests && echo "test results" > tests/testresults.xml'
                error "Broken tests break the build"
            }
        }
    }
    post{
        always{
            archiveArtifacts artifacts: ARTIFACT_SOURCE_DIRECTORY, followSymlinks: false
        }
    }
}