```bash
docker run -d --name sonarqube-article -p 9000:9000 sonarqube
```
```bash
Open in browser http://localhost:9000
login to SonarQube with the default admin user and admin password
```
```bash
install sonarqube plugin in jenkins
```
```bash
docker exec -it -u root jenkins-blueocean bash
cd /var/jenkins_home
mkdir sonar-scanner
cd sonar-scanner
apt install wget
wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-3.3.0.1492-linux.zip
unzip sonar-scanner-cli-3.3.0.1492-linux.zip
cd sonar-scanner-cli-3.3.0.1492-linux
pwd //copy path
exit
```
```bash
add above path under jenkins Manage Jenkins > Global Tool Configuration > SonarQube Scanner
as 
SONAR_RUNNER_HOME
```
```bash
add EC2 public ip 
add webhook in SonarQube to point to Jenkins (Administration > Configuration > Webhooks); URL will be in the format http://<host_ip>:8080/sonarqube-webhook  

```
```bash
in SonarQube, generate an access token that will be used by Jenkins (My Account > Security > Tokens
```
```bash
