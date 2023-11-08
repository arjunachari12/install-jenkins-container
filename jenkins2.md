# Install Jenkins on Ubuntu

## 1. Create docker network

```bash
docker network create jenkins
```
## 2. create dockerfile add below content
### Create folder called jenkins
```bash
mkdir jenkins
cd jenkins
vi Dockerfile
```
### Add below content into Dockerfile
```bash
FROM jenkins/jenkins:2.361.2-jdk11
USER root
RUN apt-get update && apt-get install -y lsb-release
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y docker-ce-cli
USER jenkins
RUN jenkins-plugin-cli --plugins "blueocean:1.25.8 docker-workflow:521.v1a_a_dd2073b_2e"
```
## 3. Create image

```bash
docker build -t myjenkins-blueocean:2.361.2-1 .
```
## 4. Install Dind

```bash
docker run   --name jenkins-docker   --rm   --detach   --privileged   --network jenkins   --network-alias docker   --env DOCKER_TLS_CERTDIR=/certs   --volume jenkins-docker-certs:/certs/client   --volume jenkins-data:/var/jenkins_home   --publish 2376:2376   --publish 3000:3000 --publish 5000:5000   docker:dind   --storage-driver overlay2
```

## 5. Install Jenkins

```bash
docker run   --name jenkins-blueocean   --detach   --network jenkins   --env DOCKER_HOST=tcp://docker:2376   --env DOCKER_CERT_PATH=/certs/client   --env DOCKER_TLS_VERIFY=1   --publish 8080:8080   --publish 50000:50000   --volume jenkins-data:/var/jenkins_home   --volume jenkins-docker-certs:/certs/client:ro   --volume "$HOME":/home   --restart=on-failure   --env JAVA_OPTS="-Dhudson.plugins.git.GitSCM.ALLOW_LOCAL_CHECKOUT=true"   myjenkins-blueocean:2.361.2-1
```
## 5. Access Jenkins

```bash
http://localhost:8080
```
## 5. Get Jenkins password

```bash
docker logs jenkins-blueocean
```
