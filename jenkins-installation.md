
# Install Jenkins on Ubuntu


```bash
docker run -p 8080:8080 -v /var/run/docker.sock:/var/run/docker.sock --name jenkins jenkins/jenkins:lts
```
## exec to jenkins container

```bash
docker exec -it -u root jenkins bash
```
## install docker in docker
```bash
apt-get update && \
apt-get -y install apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common && \
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey && \
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable" && \
apt-get update && \
apt-get -y install docker-ce
```
## Docker ps inside jenkins container
```bash
docker ps
```
## Docker ps inside jenkins container
```bash
exit
```
## execute below in vm
```bash
sudo chmod 777 /var/run/docker.sock
```
