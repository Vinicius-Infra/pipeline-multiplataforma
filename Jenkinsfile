pipeline {
    agent any

    environment {
        IMAGE = "vinicius994/pipeline-multiplataforma"
    }

    stages {

        stage('Clonar Projeto') {
            steps {
                git branch: 'main', url: 'https://github.com/Vinicius-Infra/pipeline-multiplataforma.git'
            }
        }

        stage('Build Docker') {
            steps {
                sh '''
                    echo "Construindo imagem Docker..."
                    docker build -t $IMAGE:latest .
                '''
            }
        }

        stage('Login no Docker Hub') {
            steps {
                withCredentials([string(credentialsId: 'dockerhub-token', variable: 'TOKEN')]) {
                    sh '''
                        echo "Realizando login no Docker Hub..."
                        echo $TOKEN | docker login -u "vinicius994" --password-stdin
                    '''
                }
            }
        }

        stage('Push para Docker Hub') {
            steps {
                sh '''
                    echo "Enviando imagem para Docker Hub..."
                    docker push $IMAGE:latest
                '''
            }
        }
    }
}
