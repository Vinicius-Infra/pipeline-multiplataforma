pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'git@github.com:Vinicius-Infra/pipeline-multiplataforma'
            }
        }

        stage('Build') {
            steps {
                sh 'echo "Executando build..."'
                sh 'node -v'
            }
        }

        stage('Test') {
            steps {
                sh 'echo "Testando endpoint..."'
                sh 'curl http://localhost:3000 || true'
            }
        }
    }
}
