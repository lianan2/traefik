#!/bin/bash

kubectl create ns traefik

# 创建traefik toml配置文件的configmap, 用于挂载
kubectl -n traefik create configmap traefik-config --from-file=conf/traefik.toml
kubectl -n traefik create configmap traefik-config-dynamic --from-file=conf/dynamic.toml

# 创建secret tls证书
#kubectl -n traefik create secret tls traefik-cert --cert tls2/server.crt --key tls2/server.key
#kubectl -n kuas create secret tls traefik-cert --cert tls2/server.crt --key tls2/server.key

cd traefik_yml || exit

# 安装traefik crd, 创建rbac权限
kubectl apply -f crd.yml -f crd-rbac.yml

# 开启traefik服务
kubectl apply -f deployment.yml

# traefik svc
# kubectl apply -f service.yml

# 中间件
# kubectl apply -f auth-forward.yml

# 路由规则
# kubectl apply -f ingress.yml
kubectl apply -f ingressroute.yml


