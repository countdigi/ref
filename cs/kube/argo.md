# Argo

<https://argoproj.github.io/argo-workflows>

Work Templates
- container set - allows you to run multiple containers in a single pod
- data template - allows you to get data from storage
- resource template - allow syou to create a k8s resource and wait for it to meet a condition (e.g. emr)
- script template - allows you to run a script in a container

DAG Template

## Concepts

### Workflow

The Workflow is the most important resource in Argo and serves two important functions:
- It defines the workflow to be executed.
- It stores the state of the workflow.
Because of these dual responsibilities, a Workflow should be treated as a "live" object.
It is not only a static definition, but is also an "instance" of said definition.

### Workflow Spec

The workflow to be executed is defined in the Workflow.spec field. The core structure of a Workflow spec is a list of templates and an entrypoint.

templates can be loosely thought of as "functions": they define instructions to be executed. The entrypoint field defines what the "main" function will be – that is, the template that will be executed first.

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Workflow
metadata:
  generateName: hello-world-  # Name of this Workflow
spec:
  entrypoint: whalesay        # Defines "whalesay" as the "main" template
  templates:
  - name: whalesay            # Defining the "whalesay" template
    container:
      image: docker/whalesay
      command: [cowsay]
      args: ["hello world"]
```

### Template Definitions

#### Container

Perhaps the most common template type, it will schedule a Container. The spec of the template is the same as the K8s container spec, so you can define a container here the same way you do anywhere else in K8s.

```yaml
  - name: whalesay
    container:
      image: docker/whalesay
      command: [cowsay]
      args: ["hello world"]
```

#### Script

A convenience wrapper around a container. The spec is the same as a container, but adds the source: field which allows you to define a script in-place. The script will be saved into a file and executed for you. The result of the script is automatically exported into an Argo variable either `{{tasks.<NAME>.outputs.result}}` or `{{steps.<NAME>.outputs.result}}`, depending how it was called.

```yaml
  - name: gen-random-int
    script:
      image: python:alpine3.6
      command: [python]
      source: |
        import random
        i = random.randint(1, 100)
        print(i)
```

#### Resource

Performs operations on cluster Resources directly. It can be used to get, create, apply, delete, replace, or patch resources on your cluster.  This example creates a ConfigMap resource on the cluster:

```yaml
  - name: k8s-owner-reference
    resource:
      action: create
      manifest: |
        apiVersion: v1
        kind: ConfigMap
        metadata:
          generateName: owned-eg-
        data:
          some: value
```

#### Suspend

A suspend template will suspend execution, either for a duration or until it is resumed manually. Suspend templates can be resumed from the CLI (with argo resume), the API endpoint, or the UI.

```yaml
  - name: delay
    suspend:
      duration: "20s"
```

### Template Invocators

#### Steps

```yaml
  - name: hello-hello-hello
    steps:
    - - name: step1
        template: prepare-data
    - - name: step2a
        template: run-data-first-half
      - name: step2b
        template: run-data-second-half
```

#### DAG

```yaml
  - name: diamond
    dag:
      tasks:
      - name: A
        template: echo
      - name: B
        dependencies: [A]
        template: echo
      - name: C
        dependencies: [A]
        template: echo
      - name: D
        dependencies: [B, C]
        template: echo
```

### Workflow Variables

There are two kinds of template tag:
- simple The default, e.g. `{{workflow.name}}`
- expression Where `{{` is immediately followed by `=`, e.g. `{{=workflow.name}}`

#### All Templates

- `inputs.parameters.<NAME>` - Input parameter to a template
- `inputs.parameters` - All input parameters to a template as a JSON string
- `inputs.artifacts.<NAME>` - Input artifact to a template

#### DAG Templates

`tasks.<TASKNAME>.id` - unique id of container task
`tasks.<TASKNAME>.ip` - IP address of a previous daemon container task
`tasks.<TASKNAME>.status` - Phase status of any previous task
`tasks.<TASKNAME>.exitCode` - Exit code of any previous script or container task
`tasks.<TASKNAME>.startedAt` - Timestamp when the task started
`tasks.<TASKNAME>.finishedAt` - Timestamp when the task finished
`tasks.<TASKNAME>.outputs.result` - Output result of any previous container or script task
`tasks.<TASKNAME>.outputs.parameters` - When the previous task uses 'withItems' or 'withParams', this contains a JSON array of the output parameter maps of each invocation
`tasks.<TASKNAME>.outputs.parameters.<NAME>` - Output parameter of any previous task. When the previous task uses 'withItems' or 'withParams', this contains a JSON array of the output parameter values of each invocation
`tasks.<TASKNAME>.outputs.artifacts.<NAME>` - Output artifact of any previous task

### Service Accounts

In order for Argo to support features such as artifacts, outputs, access to secrets, etc. it needs to communicate with Kubernetes resources using the Kubernetes API. To communicate with the Kubernetes API, Argo uses a ServiceAccount to authenticate itself to the Kubernetes API. You can specify which Role (i.e. which permissions) the ServiceAccount that Argo uses by binding a Role to a ServiceAccount using a RoleBinding

```
kubectl create rolebinding default-admin --clusterrole=admin --serviceaccount=argo:default -n argo
```

### Workflow RBAC

The bare minimum for a workflow to function is outlined below:
```
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: workflow-role
rules:
# pod get/watch is used to identify the container IDs of the current pod
# pod patch is used to annotate the step's outputs back to controller (e.g. artifact location)
- apiGroups:
  - ""
  resources:
  - pods
  verbs:
  - get
  - watch
  - patch
# logs get/watch are used to get the pods logs for script outputs, and for log archival
- apiGroups:
  - ""
  resources:
  - pods/log
  verbs:
  - get
  - watch
```

### Node Field Selectors

The resume, stop and retry Argo CLI and API commands support a `--node-field-selector` parameter to allow the user to select a subset of nodes for the command to apply to.

In the case of the resume and stop commands these are the nodes that should be resumed or stopped.

In the case of the retry command it allows specifying nodes that should be restarted even if they were previously successful (and must be used in combination with `--restart-successful`)

The format of this when used with the CLI is: `--node-field-selector=FIELD=VALUE`

(e.g. `--node-field-selector=foo1=bar1,phase!=Running`)

The field can be any of:
- `displayName` -  Display name of node (
- `name`  - Full name of the node.
- `templateName` - Template name of the node
- `phase` -  Phase status of the node - eg Running
- `templateRef.name` -  The name of the WorkflowTemplate the node is referring to
- `templateRef.template` - The template within the WorkflowTemplate the node is referring to
- `inputs.parameters.<NAME>.value` - The value of input parameter NAME

For the following workflow:
```
 ● appr-promotion-ffsv4    code-release
 ├─✔ start                 sample-template/email                 appr-promotion-ffsv4-3704914002  2s
 ├─● app1                  wftempl1/approval-and-promotion
 │ ├─✔ notification-email  sample-template/email                 appr-promotion-ffsv4-524476380   2s
 │ └─ǁ wait-approval       sample-template/waiting-for-approval
 ├─✔ app2                  wftempl2/promotion
 │ ├─✔ notification-email  sample-template/email                 appr-promotion-ffsv4-2580536603  2s
 │ ├─✔ pr-approval         sample-template/approval              appr-promotion-ffsv4-3445567645  2s
 │ └─✔ deployment          sample-template/promote               appr-promotion-ffsv4-970728982   1s
 └─● app3                  wftempl1/approval-and-promotion
   ├─✔ notification-email  sample-template/email                 appr-promotion-ffsv4-388318034   2s
   └─ǁ wait-approval       sample-template/waiting-for-approval
```

```
$ kubectl get wf appr-promotion-ffsv4 -o yaml
```

```yaml
    ...
    appr-promotion-ffsv4-3235686597:
      boundaryID: appr-promotion-ffsv4-3079407832
      displayName: wait-approval                        # <- Display Name
      finishedAt: null
      id: appr-promotion-ffsv4-3235686597
      name: appr-promotion-ffsv4.app1.wait-approval     # <- Full Name
      phase: Running
      startedAt: "2021-01-20T17:00:25Z"
      templateRef:
        name: sample-template
        template: waiting-for-approval
      templateScope: namespaced/wftempl1
      type: Suspend
```

### Empty Dir

While by default, the Docker and PNS workflow executors can get output artifacts/parameters from the base layer (e.g. /tmp), neither the Kubelet nor the K8SAPI executors can. It is unlikely you can get output artifacts/parameters from the base layer if you run your workflow pods with a security context.

You can work-around this constraint by mounting volumes onto your pod. The easiest way to do this is to use as emptyDir volume.

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Workflow
metadata:
  generateName: empty-dir-
spec:
  entrypoint: main
  templates:
    - name: main
      container:
        image: argoproj/argosay:v2
        command: [sh, -c]
        args: ["cowsay hello world | tee /mnt/out/hello_world.txt"]
        volumeMounts:
          - name: out
            mountPath: /mnt/out
      volumes:
        - name: out
          emptyDir: { }
      outputs:
        parameters:
          - name: message
            valueFrom:
              path: /mnt/out/hello_world.txt
```

### WorkflowTemplates

WorkflowTemplates are definitions of Workflows that live in your cluster. This allows you to create a library of frequently-used templates and reuse them either by submitting them directly (v2.7 and after) or by referencing them from your Workflows.


