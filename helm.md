```sh
curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
```
```sh
sudo apt-get install apt-transport-https --yes
```
```sh
echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
```
```sh
sudo apt-get update
```
```sh
sudo apt-get install helm
```
