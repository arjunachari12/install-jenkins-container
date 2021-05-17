1.Go to your cmd run this command


docker run -p 8080:8080 -v /var/run/docker.sock:/var/run/docker.sock --name jenkins jenkins/jenkins:lts

we will get an initial admin password do the jenkins installation steps

After completion of jenkins installation

2.To enter into your docker image run this command

docker exec -it -u root jenkins bash

3.install docker in docker

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
now you will be inside your docker and run '''docker ps''' you will get something like this

root@cf1fd5908a1c:/# docker ps
CONTAINER ID        IMAGE                 COMMAND                  CREATED             STATUS              PORTS                               NAMES
cf1fd5908a1c        jenkins/jenkins:lts   "/sbin/tini -- /usr/…"   2 hours ago         Up 12 minutes       0.0.0.0:8080->8080/tcp, 50000/tcp   jenkins
root@cf1fd5908a1c:/#   
this means you have succesfully created the image

Now to give jenkins actions access to all users for that run this command

chmod 777 /var/run/docker.sock
