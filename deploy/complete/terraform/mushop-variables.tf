# Copyright (c) 2020, 2021 Oracle and/or its affiliates. All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl.
# 

# MuShop
## Ingress/LoadBalancer
variable "ingress_nginx_enabled" {
  default     = true
  description = "Enable Ingress Nginx for Kubernetes Services (This option provision a Load Balancer)"
}
variable "ingress_load_balancer_shape" {
  default     = "flexible" # Flexible, 10Mbps, 100Mbps, 400Mbps or 8000Mps
  description = "Shape that will be included on the Ingress annotation for the OCI Load Balancer creation"
}
variable "ingress_load_balancer_shape_flex_min" {
  default     = "10"
  description = "Enter the minimum size of the flexible shape."
}
variable "ingress_load_balancer_shape_flex_max" {
  default     = "100"
  description = "Enter the maximum size of the flexible shape (Should be bigger than minimum size). The maximum service limit is set by your tenancy limits."
}
variable "ingress_hosts" {
  default     = ""
  description = "Enter a valid full qualified domain name (FQDN). You will need to map the domain name to the EXTERNAL-IP address on your DNS provider (DNS Registry type - A). If you have multiple domain names, include separated by comma. e.g.: mushop.example.com,catshop.com"
}
variable "cert_manager_enabled" {
  default     = true
  description = "Enable x509 Certificate Management"
}
variable "ingress_tls" {
  default     = false
  description = "If enabled, will generate SSL certificates to enable HTTPS for the ingress using the Certificate Issuer"
}
variable "ingress_cluster_issuer" {
  default     = "letsencrypt-prod"
  description = "Certificate issuer type. Currently supports the free Let's Encrypt and Self-Signed. Only *letsencrypt-prod* generates valid certificates"
}
variable "ingress_email_issuer" {
  default     = "no-reply@mushop.ateam.cloud"
  description = "You must replace this email address with your own. The certificate provider will use this to contact you about expiring certificates, and issues related to your account."
}


## Features
variable "mushop_mock_mode_all" {
  default     = false
  description = "If enabled, will not provision ATP Database, Object Storage, or Streaming. The services will run in mock mode and will connect to an in-memory database, and the data will not persist"
}

variable "mushop_micronaut_service_version" {
  default = "native"
  type = string
  description = "Every MuShop service has one of three version: using GraalVM for java runtime, using openjdk for java runtime and GraalVM native image."

  validation {
    condition     = contains(["native", "graalvm", "openjdk"], var.mushop_micronaut_service_version)
    error_message = "Allowed values for mushop_micronaut_service_version are \"native\", \"graalvm\", or \"openjdk\"."
  }
}

## Common Services (MuShop Utilities)
variable "grafana_enabled" {
  default     = true
  description = "Enable Grafana Dashboards. Includes example dashboards and Prometheus, OCI Logging and OCI Metrics datasources"
}
variable "prometheus_enabled" {
  default     = true
  description = "Enable Prometheus"
}
variable "metrics_server_enabled" {
  default     = true
  description = "Enable Metrics Server for Metrics, HPA, VPA and Cluster Auto Scaler"
}
variable "catalog_enabled" {
  default     = false
  description = "Enable Service Catalog to use with OCI Service Broker"
}

## Secrets
variable "db_admin_name" {
  default = "oadb-admin"
}
variable "db_connection_name" {
  default = "oadb-connection"
}
variable "db_wallet_name" {
  default = "oadb-wallet"
}
variable "oos_bucket_name" {
  default = "oos-bucket"
}
variable "apm_connection_name" {
  default = "oapm-connection"
}
variable "oss_conection" {
  default = "oss-connection"
}

## Deployment details
variable "oci_deployment" {
  default = "oci-deployment"
}

# OCI Services
## Autonomous Database
variable "autonomous_database_cpu_core_count" {
  default = 1
}

variable "autonomous_database_data_storage_size_in_tbs" {
  default = 1
}

variable "autonomous_database_data_safe_status" {
  default = "NOT_REGISTERED" # REGISTERED || NOT_REGISTERED

  validation {
    condition     = var.autonomous_database_data_safe_status == "REGISTERED" || var.autonomous_database_data_safe_status == "NOT_REGISTERED"
    error_message = "Sorry, but database license model can only be REGISTERED or NOT_REGISTERED."
  }
}

variable "autonomous_database_db_version" {
  default = "19c"
}

variable "autonomous_database_license_model" {
  default = "BRING_YOUR_OWN_LICENSE" # LICENSE_INCLUDED || BRING_YOUR_OWN_LICENSE

  validation {
    condition     = var.autonomous_database_license_model == "BRING_YOUR_OWN_LICENSE" || var.autonomous_database_license_model == "LICENSE_INCLUDED"
    error_message = "Sorry, but database license model can only be BRING_YOUR_OWN_LICENSE or LICENSE_INCLUDED."
  }
}

variable "autonomous_database_is_auto_scaling_enabled" {
  default = false
}

variable "autonomous_database_is_free_tier" {
  default = false
}
variable "autonomous_database_visibility" {
  default = "Public"

  validation {
    condition     = var.autonomous_database_visibility == "Private" || var.autonomous_database_visibility == "Public"
    error_message = "Sorry, but database visibility can only be Private or Public."
  }
}
variable "autonomous_database_wallet_generate_type" {
  default = "SINGLE"
}

variable "apm_zipkin_enabled" {
  default = true
}

variable "apm_zipkin_url" {
  default = ""
}

variable "apm_zipkin_path" {
  default = ""
}

variable "newsletter_service_name" {
  default = "mushop-newsletter"
}