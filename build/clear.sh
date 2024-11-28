kubectl delete ns traefik apps
kubectl get crd | grep traefik | awk '{print $1}' | xargs kubectl delete crd
kubectl get clusterrole | grep traefik | awk '{print $1}' | xargs kubectl delete clusterrole
kubectl get clusterrolebinding | grep traefik | awk '{print $1}' | xargs kubectl delete clusterrolebinding
kubectl get ingressclass | grep traefik | awk '{print $1}' | xargs kubectl delete ingressclass
