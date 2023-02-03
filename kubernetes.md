# Install Kubernetes on Ubuntu 18.04

Quick guide to install Kubernetes via Minikube on Ubuntu 18.04.

## 1. Install kubectl
Install kubectl, the kubernetes command line tool.

```bash
sudo apt-get update && \
  sudo apt-get install -y apt-transport-https && \
  curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - && \
  sudo touch /etc/apt/sources.list.d/kubernetes.list && \
  echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list && \
  sudo apt-get update && \
  sudo apt-get install -y kubectl
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
