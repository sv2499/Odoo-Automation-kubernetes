#!/bin/bash
client_name=$1
db_name=$2
db_pass=$3
image=$4
addons_path=$5
admin_pass=$6

mkdir output/${client_name=}

sed "s/client-secret-name/${client_name}-secret/g" kubernetes-yaml/edu-erp-odoo-secrets.yaml > output/${client_name=}/temp-secret-name.yaml
sed "s/client-db-name/${db_name}/g" output/${client_name=}/temp-secret-name.yaml > output/${client_name=}/temp-db-name.yaml
sed "s/client-db-password/${db_pass}/g" output/${client_name=}/temp-db-name.yaml > output/${client_name=}/odoo-secrets.yaml

sed "s/clinet-pvc-name/${client_name}-pvc/g" kubernetes-yaml/edu-erp-odoo-pvc.yaml > output/${client_name=}/odoo-pvc.yaml

sed "s/client-service-name/${client_name}-service/g" kubernetes-yaml/edu-erp-odoo-service.yaml > output/${client_name=}/temp-service-name.yaml
sed "s/client-pod-name/${client_name}-pod/g" output/${client_name=}/temp-service-name.yaml > output/${client_name=}/odoo-service.yaml

sed "s/client-pod-name/${client_name}-pod/g" kubernetes-yaml/edu-erp-odoo-pod.yaml > output/${client_name=}/temp-pod-name.yaml
sed "s/client-odoo-image-name/${image}/g" output/${client_name=}/temp-pod-name.yaml > output/${client_name=}/temp-odoo-image-name.yaml
sed "s/client-secret-name/${client_name}-secret/g" output/${client_name=}/temp-odoo-image-name.yaml > output/${client_name=}/temp-secret-name.yaml
sed "s/client-db-name/${db_name}/g" output/${client_name=}/temp-secret-name.yaml > output/${client_name=}/temp-db-name.yaml
sed "s/clinet-pvc-name/${client_name}-pvc/g" output/${client_name=}/temp-db-name.yaml > output/${client_name=}/odoo-pod.yaml

sed "s/client-ingress-name/${client_name}-ingress/g" kubernetes-yaml/edu-erp-odoo-ingress.yaml > output/${client_name=}/temp-ingress-name.yaml
sed "s/client-host-name/${db_name}.demo.odooonline.com/g" output/${client_name=}/temp-ingress-name.yaml > output/${client_name=}/temp-host-name.yaml
sed "s/client-service-name/${client_name}-service/g" output/${client_name=}/temp-host-name.yaml > output/${client_name=}/odoo-ingress.yaml

sed "s/odoo-addons/${addons_path}/g" sample-odoo.conf > output/${client_name=}/temp-odoo-addons.conf
sed "s/odoo-admin-password/${admin_pass}/g" output/${client_name=}/temp-odoo-addons.conf > output/${client_name=}/temp-admin-pass.conf
sed "s/odoo-db-name/${db_name}/g" output/${client_name=}/temp-admin-pass.conf > output/${client_name=}/odoo.conf
rm -rf output/${client_name=}/temp-*
