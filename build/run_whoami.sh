#!/bin/bash

kubectl create ns apps
  
# 创建deployment和service
kubectl apply -f whoami/whoami.yaml

# 鉴权中间件
kubectl apply -f middleware/auth.yaml
# 登录拦截中间件
kubectl apply -f middleware/login_interceptor.yaml
# header重命名中间件
kubectl apply -f middleware/rename_header.yaml

# 创建路由规则
kubectl apply -f whoami/ingressroute.yaml

