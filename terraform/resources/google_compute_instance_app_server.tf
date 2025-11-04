# google_compute_instance.app_server:
resource "google_compute_instance" "app_server" {
    can_ip_forward          = false
    cpu_platform            = "Intel Broadwell"
    current_status          = "RUNNING"
    deletion_protection     = false
    description             = null
    effective_labels        = {}
    enable_display          = false
    guest_accelerator       = []
    hostname                = null
    id                      = "projects/skillbox-devops-basic/zones/us-west4-c/instances/app-server"
    instance_id             = "1116027300528792909"
    label_fingerprint       = "42WmSpB8rSM="
    labels                  = {}
    machine_type            = "e2-micro"
    metadata                = {
        "ssh-keys" = <<-EOT
            ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCocyxZxX2E7Y8iAn8rAevDz1M4/pNkgTgbiASHWnNuaDV7ZIZraU7z21Q+UTXASwlzK0YjoIEAVxcSTENyG04OjVqzGU8y1AB4LjtOq15ULm+qNLkG8iSrVshD838wq3W9WP4lcKfCtifE3GUB66OyfdGiTLHoT6RkIkOzkGgRqm/S+Kc4f1fP66C8EisyS5/YHVl/1BrcjJNIyvyxhVX24kFWQaMsvoh5UZXHtowG2agdx93MB58Umzxg+ZgmrJ+rNhQPuQI89O1fnZct7A459OM2clpmNPlQu09StvKyGyPK3Wb8x7rbEm1t/OQ0ejrROA0osa0H6d0UfNVULje0EjAT9xjHYL4kdtAV0ZyFJGUxO4LZBgvgKEwdKy8vFmmjLHSHa0WWPI4FqEFQZPCzqX3Ro9COxGUI8ja5KjIrVvbrHqXjYeH5Hc0zxbfUsOmL0YnYoUP8Br+cIpvs402nYsNq712OOuQ0FPqGoHkFe+leSGBRtZBEvl/UvCJE6rUO3xHaSnJdFnmVDVUpRlmXDFC7hCM8uH47QrwpY0BOCrnAMnb2tSkS1wfVSuDncI3CQ0vAN5S/b2BnxedO3g3zfPa+V6G3jd6uLB03yJVGSOVVtnDXvV7cBtjEc6tJBFoV8VnsPpOTHZG8y+vKL7m2M5UwkKhEeW004o+xKRK2Kw== maxpack2030@gmail.com
        EOT
    }
    metadata_fingerprint    = "YOsdKnizvgQ="
    metadata_startup_script = <<-EOT
        #!/bin/bash
        apt-get update
    EOT
    min_cpu_platform        = null
    name                    = "app-server"
    project                 = "skillbox-devops-basic"
    resource_policies       = []
    self_link               = "https://www.googleapis.com/compute/v1/projects/skillbox-devops-basic/zones/us-west4-c/instances/app-server"
    tags                    = [
        "http-server",
        "https-server",
        "ssh-server",
    ]
    tags_fingerprint        = "nBrWn2vdQv8="
    terraform_labels        = {}
    zone                    = "us-west4-c"

    boot_disk {
        auto_delete                = true
        device_name                = "persistent-disk-0"
        disk_encryption_key_raw = null
        disk_encryption_key_sha256 = null
        kms_key_self_link          = null
        mode                       = "READ_WRITE"
        source                     = "https://www.googleapis.com/compute/v1/projects/skillbox-devops-basic/zones/us-west4-c/disks/app-server"

        initialize_params {
            enable_confidential_compute = false
            image                       = "https://www.googleapis.com/compute/v1/projects/ubuntu-os-cloud/global/images/ubuntu-2204-jammy-v20251023"
            labels                      = {}
            provisioned_iops            = 0
            provisioned_throughput      = 0
            resource_manager_tags       = {}
            size                        = 20
            storage_pool                = null
            type                        = "pd-standard"
        }
    }

    network_interface {
        internal_ipv6_prefix_length = 0
        ipv6_access_type            = null
        ipv6_address                = null
        name                        = "nic0"
        network                     = "https://www.googleapis.com/compute/v1/projects/skillbox-devops-basic/global/networks/app-network"
        network_ip                  = "10.0.1.4"
        nic_type                    = null
        queue_count                 = 0
        stack_type                  = "IPV4_ONLY"
        subnetwork                  = "https://www.googleapis.com/compute/v1/projects/skillbox-devops-basic/regions/us-west4/subnetworks/app-subnet"
        subnetwork_project          = "skillbox-devops-basic"

        access_config {
            nat_ip                 = "34.186.24.52"
            network_tier           = "PREMIUM"
            public_ptr_domain_name = null
        }
    }

    scheduling {
        automatic_restart           = true
        instance_termination_action = null
        min_node_cpus               = 0
        on_host_maintenance         = "MIGRATE"
        preemptible                 = false
        provisioning_model          = "STANDARD"
    }

    service_account {
        email  = "1058077648735-compute@developer.gserviceaccount.com"
        scopes = [
            "https://www.googleapis.com/auth/cloud-platform",
        ]
    }

    shielded_instance_config {
        enable_integrity_monitoring = true
        enable_secure_boot          = false
        enable_vtpm                 = true
    }
}
