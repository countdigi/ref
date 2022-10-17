# Kubernetes


- `activeDeadlineSeconds` - Duration in seconds relative to the StartTime that pod may be active on a node before the system actively tries to terminate the pod

$ kubectl get all --all-namespaces


kubectl get pods -o=jsonpath='{@}'

curl -L https://download.docker.com/linux/static/stable/x86_64/docker-${docker_version}.tgz | tar zxf - docker
chmod +x ./docker; sudo mv ./docker /usr/local/bin
```

Macintosh:
```
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64
chmod +x ./minikube; sudo mv ./minikube /usr/local/bin

curl -LO https://storage.googleapis.com/kubernetes-release/release/${kubectl_version}/bin/linux/amd64/kubectl
chmod +x ./kubectl; sudo mv ./kubectl /usr/local/bin

curl https://download.docker.com/mac/static/stable/x86_64/docker-${docker_version}.tgz | tar zxf - docker
chmod +x ./docker; sudo mv ./docker /usr/local/bin
```

Run minikube:
```
$ minikube start --vm-driver=kvm2
  minikube v1.2.0 on linux (amd64)
  Creating kvm2 VM (CPUs=2, Memory=2048MB, Disk=20000MB) ...
  Configuring environment for Kubernetes v1.15.0 on Docker 18.09.6
  Downloading kubeadm v1.15.0
  Downloading kubelet v1.15.0
  Pulling images ...
  Launching Kubernetes ...
  Verifying: apiserver proxy etcd scheduler controller dns
  Done! kubectl is now configured to use "minikube"
  For best results, install kubectl: https://kubernetes.io/docs/tasks/tools/install-kubectl/

$ minikube status
  host: Running
  kubelet: Running
  apiserver: Running
  kubectl: Correctly Configured: pointing to minikube-vm at 192.168.39.22

$ kubectl cluster-info
  Kubernetes master is running at https://192.168.39.22:8443
  KubeDNS is running at https://192.168.39.22:8443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

$ kubectl get all --all-namespaces
  NAMESPACE     NAME                                        READY   STATUS    RESTARTS   AGE
  kube-system   pod/coredns-5c98db65d4-9g8xs                1/1     Running   0          37m
  kube-system   pod/coredns-5c98db65d4-ggsn5                1/1     Running   0          37m
  kube-system   pod/etcd-minikube                           1/1     Running   0          36m
  kube-system   pod/kube-addon-manager-minikube             1/1     Running   0          36m
... etc.
```

Check kubectl config:
```
  cat ~/.kube/config
    apiVersion: v1
    clusters:
    - cluster:
        certificate-authority: /home/countskm/.minikube/ca.crt
        server: https://192.168.39.22:8443
      name: minikube
    contexts:
    - context:
        cluster: minikube
        user: minikube
      name: minikube
    current-context: minikube
    kind: Config
    preferences: {}
    users:
    - name: minikube
      user:
        client-certificate: /home/countskm/.minikube/client.crt
        client-key: /home/countskm/.minikube/client.key
```

Minikube dashboard:
```
minikube dashboard
```

Optional: Switch Dashboard Service to NodePort config:
```
$ kubectl get -n kube-system service kubernetes-dashboard -o yaml \
    | sed 's/type:.*/type: NodePort/'  | kubectl apply -f -

$ dashboard_ip=$(minikube  ip)

$ echo ${minikube_ip}
  192.168.39.22

$ dashboard_port=$(kubectl get -n kube-system service kubernetes-dashboard \
    -o go-template='{{(index .spec.ports 0).nodePort}}')

$ echo ${dashboard_port}
  31350

$ echo http://${dashboard_ip}:${dashboard_port}/
  http://192.168.39.22:31350/
```

Point to Docker in Minikube:
```
$ eval $(minikube docker-env)
```

Enable kubectl command-line completion:
```
$ source <(minikube completion bash)
```


## Notes

```

Kaniko demo
```
git clone https://github.com/vfarcic/kaniko-demo

cd kaniko-demo

kubectl apply --filename docker-socket.yaml

kubectl wait --for condition=containersready pod docker

kubectl exec -it docker -- sh

## Now inside docker container

apk add -U git

git clone https://github.com/vfarcic/kaniko-demo && cd kaniko-demo

docker image build --tag devops-toolkit .


```

k3s - lightweight kubernetes distribution made by Rancher


---

- PodSecurityPolicy
  - <https://kubernetes.io/docs/concepts/policy/pod-security-policy/>
  - apiVersion: policy/v1beta1
  - metadata:
    ```
    name: privileged
      annotations:
      seccomp.security.alpha.kubernetes.io/allowedProfileNames: '*'
    ```
  - spec:
    ```
    privileged: true
    allowPrivilegeEscalation: true
    allowedCapabilities: ["*"]
    volumes: ["*"]
    hostNetwork: true
    hostPorts: [{min: 0, max: 65535}]
    hostIPC: true
    hostPID: true
    runAsUser: {rule: "RunAsAny"}
    seLinux: {rule: "RunAsAny"}
    supplementalGroups: {rule: "RunAsAny"}
    fsGroup: {rule: "RunAsAny"}
    ```
This is an example of a restrictive policy that requires use





# vim: ft=markdown


