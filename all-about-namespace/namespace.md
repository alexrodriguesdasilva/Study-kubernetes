
## List the namespace of the cluster
### kubectl get namespaces

## create a namespace with the CLI command 
### $ kubectl create namespace name-of-namespace

## get more namespace information
### $ kubectl describe namespace name-of-namespace

## get yaml of the namespace
### $ kubectl get namespace name-of-namespace -o yaml

## change namespace
### kubectl config set-context --current --namespace=name-of-namespace