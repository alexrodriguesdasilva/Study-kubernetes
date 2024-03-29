### Create a new pod called admin-pod with image busybox. Allow the pod to be able to set sys_time. The container should for 3200 seconds

<details><summary>show</summary>
<p>

```bash
# create yaml via CLI
$ kubectl run admin-pod --image=busybox --command sleep 3200 --dry-run=client -o yaml > pod.yaml

# add config Security context
https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-pod

# yaml deploy
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: admin-pod
  name: admin-pod
spec:
  containers:
  - command:
    - sleep
    - "3600"
    image: nginx
    name: pod
    securityContext:
      capabilities:
        add: ["SYS_TIME"]

```
</p>
</details>

### Create a simple pod using 

<details><summary>show</summary>
<p>

```bash
apiVersion: v1
kind: Pod
metadata:
  name: test-app-emptydir
spec:
  containers:
  - image: nginx
    name: test-container
    volumeMounts:
    - mountPath: /cache
      name: cache-volume
  volumes:
  - name: cache-volume
    emptyDir:
      sizeLimit: 500Mi
```

the volume will be mounted on the node where the pod is running, in the var/lib/kubernetes/pods/ folder
</p>
</details>

### Create a simple pod using pv e pvc

<details><summary>show</summary>
<p>

```bash
apiVersion: v1
kind: PersistentVolume
metadata:
  name: my-pv
  labels:
    type: local
spec:
  storageClassName: manual
  capacity:
    storage: 5Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/mnt/data"
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-pvc
spec:
  storageClassName: manual
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 5Gi
---
apiVersion: v1
kind: Pod
metadata:
  name: my-pod
spec:
  volumes:
    - name: my-pv
      persistentVolumeClaim:
        claimName: my-pvc
  containers:
    - name: task-pv-container
      image: nginx
      ports:
        - containerPort: 80
          name: "http-server"
      volumeMounts:
        - mountPath: "/usr/share/nginx/html"
          name: my-pv
```
</p>
</details>

### Use NFS in pv, pvc and deployment
<details><summary>show</summary>
<p>

```bash
apiVersion: v1
kind: PersistentVolume
metadata:
  name: nfs-pv
spec:
  capacity:
    storage: 5Gi
  volumeMode: Filesystem
  accessModes:
    - ReadWriteMany
  persistentVolumeReclaimPolicy: Retain
  nfs:
    path: /opt/kubernetes
    server: 172.31.31.21
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: nfs-pvc
spec:
  accessModes:
    - ReadWriteMany
  storageClassName: ""
  resources:
    requests:
      storage: 5Gi
  volumeName: nfs-pv
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    app: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.14.2
        ports:
        - containerPort: 80
        volumeMounts:
            # name must match the volume name below
            - name: nfs
              mountPath: "/usr/share/nginx/html"
      volumes:
      - name: nfs
        persistentVolumeClaim:
          claimName: nfs-pvc
```

</p>
</details>

### create a "pod" in "kubernetes" and expose it using ClusterIP

<details><summary>show</summary>
<p>

```bash
# Create CLI:
$ kubectl run app-nginx --port=80 --image=ngnix
$ kubectl expose pod app-nginx --port=80 --target-port=80

# Create yaml:
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: my-app-nginx
  name: my-app-nginx
spec:
  containers:
  - image: nginx
    name: my-app-nginx
    ports:
    - containerPort: 80
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
---
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: "2023-10-14T00:27:56Z"
  labels:
    run: my-app-nginx
  name: my-app-nginx
  namespace: default
  resourceVersion: "47591"
  uid: 609321c9-1ef6-4526-83af-8ea16510a3f8
spec:
  clusterIP: 10.106.245.99
  clusterIPs:
  - 10.106.245.99
  internalTrafficPolicy: Cluster
  ipFamilies:
  - IPv4
  ipFamilyPolicy: SingleStack
  ports:
  - port: 80
    protocol: TCP
    targetPort: 80
  selector:
    run: my-app-nginx
  sessionAffinity: None
  type: ClusterIP
status:
  loadBalancer: {}
```

</p>
</details>

### create a "pod" in "kubernetes" and expose it using NodePort

<details><summary>show</summary>
<p>

```bash

# Create yaml:
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: my-app-nginx
  name: my-app-nginx
spec:
  containers:
  - image: nginx
    name: my-app-nginx
    ports:
    - containerPort: 80
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
---
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: "2023-10-14T00:27:56Z"
  labels:
    run: my-app-nginx
  name: my-app-nginx
  namespace: default
  resourceVersion: "47591"
  uid: 609321c9-1ef6-4526-83af-8ea16510a3f8
spec:
  clusterIP: 10.106.245.99
  clusterIPs:
  - 10.106.245.99
  internalTrafficPolicy: Cluster
  ipFamilies:
  - IPv4
  ipFamilyPolicy: SingleStack
  ports:
  - port: 80
    protocol: TCP
    targetPort: 80
  selector:
    run: my-app-nginx
  sessionAffinity: None
  type: NodePort
status:
  loadBalancer: {}
```

</p>
</details>

### create a "deployment" in "kubernetes" and expose it using Service LoadBalance

<details><summary>show</summary>
<p>

```bash
# Create via CLI 
$ kubectl create deployment deployment-svc --image=nginx --port=80 --replicas=1
$ kubectl expose deployment deployment-svc --port=80 --target-port=80 --type=LoadBalancer
```

</p>
</details>

### Create a deployment called web-proj-268, with image nginx:1.16 and 1 replica, Next upgrade the deployment to version 1.17 using rollint update. Make sure that the version upgrade is recorded in the resource annotation

<details><summary>show</summary>
<p>

```bash
# Create a deployment
kubectl create deployment web-proj-268 --image=nginx:1.16

# Set a new version in deployment
$ kubectl set image deployment web-proj-268 nginx=nginx:1.17 --record

# Verify history of the deployment 
$ kubectl rollout history deployment web-proj-268

```

</p>
</details>