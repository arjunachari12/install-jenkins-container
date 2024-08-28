```sh
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
```
```sh
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
```
```sh

sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" 
```
```sh

sudo apt-get update && sudo apt-get install terraform
```
```sh

terraform -help
```


