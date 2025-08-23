pipeline{
    agent {label "bank_dev"};
    stages{
        stage("Clone"){
            steps{
                git url: "https://github.com/AtharvKarpe-AK/Springboot-BankApp-Atharv", branch: "DevOps"
            echo "Code clone ho gaya"
            }
        }
        stage("Build"){
            steps{
                sh "docker build -t bank_app1 ."
                echo "Code build ho gaya"
            }
        }
        stage("Test"){
            steps{
                echo "Test bhi ho gaya"
            }
        }
        
        stage("Push"){
            steps{
                withCredentials([usernamePassword(credentialsId: "DockerHubCreds", passwordVariable: "dockerHubPass", usernameVariable: "dockerHubUser")]){
                    sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPass}"
                    sh "docker image tag bank_app1 ${env.dockerHubUser}/bank_app1"
                    sh "docker push ${env.dockerHubUser}/bank_app1"
                }
            }
        }

        stage("Deploy"){
            steps{
                sh "docker compose up -d --build bankapp"
                echo "code deploy ho gaya"
            }
        }
        stage("Clean"){
            steps{
                sh "docker system prune -a --force"
                echo "Cleanup completed"
            }
        }
    }
}
