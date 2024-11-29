#!/bin/bash

kubectl create ns traefik

# 创建traefik toml配置文件的configmap, 用于挂载
kubectl -n traefik create configmap traefik-config --from-file=traefik/conf/traefik.toml
#kubectl -n traefik create configmap traefik-config-dynamic --from-file=traefik/conf/dynamic.toml

# 安装traefik crd, 创建rbac权限
kubectl apply -f traefik/crd.yaml -f traefik/crd-rbac.yaml

# 开启traefik服务
# 这里会将traefik的80和8080端口映射到host
kubectl apply -f traefik/deployment.yaml
