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
# 创建deployment和service
$ kubectl apply -f apps_yml/whoami.yaml
# 创建路由规则
$ kubectl apply -f ingressroute/whoami.yaml
```
请求接口测试：
```
$ curl http://vm.apps.com/test
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
请求接口测试：
```
$ curl http://vm.apps.com/test -v
返回401未认证，重定向到/test/sign_in路由

$ curl http://vm.apps.com/test --header 'Authorization: Bearer NTEwMjk2MTI1MzIwNzI1NzM.NDMwNjg3MTg4MjZlMjBhNWJjNTQ1YmZkZTQ1MTMzMDU0M2E2NmNiMA'
返回200
```

## 3 增加登录拦截器
创建中间件：
```
kubectl apply -f middleware/login_interceptor.yaml
```
更新ingressroute：
```
kubectl apply -f ingressroute/whoami.yaml
```
请求接口测试：
```
$ curl http://vm.apps.com/v2/user/login --header 'X-User-Name: zhangsan'
```