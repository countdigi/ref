# Aggregator for CS (Computer Science)

IAM = Identity and Access Management
IRSA - IAM Roles for Service Accounts
STS - Secure Token Service

- Compute Optimized - c5.large (2/4  @ 0.085), c5.xlarge (4/8  @ 0.17)
- General Purpose   - m5.large (2/8  @ 0.096), m5.xlarge (4/16 @ 0.192), m5.2xlarge (8/32 @ 0.384)
- Memory Optimized  - r5.large (2/16 @ 0.126), r5.xlarge (4/32 @ 0.252)

 The instances in the public subnet can send outbound traffic directly to the internet, whereas the instances in the private subnet can't. Instead, the instances in the private subnet can access the internet by using a network address translation (NAT) gateway that resides in the public subnet.

# 172.16.0.0 /12 (172.16.0.0 - 172.31.255.255)

EKS ClusterIP 10.100.0.0

S3 Buckets:
- usf-hii-niddk-teddy
- usf-hii-s3logs
- usf-hii-terraform-state


## AWS / EKS

### Auto Scaling Spot Instances

- <https://ec2spotworkshops.com/using_ec2_spot_instances_with_eks/040_eksmanagednodegroupswithspot/spotlifecycle.html>
- Capacity Optimized - Launch Spot Instances from the most-available spare capacity pools.
- Capacity Rebalance - helps EKS managed node groups manage the lifecycle of the Spot Instance by proactively replacing instances that are at higher risk of being interrupted (Not good for batch jobs IMO)

### Security

Authentication
1. kubectl passes AWS Identity to k8s
2. k8s verifies AWS Identity with AWS IAM
3. k8s authorizes AWS Identity with k8s RBAC
4. k8s action allowed/denied

### Auto Scaler

Create an IAM OIDC provider for your cluster
- EKS Cluster / Configuration / Details
  - Get OpenID Connect Provider URL (<https://oidc.eks.us-east-2.amazonaws.com/id/FA30D0E6E10D24C887041314829FCBA6>)
  - OpenID Thumbprint - <https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_oidc_verify-thumbprint.html>

https://aws.amazon.com/blogs/opensource/introducing-fine-grained-iam-roles-service-accounts/


------------------------------------------------------------------------------------------------------------------------------------

## AWS / Load Balancing

ALB - Application Load Balancer - L7
NLB - Network Load Balancer - L4
ELB - Elastic Load Balancer - Mixed (Deprecated)

AWS Load Balancer Controller (for EKS)
- Ingress Groups
- Enhanced NLB support with IP Targets

------------------------------------------------------------------------------------------------------------------------------------


## AWS / ARN

Amazon Resource Names (ARNs) - Uniquely identify AWS resources. Required when necessary to specify a resource unambiguously across all of AWS, such as in IAM policies, Amazon RDS, and API calls.

Formats:
  - `arn:partition:service:region:account-id:resource-id`
  - `arn:partition:service:region:account-id:resource-type/resource-id`
  - `arn:partition:service:region:account-id:resource-type:resource-id`
Example:
  - ARN: `arn:aws:iam::099887848746:role/bravo-yhEUOtjp20220127183344412000000002`
    - partition: `aws`
    - service: `iam`
    - region: `<none>`
    - account-id: `099887848746`
    - resource-type: `role`
    - resource-id: `bravo-yhEUOtjp20220127183344412000000002`

------------------------------------------------------------------------------------------------------------------------------------

## K8s - Taints / Affinity

### Taints (Assigned on Nodes / Applied to Pods)

### Affinity Rules (Assigned on Pods / Applied to Nodes)

------------------------------------------------------------------------------------------------------------------------------------

## K8s - Service Account

Kubernetes resources, created/managed using K8s API, meant to be used by in-cluster K8s-created entities, such as Pods,
to authenticate to the K8s API server or external services (e.g. AWS S3).

A RoleBinding associates a Service Account with a Role.

### Standard service account credentials

Mounts a static long-lived credential for the service account into the Pod.

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: POD_NAME
  namespace: NAMESPACE_NAME
spec:
  serviceAccountName: KSA_NAME
```

### Service account token volume projection

Mounts a short-lived, automatically rotating Kubernetes service account token into the Pod. This token is a OpenID Connect Token and can be used to authenticate to the Kubernetes API and other external services.

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: POD_NAME
  namespace: NAMESPACE_NAME
spec:
  containers:
  - image: CONTAINER_NAME
    name: CONTAINER_NAME
    volumeMounts:
    - mountPath: /var/run/secrets/tokens
      name: KSA_NAME_TOKEN
  serviceAccountName: KSA_NAME
  volumes:
  - name: KSA_NAME_TOKEN
    projected:
      sources:
      - serviceAccountToken:
          path: KSA_NAME_TOKEN
          expirationSeconds: 86400
          audience: some-oidc-audience
```

------------------------------------------------------------------------------------------------------------------------------------

## OAuth 2.0

A security standard where you give one application permission to access your data in another application.

Instead of giving them your username and password, you give them a key that gives them specific permission to access you data or do things on your behalf in another application.

The steps to do something are referred to as authorization or delegated authorization.

Also you can take back that key whenever you wish.

- Resource Owner - The owner of the identity
- Client - The application that wants to access data or perform actions on behalf of the Resource Owner
- Authorization Server - The application that already knows the Resource Owner
- Resource Server - The API/Service the Client wants to use on behalf of the Resource Owner
- Redirect URI (Callback URL) - The URL the Authorization Server will redirect the Resource Owner back to after granting permission to the Client
- Response Type - The type of information the Client expects to receive (most common type is Code (Authorization Code))
- Scope - The granular permissions the Client wants
- Consent - The Authorization Server takes the Scopes the Client is requesting and verifies with the Resource Owner whether the want to give the Client permission
- Client ID - Identifies the Client with the Authorization Server
- Client Secret - A secret that only the Client and the Authorization Server know
- Authorization Code - A short-lived temporary code the Authorization Server sends back to the Client - The Client then sends the Authorization Code back to the Authorization Server with the Client Secret in exchange for an Access Token
- Access Token - A key the Client will communicate with from that point on with the Resource Server

OAuth 2.0 Flow
- Bob (Resource Owner) wants to allow Pun-of-the-Day (Client) to access his Contacts on GMail (Resource Server)
- The Client redirects Bob's browser to GMail (Authorization Server - Note: this could be a 3rd party) with:
  - Client Id
  - Redirect URI
  - Response Type
  - Scope
- The Authorization Server authenticates Bob and presents Bob with the Scopes requested to Allow/Deny
- The Authorization Server redirects back to the Client along with a temporary Authorization Code
- The Client then contacts the Authorization Server directly sending the Authorization Code, Client ID, and Client Secret
- The Authorization Server verifies the data and responds with an Access Token
- The Client uses the Access Token to send requests to the Resource Server
- Notes
  - The Client and Authorization Server established a relationship long-before this Flow
  - The Authorization Server generated a Client ID (App ID) and Client Secret (App Secret) and gave them to the Client to use for all future OAuth Exchanges

## OpenID Connect

OIDC is a thin-layer that sits on top of OAuth 2.0 that adds functionality around login and profile.

Instead of a key, OIDC is like giving the Client a badge which grants it permissions but also provides basic information about who the Resource Owner is.

When an Authorization Server


------------------------------------------------------------------------------------------------------------------------------------

## GitOps

GitOps assumes that every piece of infrastructure is represented as a file stored in a revision control system, and there is an automated process that seamlessly applies changes to the application runtime environment.

Kubernetes enables GitOps by fully embracing declarative APIs as its primary mode of operation and providing the controller patterns and backend framework necessary to implement those APIs.

The system was designed with the principles of declarative specifications and eventual consistency and convergence from its inception.

Unlike traditional systems, in Kubernetes there are almost no APIs that can modify only a subset of some existing resources.

For example, there is no API that changes only the container image of a Pod. Instead, the Kubernetes API server expects all API requests to provide a complete manifest of the resource to the API server. It was an intentional decision not to give any convenience APIs to users. As a result, Kubernetes users are essentially forced into a declarative mode of operation, which leads these same users to the need to store these declarative specifications somewhere. Git became the natural medium to store these specifications, and GitOps then became the natural delivery tool to deploy these manifests from Git.


------------------------------------------------------------------------------------------------------------------------------------


## Argo

```
kubectl get wf,cwf,cwft,wftmpl -o yaml > backup.yaml
```

Download Argo Client:
- <https://github.com/argoproj/argo-workflows/releases/tag/v3.2.7>

Download Argo Workflows Manifests:
- <https://raw/githubusercontent.com/argoproj/argo/master/manifests/quick-start-postgres.yaml>

```
$ kubectl -n argo apply -f quick-start-postgres.yaml

customresourcedefinition.apiextensions.k8s.io/clusterworkflowtemplates.argoproj.io created
customresourcedefinition.apiextensions.k8s.io/cronworkflows.argoproj.io created
customresourcedefinition.apiextensions.k8s.io/workfloweventbindings.argoproj.io created
customresourcedefinition.apiextensions.k8s.io/workflows.argoproj.io created
customresourcedefinition.apiextensions.k8s.io/workflowtasksets.argoproj.io created
customresourcedefinition.apiextensions.k8s.io/workflowtemplates.argoproj.io created
serviceaccount/argo created
serviceaccount/argo-server created
serviceaccount/github.com created
role.rbac.authorization.k8s.io/argo-role created
role.rbac.authorization.k8s.io/argo-server-role created
role.rbac.authorization.k8s.io/submit-workflow-template created
role.rbac.authorization.k8s.io/workflow-role created
clusterrole.rbac.authorization.k8s.io/argo-clusterworkflowtemplate-role created
clusterrole.rbac.authorization.k8s.io/argo-server-clusterworkflowtemplate-role created
clusterrole.rbac.authorization.k8s.io/kubelet-executor created
rolebinding.rbac.authorization.k8s.io/argo-binding created
rolebinding.rbac.authorization.k8s.io/argo-server-binding created
rolebinding.rbac.authorization.k8s.io/github.com created
rolebinding.rbac.authorization.k8s.io/workflow-default-binding created
clusterrolebinding.rbac.authorization.k8s.io/argo-clusterworkflowtemplate-role-binding created
clusterrolebinding.rbac.authorization.k8s.io/argo-server-clusterworkflowtemplate-role-binding created
clusterrolebinding.rbac.authorization.k8s.io/kubelet-executor-default created
configmap/artifact-repositories created
configmap/workflow-controller-configmap created
secret/argo-postgres-config created
secret/argo-server-sso created
secret/argo-workflows-webhook-clients created
secret/my-minio-cred created
service/argo-server created
service/minio created
service/postgres created
service/workflow-controller-metrics created
deployment.apps/argo-server created
deployment.apps/minio created
deployment.apps/postgres created
deployment.apps/workflow-controller created
```


beta.kubernetes.io/instance-type: t3a.small

eks.amazonaws.com/capacityType=ON_DEMAND

```
spec:
  nodeSelector:
    eks.amazonaws.com/capacityType: ON_DEMAND
```


------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------
