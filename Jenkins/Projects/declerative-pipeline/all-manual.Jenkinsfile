pipeline{
    agent any

    stages{
        stage("static-analysis"){
            steps{
                echo 'static-analysis'

                script{
                    def number = input(
                         message: "Have you performed static analysis and that has resulted in no High or Critical issues?", 
                        parameters: [
                            string(name: 'Value', description: 'Enter a value equally divisible by three.')
                        ]
                    )

                    def num = number.toInteger()

                    if (num % 3 == 0){
                        echo "Divisible by three"
                    }else{
                        error "Not divisible by three"
                    }
                }
            }
        }
        stage("build"){
            steps{
                echo 'build'
            }
        }
        stage("unit test"){
            steps{
                echo 'unit test'
            }
        }
        stage("package"){
            steps{
                echo 'package'
            }
        }
    }
}