# Update the apt package index and install packages to allow apt to use a repository over HTTPS:

```bash 
sudo apt-get update && \
    sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release -y
```

# Add Docker’s official GPG key and Use the following command to set up the stable repository
```bash 
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
```

# 
```bash 
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

# Install Docker Engine
```bash 
sudo apt-get update && sudo apt-get install docker-ce docker-ce-cli containerd.io -y
```

# Test installation by running hello-world container
```bash
sudo docker run hello-world
```

# Adding ubuntu user to the "docker" group
For AWS use below command
```bash
sudo usermod -a -G docker ubuntu
```

For Azure use below command
```bash
sudo usermod -a -G docker azureuser
```

# Restart Ubuntu VM
```bash
sudo reboot
```

# SSH to VM and Test installation by running hello-world container without sudo
```bash
docker run hello-world
```



