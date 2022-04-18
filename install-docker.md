# Update the apt package index and install packages to allow apt to use a repository over HTTPS:
```bash 
sudo apt-get update
```

```bash 
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
```
# Add Docker’s official GPG key:
```bash 
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
```
# Use the following command to set up the stable repository
```bash 
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```
# Install Docker Engine
```bash 
sudo apt-get update
```
```bash 
sudo apt-get install docker-ce docker-ce-cli containerd.io
```
# Test installation by running hello-world container
```bash
sudo docker run hello-world
```

# Adding ubuntu user to the "docker" group
```bash
sudo usermod -a -G docker ubuntu
```
