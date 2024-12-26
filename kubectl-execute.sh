client_name=$1

kubectl apply -f output/${client_name}/odoo-secrets.yaml
kubectl apply -f output/${client_name}/odoo-pvc.yaml
kubectl apply -f output/${client_name}/odoo-pod.yaml
kubectl apply -f output/${client_name}/odoo-service.yaml
kubectl apply -f output/${client_name}/odoo-ingress.yaml

sleep 120

kubectl cp ./output/${client_name}/odoo.conf ${client_name}-pod:/etc/odoo
kubectl cp ./modules/${app_name} ${client_name}-pod:/opt
kubectl cp /opt/app-filestores/${app_name}/${odoo_version}/filestore/. ${client_name}-pod:/var/lib/odoo/filestore/${db_name}/

kubectl delete pod ${client_name}-pod
kubectl apply -f output/${client_name}/odoo-pod.yaml
