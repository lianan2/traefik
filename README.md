# traefik

### 首次安装traefik到k8s
```
sh run.sh
```


### 测试服务路由
```
kubectl create ns apps
kubectl apply -f apps_yaml/whoami.yaml
```
