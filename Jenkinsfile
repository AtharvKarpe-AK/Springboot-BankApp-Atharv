pipeline {
    agent any;
    stages {
        stage("Code"){
            steps{
                git url:"https://github.com/AtharvKarpe-AK/Springboot-BankApp-Atharv.git", branch: "DevOps"
                echo "Clone successfull"
            }
        }
        stage("Build"){
            steps{
                sh "docker build -t atharvkarpe/bankapp:latest -f Dockerfile ."
                echo "Build successfull"
            }
        }
        stage("Test"){
            steps{
                echo "Test successfull"
            }
        }
        stage("Push"){
            steps{
                withCredentials([usernamePassword(credentialsId: "dockerhub-creds", passwordVariable: "dockerHubPass", usernameVariable: "dockerHubUser")]){
                    sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPass}"
                    sh "docker push atharvkarpe/bankapp:latest"
                }
            }
        }
        stage("cleanup"){
            steps{
                sh "docker image prune -f"
            }
        }
        stage("Deploy"){
            steps{
                sh "docker compose up -d --build bankapp"
                echo "Deploy successfull"
            }
        }
    }

    post {
        success {
            emailext body: 'Hello Atharv good news: Build Successful!',
            subject: 'Jenkins Build Successfull!',
            to: 'atharvkarpe588@gmail.com'
        }
        failure {
            emailext body: 'Hello Atharv bad news: Build failed!',
            subject: 'Jenkins Build failed!',
            to: 'atharvkarpe588@gmail.com'
        }
    }
    
}
