# minikube

## QA

### `1. minikube start`

* 问题

  ```powershell
  PS C:/windows/system32>minikube start --driver=virtualbox --kubernetes-version=v1.24.0
  
  💢  initialization failed, will try again: wait: /bin/bash -c "sudo env PATH="/var/lib/minikube/binaries/v1.24.0:$PATH" kubeadm init --config /var/tmp/minikube/kubeadm.yaml  --ignore-preflight-errors=DirAvailable--etc-kubernetes-manifests,DirAvailable--var-lib-minikube,DirAvailable--var-lib-minikube-etcd,FileAvailable--etc-kubernetes-manifests-kube-scheduler.yaml,FileAvailable--etc-kubernetes-manifests-kube-apiserver.yaml,FileAvailable--etc-kubernetes-manifests-kube-controller-manager.yaml,FileAvailable--etc-kubernetes-manifests-etcd.yaml,Port-10250,Swap,NumCPU,Mem": Process exited with status 1
  ```

  

* 解决方法：

  `minikube start --driver=virtualbox --kubernetes-version=v1.24.0 --preload=false`

  `minikube kubectl -- get pods -A`