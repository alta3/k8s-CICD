cd ~/git/kubernetes-the-alta3-way
python3 -m pip install dnspython
ansible-playbook -i hosts.yml main.yml
cd ~/
fping -A controller-1 controller-2 controller-3 node-1 node-2 node-3
echo 'source <(kubectl completion bash)' >> ~/.bashrc
source ~/.bashrc
cp ~/k8s-CICD/k8s-config/containerd_config.toml ~/containerd_config.toml
cp ~/k8s-CICD/k8s-config/containerd_update.yaml ~/containerd_update.yaml
cp ~/k8s-CICD/k8s-config/node-hosts.txt ~/node-hosts.txt
ansible-playbook -i node-hosts.txt containerd_update.yaml
cp ~/k8s-CICD/k8s-manifests/my_first_pod.yaml ~/my_first_pod.yaml
kubectl apply -f my_first_pod.yaml
kubectl get pods
sleep 30
kubectl delete -f my_first_pod.yaml

