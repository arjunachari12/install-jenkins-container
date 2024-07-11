# Install Kubernetes on Ubuntu 18.04

Quick guide to install Kubernetes via Minikube on Ubuntu 18.04.

## 1. Install kubectl
Install kubectl, the kubernetes command line tool.

```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
```
```bash
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client
```

## 2. Install Minikube
Install Minikube to run your single node kubernetes cluster.

```bash
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
  && chmod +x minikube && \
  sudo cp minikube /usr/local/bin && rm minikube
```

## 3. Done!
You can run Minikube and start your cluster by running:

```bash
minikube start
```

You can then see that it is running:

```bash
kubectl get nodes
```
```enable autocomplete
source <(kubectl completion bash)
echo "source <(kubectl completion bash)" >> ~/.bashrc
alias k=kubectl
complete -F __start_kubectl k
```


Yay!
