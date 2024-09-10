# traefik

### 1 首次安装traefik到k8s
```
$ sh run.sh
```
在客户端机器设置host:
```
{服务器IP} vm.apps.com
```
访问 traefik Dashboard: http://vm.apps.com:8080/

### 2 创建测试服务路由
```
$ kubectl create ns apps
$ kubectl apply -f apps_yml/whoami.yaml
```
可以查看ingressroute配置：
```
$ kubectl -napps get ingressroute -o yaml
# 已设置了所有 vm.apps.com/test/* 请求都会经过traefik网关
  spec:
    entryPoints:
    - http
    routes:
    - kind: Rule
      match: Host(`vm.apps.com`) && PathPrefix(`/test/`)
      services:
      - name: whoami-svc
        port: 80
```
测试一下接口请求：
```
$ curl http://vm.apps.com/test/test
Hostname: whoami-567b85d54d-nggx9
IP: 127.0.0.1
IP: 172.17.0.4
RemoteAddr: 172.17.0.5:42916
GET /test/test HTTP/1.1
Host: vm.apps.com
User-Agent: curl/7.87.0
Accept: */*
Accept-Encoding: gzip
X-Forwarded-For: 172.16.240.1
X-Forwarded-Host: vm.apps.com
X-Forwarded-Port: 80
X-Forwarded-Proto: http
X-Forwarded-Server: traefik-ingress-controller-59674db8f4-vddhp
X-Real-Ip: 172.16.240.1
```
路由正常~
