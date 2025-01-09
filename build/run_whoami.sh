#!/bin/bash

kubectl create ns apps
  
# 创建deployment和service
kubectl apply -f whoami/whoami.yaml

# 创建中间件
YAML_DIR=./middleware
for yaml_file in $(find "$YAML_DIR" -type f -name "*.yaml" | sort); do
  kubectl apply -f "$yaml_file"
done


# 创建ingressroute
kubectl apply -f whoami/ingressroute.yaml