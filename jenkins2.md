# Install Jenkins on Ubuntu

Quick guide to install Kubernetes via Minikube on Ubuntu 18.04.

## 1. Create docker network

```bash
docker network create jenkins
```

## 2. Install Jenkins

```bash
docker run --name jenkins-docker --rm --detach \
  --privileged --network jenkins --network-alias docker \
  --env DOCKER_TLS_CERTDIR=/certs \
  --volume jenkins-docker-certs:/certs/client \
  --volume jenkins-data:/var/jenkins_home \
  --publish 2376:2376 \
  docker:dind --storage-driver overlay2
```
