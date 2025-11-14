pipeline {
    agent any

    stages {
        stage('Clonar Projeto') {
            steps {
                git 'https://github.com/Vinicius-Infra/pipeline-multiplataforma.git'
            }
        }

        stage('Build Docker') {
            steps {
                sh 'docker build -t vinicius994/pipeline-multiplataforma:latest .'
            }
        }

        stage('Push para Docker Hub') {
            steps {
                withCredentials([string(credentialsId: 'dockerhub-token', variable: 'TOKEN')]) {
                    sh 'echo $TOKEN | docker login -u "vinicius994" --password-stdin'
                    sh 'docker push vinicius994/pipeline-multiplataforma:latest'
                }
            }
        }
    }
}
