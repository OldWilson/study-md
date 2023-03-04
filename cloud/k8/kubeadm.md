# kubeadm

## Config

### resources

* [(9条消息) k8s pod deployment service ingress 关系_weitao_11的博客-CSDN博客](https://blog.csdn.net/weitao_11/article/details/129240086)
* [(9条消息) Deployment、ReplicaSet、Pod和Service的关系_deployment和service关系_arong...的博客-CSDN博客](https://blog.csdn.net/bruceRong/article/details/107192680)
* [一关系图让你理解K8s中的概念，Pod、Service、Job等到底有啥关系 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/105006577)
* [(9条消息) k8s:yaml文件详解和部署简单nginx_k8s nginx yaml_夏夜迷的博客-CSDN博客](https://blog.csdn.net/weixin_49415186/article/details/127802616)
* [Pods | Kubernetes](https://kubernetes.io/docs/concepts/workloads/pods/)
* [(9条消息) kubernetes查看现有pod的YAML描述文件_kubectl查看pod yaml_张俊杰1994的博客-CSDN博客](https://blog.csdn.net/qq_41489540/article/details/114289121)

### master

* 初始化kubeadm

  ```bash
  sudo kubeadm config images pull # 拉取集群所需的镜像
  sudo kubeadm init --apiserver-advertise-address=192.168.56.10  --pod-network-cidr=10.244.0.0/16  # 初始化kubeadm，输出内容为(output>kubectl-init)
  
  echo "source <(kubectl completion bash)" >> ~/.bashrc # kubectl命令自动补全
  source ~/.bashrc
  
  kubectl label node k8s-worker2 node-role.kubernetes.io/worker=worker # 修改节点角色
  
  # 以下3个命令为(output>kubectl-init)中的内容
  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config
  
  # 检查状态
  kubectl get nodes
  kubectl get pods -A
  ```

  

* 部署pod network方案

  * 下载路径：https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml

  * 修改flannel.yml

    ```yaml
    ---
    net-conf.json: |
      {
        "Network": "10.244.0.0/16",
        "Backend": {
          "Type": "vxlan"
        }
      }
    ---
    
    - name: kube-flannel
     #image: flannelcni/flannel:v0.18.0 for ppc64le and mips64le (dockerhub limitations may apply)
      image: rancher/mirrored-flannelcni-flannel:v0.18.0
      command:
      - /opt/bin/flanneld
      args:
      - --ip-masq
      - --kube-subnet-mgr
      - --iface=enp0s8 # 修改iface的接口名，ip a查看
      
    ---
    ```

  * 将flannel.yaml文件上传到master节点，运行：

    ```bash
    kubectl apply -f fannel.yaml
    
    # 查看pod的状态，应该都为running的状态，则network方案部署成功
    kubectl get pods -A
    ```

    



### worker

* 添加worker节点

  ```bash
  sudo kubeadm join 192.168.56.10:6443 --token 4vsqgn.9k671m9k7s7lf5yo --discovery-token-ca-cert-hash sha256:89c25891455ae90726f8a3a84969452ba6c936c354337c6a814acd6036e174e4
  ```

  * ` --token`: (output>kubectl-init)中的内容

  * ` --discovery-token-ca-cert-hash`: (output>kubectl-init)中的内容

  * master节点执行下列命令，确认节点添加成功

    ```bash
    kubectl get nodes
    kubectl get pods -A # 可以查看到3个flannel，3个proxy的pod
    ```

    



### master & worker IP不正确

```bash
# master
kubectl get nodes -o wide # 查看各节点的详细信息，包括IP

# master & worker
# 修改kubeadm-flags.env，添加KUBELET_EXTRA_ARGS
sudo vim /var/lib/kubelet/kubeadm-flags.env
> KUBELET_EXTRA_ARGS="--node-ip=192.168.56.10 # master节点添加内容
  KUBELET_EXTRA_ARGS="--node-ip=192.168.56.11 # worker1节点添加内容
  KUBELET_EXTRA_ARGS="--node-ip=192.168.56.12 # worker2节点添加内容

# 重启kubelet
sudo systemctl daemon-reload
sudo systemctl restart kubelet.service

# master
kubectl get nodes -o wide # IP应该显示正确
```



### 节点角色添加

```bash
# master节点操作
kubectl label node k8s-worker1 node-role.kubernetes.io/worker=worker
kubectl label node k8s-worker2 node-role.kubernetes.io/worker=worker
```



## output

1. `kubectl-init`

   ```powershell
   vagrant@k8s-master:~$ sudo kubeadm init --apiserver-advertise-address=192.168.56.10  --pod-network
   -cidr=10.244.0.0/16
   [init] Using Kubernetes version: v1.26.2
   [preflight] Running pre-flight checks
   [preflight] Pulling images required for setting up a Kubernetes cluster
   [preflight] This might take a minute or two, depending on the speed of your internet connection
   [preflight] You can also perform this action in beforehand using 'kubeadm config images pull'
   [certs] Using certificateDir folder "/etc/kubernetes/pki"
   [certs] Generating "ca" certificate and key
   [certs] Generating "apiserver" certificate and key
   [certs] apiserver serving cert is signed for DNS names [k8s-master kubernetes kubernetes.default kubernetes.default.svc kubernetes.default.svc.cluster.local] and IPs [10.96.0.1 192.168.56.10]
   [certs] Generating "apiserver-kubelet-client" certificate and key
   [certs] Generating "front-proxy-ca" certificate and key
   [certs] Generating "front-proxy-client" certificate and key
   [certs] Generating "etcd/ca" certificate and key
   [certs] Generating "etcd/server" certificate and key
   [certs] etcd/server serving cert is signed for DNS names [k8s-master localhost] and IPs [192.168.56.10 127.0.0.1 ::1]
   [certs] Generating "etcd/peer" certificate and key
   [certs] etcd/peer serving cert is signed for DNS names [k8s-master localhost] and IPs [192.168.56.10 127.0.0.1 ::1]
   [certs] Generating "etcd/healthcheck-client" certificate and key
   [certs] Generating "apiserver-etcd-client" certificate and key
   [certs] Generating "sa" key and public key
   [kubeconfig] Using kubeconfig folder "/etc/kubernetes"
   [kubeconfig] Writing "admin.conf" kubeconfig file
   [kubeconfig] Writing "kubelet.conf" kubeconfig file
   [kubeconfig] Writing "controller-manager.conf" kubeconfig file
   [kubeconfig] Writing "scheduler.conf" kubeconfig file
   [kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
   [kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
   [kubelet-start] Starting the kubelet
   [control-plane] Using manifest folder "/etc/kubernetes/manifests"
   [control-plane] Creating static Pod manifest for "kube-apiserver"
   [control-plane] Creating static Pod manifest for "kube-controller-manager"
   [control-plane] Creating static Pod manifest for "kube-scheduler"
   [etcd] Creating static Pod manifest for local etcd in "/etc/kubernetes/manifests"
   [wait-control-plane] Waiting for the kubelet to boot up the control plane as static Pods from directory "/etc/kubernetes/manifests". This can take up to 4m0s
   [apiclient] All control plane components are healthy after 14.005903 seconds
   [upload-config] Storing the configuration used in ConfigMap "kubeadm-config" in the "kube-system" Namespace
   [kubelet] Creating a ConfigMap "kubelet-config" in namespace kube-system with the configuration for the kubelets in the cluster
   [upload-certs] Skipping phase. Please see --upload-certs
   [mark-control-plane] Marking the node k8s-master as control-plane by adding the labels: [node-role.kubernetes.io/control-plane node.kubernetes.io/exclude-from-external-load-balancers]
   [mark-control-plane] Marking the node k8s-master as control-plane by adding the taints [node-role.kubernetes.io/control-plane:NoSchedule]
   [bootstrap-token] Using token: 4vsqgn.9k671m9k7s7lf5yo
   [bootstrap-token] Configuring bootstrap tokens, cluster-info ConfigMap, RBAC Roles
   [bootstrap-token] Configured RBAC rules to allow Node Bootstrap tokens to get nodes
   [bootstrap-token] Configured RBAC rules to allow Node Bootstrap tokens to post CSRs in order for nodes to get long term certificate credentials
   [bootstrap-token] Configured RBAC rules to allow the csrapprover controller automatically approve CSRs from a Node Bootstrap Token
   [bootstrap-token] Configured RBAC rules to allow certificate rotation for all node client certificates in the cluster
   [bootstrap-token] Creating the "cluster-info" ConfigMap in the "kube-public" namespace
   [kubelet-finalize] Updating "/etc/kubernetes/kubelet.conf" to point to a rotatable kubelet client certificate and key
   [addons] Applied essential addon: CoreDNS
   [addons] Applied essential addon: kube-proxy
   
   Your Kubernetes control-plane has initialized successfully!
   
   To start using your cluster, you need to run the following as a regular user:
   
     mkdir -p $HOME/.kube
     sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
     sudo chown $(id -u):$(id -g) $HOME/.kube/config
   
   Alternatively, if you are the root user, you can run:
   
     export KUBECONFIG=/etc/kubernetes/admin.conf
   
   You should now deploy a pod network to the cluster.
   Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
     https://kubernetes.io/docs/concepts/cluster-administration/addons/
   
   Then you can join any number of worker nodes by running the following on each as root:
   
   kubeadm join 192.168.56.10:6443 --token 4vsqgn.9k671m9k7s7lf5yo \
           --discovery-token-ca-cert-hash sha256:89c25891455ae90726f8a3a84969452ba6c936c354337c6a814acd6036e174e4
   ```
   
   