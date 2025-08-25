initialize "pki" {
  request "enable" {
    operation = "create"
    path = "sys/mounts/pki"
    data = {
      type = "pki"
      max_lease_ttl = "8760h"
    }
  }
  request "generate_root" {
    operation = "create"
    path = "pki/root/generate/internal"
    data = {
      common_name = "bao.local"
      ttl = "8760h"
    }
  }
  request "cluster" {
    operation = "create"
    path = "pki/config/cluster"
    data = {
      path = "http://127.0.0.1:8080/v1/pki"
    }
  }
  request "acme" {
    operation = "create"
    path = "pki/config/acme"
    data = {
      enabled = true
    }
  }
  request "role" {
    operation = "create"
    path = "pki/roles/bao-local"
    data = {
      allowed_domains = "bao.local"
      allow_subdomains = true
      allow_localhost = true
      allow_ip_sans = true
    }
  }
}
