#!/bin/bash

kubectl create ns traefik

# 创建traefik toml配置文件的configmap, 用于挂载
kubectl -n traefik create configmap traefik-config --from-file=conf/traefik.toml
kubectl -n traefik create configmap traefik-config-dynamic --from-file=conf/dynamic.toml

# 创建secret tls证书
#kubectl -n traefik create secret tls traefik-cert --cert tls2/server.crt --key tls2/server.key
#kubectl -n kuas create secret tls traefik-cert --cert tls2/server.crt --key tls2/server.key

# 安装traefik crd, 创建rbac权限
kubectl apply -f traefik_yml/crd.yaml -f traefik_yml/crd-rbac.yaml

# 开启traefik服务
# 这里会将traefik的80和8080端口映射到host
kubectl apply -f traefik_yml/deployment.yaml
