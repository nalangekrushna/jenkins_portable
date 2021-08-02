FROM jenkins/jenkins:lts-jdk11
USER root
RUN apt update && apt install -y apt-transport-https ca-certificates curl gnupg2 \
       software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88
RUN add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/debian \
       $(lsb_release -cs) stable"
RUN apt update && apt install -y docker-ce-cli
USER jenkins
# RUN jenkins-plugin-cli --plugins "blueocean:1.24.6 docker-workflow:1.26"
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/plugins.txt

ENV JENKINS_USER admin
ENV JENKINS_PASS admin

ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

COPY default-user.groovy /usr/share/jenkins/ref/init.groovy.d/
ENV JENKINS_URL http://localhost:8080/