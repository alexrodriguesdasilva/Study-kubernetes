# Configurando um servidor NFS Simples

### Install and config server-NFS
<details><summary>show</summary>
<p>

```bash
# Install nfs-kernel-server
$ sudo apt update
$ sudo apt install nfs-kernel-server

# Add the following config at the end of /etc/exports file
$ /opt/kubernetes *(rw,sync,no_subtree_check)

# create a path
$ sudo mkdir /opt/kubernetes

# add permission to folder
$ sudo chmod 1777 /opt/kubernetes

# Refresh configs NFS
$ exportfs -ra
```

</p>
</details>

### Config client NFS in "workers
<details><summary>show</summary>
<p>

```bash
$ sudo apt update
$ sudo apt install nfs-common
```

</p>
</details>