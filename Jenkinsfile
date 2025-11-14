pipeline {
    agent any
    stages {
        stage('Clonar GitHub') {
            steps {
                git 'https://github.com/SEU_USUARIO/pipeline-multi.git'
            }
        }
        stage('Build Docker') {
            steps {
                sh 'docker build -t multi-app:latest .'
            }
        }
        stage('Push para GitLab Registry') {
            steps {
                sh 'echo "" | docker login registry.gitlab.com -u "" --password-stdin'
                sh 'docker tag multi-app:latest registry.gitlab.com/SEU_USER/pipeline-multi/multi-app:latest'
                sh 'docker push registry.gitlab.com/SEU_USER/pipeline-multi/multi-app:latest'
            }
        }
    }
}
