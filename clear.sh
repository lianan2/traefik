kubectl delete ns traefik
kubectl get crd | grep traefik | awk '{print $1}' | xargs kubectl delete crd
kubectl get clusterrole | grep traefik | awk '{print $1}' | xargs kubectl delete clusterrole
kubectl get clusterrolebinding | grep traefik | awk '{print $1}' | xargs kubectl delete clusterrolebinding
kubectl get ingressclass | grep traefik | awk '{print $1}' | xargs kubectl delete ingressclass
kubectl -nkuas get ingress | grep traefik | awk '{print $1}' | xargs kubectl -nkuas delete ingress
kubectl -nkuas get svc | grep traefik | awk '{print $1}' | xargs kubectl delete svc
