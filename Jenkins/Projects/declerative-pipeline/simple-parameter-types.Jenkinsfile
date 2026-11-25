pipeline{
    agent any

    parameters{
        text(name: 'multiline', defaultValue: 'This is a default multiline value for the parameter')

        booleanParam(name: 'isAdmin', defaultValue: false, description: 'Whether or not the current user is admin')

        choice(name: 'targetEnvironment', choices: ['dev', 'staging', 'qa', 'production'], description: "The target environment")
    }

    stages{
        stage('pre-flight'){
            steps{
                echo "Text: ${params.multiline}"
                echo "Is current user admin? ${params.isAdmin ? 'Yes' : 'No'}"
                echo "Target environment: ${params.targetEnvironment}"
            }
        }
    }
}