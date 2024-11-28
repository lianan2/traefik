# traefik

访问 traefik Dashboard: http://vm.apps.com:8080/

测试请求whoami服务:
```
curl http://vm.apps.com/test -v
curl http://vm.apps.com/test --header 'Authorization: Bearer NTEwMjk2MTI1MzIwNzI1NzM.NDMwNjg3MTg4MjZlMjBhNWJjNTQ1YmZkZTQ1MTMzMDU0M2E2NmNiMA'
curl http://vm.apps.com/v2/user/login --header 'X-User-Name: zhangsan'
```
