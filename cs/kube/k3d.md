# K3D

- A lightweight wrapper to run k3s (Rancher Lab’s minimal Kubernetes distribution) in docker.
- Community-driven project, that is supported by Rancher (SUSE) and it’s not an official Rancher (SUSE) product.

Note: k3d v5.x.x requires at least Docker v20.10.4 to work properly

Installing k3d on deckard

```
sudo apt-get update

sudo apt-get install     ca-certificates     curl     gnupg     lsb-release

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg]" \
     "https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
     | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get install docker-ce docker-ce-cli containerd.io

curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash

k3d cluster create tst01

v=$(kubectl version -o json |  jq -r .serverVersion.gitVersion | sed 's|\+.*||')

curl -LO "https://dl.k8s.io/release/$v/bin/linux/amd64/kubectl"

sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

$ docker container ls
70f7cf1f8ec4 rancher/k3d-proxy:5.2.2  "/bin/sh -c nginx-pr…"   80/tcp, 0.0.0.0:38593->6443/tcp k3d-tst01-serverlb
0c0e5ce11dc4 rancher/k3s:v1.21.7-k3s1 "/bin/k3d-entrypoint…"                                   k3d-tst01-server-0

$ kubectl get po --all-namespaces --field-selector=status.phase=Running
NAMESPACE     NAME                                      READY   STATUS    RESTARTS   AGE
kube-system   metrics-server-86cbb8457f-4cztn           1/1     Running   0          78m
kube-system   coredns-7448499f4d-zqnrd                  1/1     Running   0          78m
kube-system   local-path-provisioner-5ff76fc89d-h8qqc   1/1     Running   0          78m
kube-system   svclb-traefik-h9w4f                       2/2     Running   0          78m
kube-system   traefik-6b84f7cbc-bz6g2                   1/1     Running   0          78m

```

#  -o jsonpath='{.items[*].metadata.labels.version}'
# kubectl get pods --field-selector=status.phase=Running
