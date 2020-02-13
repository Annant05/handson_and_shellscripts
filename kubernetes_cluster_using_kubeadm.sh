#steps to create a kubernetes cluster using kubeadm 
# 1) install docker or any conatiner engine on all the nodes includeing master and worker.
sudo apt-get update -y 
sudo apt-get install -y docker.io
# sudo apt-get install -y \
#     apt-transport-https \
#     ca-certificates \
#     curl \
#     gnupg-agent \
#     software-properties-common
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# sudo apt-key fingerprint 0EBFCD88
# sudo apt-get update -y 
# sudo apt-get install -y  docker-ce docker-ce-cli containerd.io

# 2) install kubectl, kubeadm and kubelet.
sudo apt-get update && sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update -y 
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

# 3) on master node do initialization 
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=10.0.3.20

# 4) on the worker node run the join command 
# it will be output by the master command in step 3 
# similar to this command. here 10.0.3.20 is the ip of master node 
sudo kubeadm join 10.0.3.20:6443 --token hq6z34.lywx8ymiyeronodi \
    --discovery-token-ca-cert-hash sha256:26ed852ef77adc09c3ea7ce6da0f58999fb3aa0bf90a2750e1b869ef76f96dad 



# 5) Before checking for nodes using kubectl get nodes 
# run the following command on the master node as a non-sudo user 

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# 6) Now run kubectl get nodes try sudo if it does not work
kubectl get nodes

# 7) Get nodes into the ready state by running the following command on the master node.
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/2140ac876ef134e0ed5af15c65e414cf26827915/Documentation/kube-flannel.yml