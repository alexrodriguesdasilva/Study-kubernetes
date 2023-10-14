### Install helm in node master

<details><summary>show</summary>
<p>

```bash
# https://helm.sh/docs/intro/install/#helm
$ curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
$ sudo apt-get install apt-transport-https --yes
$ echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
$ sudo apt-get update
$ sudo apt-get install helm
```

</p>
</details>

### Install nginx ingress controller for helm

<details><summary>show</summary>
<p>

```bash
# https://artifacthub.io/packages/helm/ingress-nginx/ingress-nginx

$ helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
$ helm repo update
$ helm install [RELEASE_NAME] ingress-nginx/ingress-nginx -n [namespace-name]
```

</p>
</details>

</p>
</details>

### Create a deployment and expose by service

<details><summary>show</summary>
<p>

```bash
# Create deployment via CLI:
kubectl create deployment nginx-ingress-controller --image=nginx --port=80 --replicas=3

# expose deployment via CLI:
kubectl expose deployment nginx-ingress-controller --port=80
```

</p>
</details>

### Create a ingress

<details><summary>show</summary>
<p>

```bash
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: my-ingress
  annotations:
  # nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  ingressClassName: nginx
  rules:
  - host: "ec2-54-157-153-133.compute-1.amazonaws.com"
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: nginx-ingress-controller
            port:
              number: 80
```

</p>
</details>