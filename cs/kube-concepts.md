# Kubernetes Concepts

## Overview

Kubernetes (K8s) is a *Portable*, *Extensible*, *Open-source* platform for managing
*containerized* workloads and services that facilitates both declaritaive configuration and automation.

- Pod
  - Smallest unit of K8s
  - Abstraction over container
  - Usually 1 app per pod
  - Each pod gets its own IP address
- Service
  - Permanent IP address pointing to one or more pod
  - Internal
  - External
- Ingress
  - Forwards to a service
- Worker Node
  - Contains the following components
    - Kubelet
      - Interacts with both the container and the node
      - Starts the pod with a container inside
    - Kube Proxy
      - Make sure pods can communicate to other pods (inter-node or intra-node)
    - Container Runtime
- Master Node
  - API Server
  - Scheduler (Where to put the pod)
  - Controller Manager (Detect and reschedule pods)
  - Key Value Store (etcd)

- Namespaces
- StatefulSets
- ReplicaSet
- Roles
- Deployments
- DaemonSet
- Jobs/Cronjobs

- Extensions
  - CRD - Custom Resource Definition
  - CRI - Container Runtime Interface
  - CNI - Container Network Interface
  - CSI - Container Storage Interface

## Notes

- RBAC - Role-Based Access Control
- Every request  to k8s is first authenticated - authentication provides the identity of the caller issuing the request
- Every request in k8s is associated with some identity
- K8s uses generic interface for auth providers - auth providers include:
  - x509 certs
  - static token files on the host
  - Cloud auth providers like Azure AD and AWS IAM
  - Authentication webhooks
- Role/RoleBinding (restricted to namespace)
- CluserRole/ClusterRoleBinding
- Built-in roles
  - cluster-admin - complete access to the entire cluster
  - admin - complete access to a namespace
  - edit - modify things in a namespace
  - view - read-only access to a namespace

- Resources
  - K,M,G,T are power of 10
  - Ki,Mi,Gi,Ti are power of 2
  - m is milli - so 4m of memory is literally 0.4 bytes


- Herding pods: taints, tolerations and affinity in kubernetes
  - <https://medium.com/@betz.mark/herding-pods-taints-tolerations-and-affinity-in-kubernetes-2279cef1f982>
    - Taints
      - Once a node is tainted, pods that do not declare a toleration for the taint will not be scheduled to that node
      - Depending on the strength of the taint, the prohibition may be soft or hard and running pods that do not tolerate may be evicted
      - `kubectl taint nodes nodename key=value:effect`
      - Effects can be `NoSchedule`, `PreferNoSchedule`, `NoExecute`
      - E.g., `spotinstance: "true:PreferNoSchedule"` - would try not to schedule
    - Node Affinity - a propery of Pods that attracts them to a set of nodes (either as preference or hard requirement)
      - `requiredDuringSchedulingIgnoredDuringExecution` (hard)
      - `preferredDuringSchedulingIgnoredDuringExecution` (soft)
    - Inter-pod Affinity/Anti-affinity
      - Allow you to constrain which nodes your pod is eligible to be scheduled based on labels on pods that are already running on the node rather than based on labels on nodes.



MemoryInfo.SizeInMiB 16384
VCpuInfo.DefaultVCpus

