initialize "pki-root" {
  request "enable" {
    operation = "create"
    path = "sys/mounts/pki-root"
    data = {
      type = "pki"
      max_lease_ttl = "8760h"
    }
  }
  request "generate_root" {
    operation = "create"
    path = "pki-root/root/generate/internal"
    data = {
      common_name = "Root R1"
      ttl = "8760h"
    }
  }
}
