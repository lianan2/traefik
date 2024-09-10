# traefik

## 1 首次安装traefik到k8s
```
$ sh run.sh
```
在客户端机器设置host:
```
{服务器IP} vm.apps.com
```
可以访问 traefik Dashboard: http://vm.apps.com:8080/  

创建测试服务：
```
$ kubectl create ns apps
$ kubectl apply -f apps_yml/whoami.yaml
```
查看ingressroute配置：
```
$ kubectl -napps get ingressroute -o yaml
```
测试接口请求：
```
$ curl http://vm.apps.com/test/test
```

## 2 增加鉴权中间件
创建中间件：
```
kubectl apply -f middleware/auth.yaml
```
在 ingressroute/whoami.yaml 中，添加中间件关联：
```
  middlewares:
    - name: auth-errors   # 鉴权失败重定向中间件
    - name: forward-auth  # 鉴权中间件
```
更新ingressroute：
```
kubectl apply -f ingressroute/whoami.yaml
```
请求接口测试一下：
```
$ curl http://vm.apps.com/test/test -v
返回401未认证，重定向到/test/sign_in路由

$ curl http://vm.apps.com/test/test --header 'Authorization: Bearer xxx'
返回200
```
