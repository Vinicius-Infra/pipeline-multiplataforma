pipeline {
    agent any

    environment {
        GIT_REPO = 'git@github.com:Vinicius-Infra/pipeline-multi.git'
        IMAGE_NAME = 'multi-app:latest'
        GITLAB_REGISTRY = 'registry.gitlab.com'
        GITLAB_IMAGE = 'registry.gitlab.com/SEU_GITLAB_USER/SEU_REPO/multi-app:latest'
        GITLAB_CRED = 'gitlab-registry'  // ID da credencial criada no Jenkins
    }

    stages {

        stage('Checkout GitHub') {
            steps {
                git url: "${GIT_REPO}", branch: 'main', credentialsId: 'github-ssh'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh """
                    docker build -t ${IMAGE_NAME} .
                """
            }
        }

        stage('Login no GitLab Registry') {
            steps {
                withCredentials([usernamePassword(credentialsId: "${GITLAB_CRED}", usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh """
                        echo "$PASS" | docker login ${GITLAB_REGISTRY} -u "$USER" --password-stdin
                    """
                }
            }
        }

        stage('Push para GitLab Registry') {
            steps {
                sh """
                    docker tag ${IMAGE_NAME} ${GITLAB_IMAGE}
                    docker push ${GITLAB_IMAGE}
                """
            }
        }
    }
}
