FROM jenkins/jenkins:lts

# habilita modo root
USER root

# Instala Docker dentro do container
RUN apt-get update && \
    apt-get install -y docker.io && \
    usermod -aG docker jenkins

# Volta para o usuário padrão
USER jenkins

