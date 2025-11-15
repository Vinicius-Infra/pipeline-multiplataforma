# Pipeline Multiplataforma: Jenkins + GitHub + Docker Hub

Este projeto demonstra um **pipeline DevOps completo** usando Jenkins, GitHub e Docker Hub. Ele realiza:

1. **Clonagem do repositório no Jenkins**
2. **Build de uma imagem Docker**
3. **Push da imagem para o Docker Hub**

---

## **Pré-requisitos**

- Docker instalado no host
- Jenkins rodando (via Docker ou servidor próprio)
- Conta no GitHub e Docker Hub
- Git instalado

---

## **Estrutura do Projeto**

├── app.js # Aplicação Node.js de exemplo
├── Dockerfile # Dockerfile para build da imagem
└── Jenkinsfile # Pipeline do Jenkins


---

## **Configuração do Jenkins**

1. **Suba o Jenkins via Docker**:

```bash
docker run -d \
  --name jenkins \
  -p 8080:8080 -p 50000:50000 \
  -v jenkins_home:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  jenkins/jenkins:lts

##Recupere a senha inicial:
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword

##Adicione credenciais do Docker Hub:

Tipo: Secret Text

ID: dockerhub-token

Valor: seu Access Token do Docker Hub

##Jenkinsfile

pipeline {
    agent any

    stages {
        stage('Clonar Projeto') {
            steps {
               git branch: 'main', url: 'https://github.com/Vinicius-Infra/pipeline-multiplataforma.git'
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

## Dockerfile

FROM node:18-alpine
WORKDIR /app
COPY app.js .
CMD ["node", "app.js"]

## Explicação:

FROM node:18-alpine → imagem base leve com Node.js

WORKDIR /app → define diretório de trabalho

COPY app.js . → copia o arquivo para o container

CMD ["node", "app.js"] → comando que inicia a aplicação

## Rodando o pipeline

Commit e push do projeto no GitHub:

git add .
git commit -m "Adiciona Jenkinsfile e Dockerfile"
git push origin main

No Jenkins, crie um Pipeline Job apontando para o repositório.

Clique em Build Now.

Se tudo estiver correto, você verá a imagem sendo construída e enviada para o Docker Hub.

Autor

Vinícius Barreto


