pipeline{
    agent {label "dev-bank-app"};
    stages{
        stage("Clone_Code"){
            steps{
                git url: "https://github.com/AtharvKarpe-AK/Springboot-BankApp-Atharv", branch: "DevOps"
                echo "Code clone ho gaya"

            }
        }
        stage("Build"){
            steps{
                sh "docker build --no-cache -t bank-app ."
                echo "Image Build ho gayi"
            }
        }
        stage("test"){
            steps{
                echo "Testing ho gayi"
            }
        }
        
        stage("push"){
            steps{
                withCredentials([usernamePassword(
                    credentialsId: "DockerHubCreds",
                    passwordVariable: "dockerHubPass",
                    usernameVariable: "dockerHubUser")]){
                        
                        sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPass}"
                        sh "docker image tag bank-app ${env.dockerHubUser}/bank-app:latest"
                        sh "docker push  ${env.dockerHubUser}/bank-app:latest"
                    }
                echo "Image push ho gaya"
            }
        }
        stage("Deploy"){
            steps{
                
                sh "docker compose down"
                sh "docker compose up -d --build bankapp"
                echo "Application deploy ho gaya"
            }
        }
        stage("Cleanup"){
            steps{
                echo "Cleanup unused containers and images"
                sh "docker system prune -af --volumes"
                sh "docker container prune -f"
                sh "docker image prune -af"
                echo "All cleanup ho gaya...."
            }    
        }
    }
}
