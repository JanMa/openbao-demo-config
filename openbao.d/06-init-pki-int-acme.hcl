initialize "pki-int-acme" {
  request "enable" {
    operation = "create"
    path = "sys/mounts/pki-int-acme"
    data = {
      type = "pki"
      max_lease_ttl = "8760h"
      config = {
        allowed_response_headers = ["Replay-Nonce", "Link", "Location", "Last-Modified"]
        passthrough_request_headers = ["If-Modified-Since"]
      }
    }
  }
  request "generate_int" {
    operation = "create"
    path = "pki-int-acme/intermediate/generate/internal"
    data = {
      common_name = "Intermediate ACME A1"
      ttl = "8760h"
    }
  }
  request "sign_int" {
    operation = "create"
    path = "pki-root/root/sign-intermediate"
    data = {
      csr = {
        eval_source = "response"
        eval_type = "string"
        initialize_name = "pki-int-acme"
        response_name = "generate_int"
        field_selector = ["data", "csr"]
      }
      use_csr_values = true
    }
  }
  request "import_int" {
    operation = "create"
    path = "pki-int-acme/issuers/import/bundle"
    data = {
      pem_bundle = {
        eval_source = "response"
        eval_type = "string"
        initialize_name = "pki-int-acme"
        response_name = "sign_int"
        field_selector = ["data", "certificate"]
      }
    }
  }
  request "import_root" {
    operation = "create"
    path = "pki-int-acme/issuers/import/bundle"
    data = {
      pem_bundle = {
        eval_source = "response"
        eval_type = "string"
        initialize_name = "pki-int-acme"
        response_name = "sign_int"
        field_selector = ["data", "issuing_ca"]
      }
    }
  }
  request "cluster" {
    operation = "create"
    path = "pki-int-acme/config/cluster"
    data = {
      path = "http://127.0.0.1:8080/v1/pki-int-acme"
    }
  }
  request "acme" {
    operation = "create"
    path = "pki-int-acme/config/acme"
    data = {
      enabled = true
    }
  }
  request "role" {
    operation = "create"
    path = "pki-int-acme/roles/bao-local"
    data = {
      allowed_domains = "bao.local"
      allow_subdomains = true
      allow_bare_domains = true
      allow_localhost = true
      allow_ip_sans = true
      no_store = false
      key_type = "any"
    }
  }
}
