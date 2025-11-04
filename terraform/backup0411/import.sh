#!/bin/bash

echo "Importing subnet..."
terraform import google_compute_subnetwork.app_subnet projects/skillbox-devops-basic/regions/us-west4/subnetworks/app-subnet

echo "Importing firewall rules..."
terraform import google_compute_firewall.allow_http projects/skillbox-devops-basic/global/firewalls/allow-http
terraform import google_compute_firewall.allow_https projects/skillbox-devops-basic/global/firewalls/allow-https
terraform import google_compute_firewall.allow_ssh projects/skillbox-devops-basic/global/firewalls/allow-ssh
terraform import google_compute_firewall.allow_health_check projects/skillbox-devops-basic/global/firewalls/allow-health-check

echo "Importing router..."
terraform import google_compute_router.app_router projects/skillbox-devops-basic/regions/us-west4/routers/app-router

echo "Done! Now run: terraform plan"
