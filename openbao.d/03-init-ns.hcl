initialize "namespaces" {
  request "dev" {
    operation = "create"
    path = "sys/namespaces/dev"
  }
  request "nested" {
    operation = "create"
    path = "dev/sys/namespaces/nested"
  }
}

initialize "dev_admin" {
  request "policy" {
    operation = "create"
    path = "dev/sys/policy/dev-admin"
    data = {
      policy = <<-EOT
      path "*" {
        capabilities = [ "create", "read", "update", "delete", "list", "sudo" ]
      }
      EOT
    }
  }
  request "userpass" {
    operation = "create"
    path = "dev/sys/auth/userpass"
    data = {
      type = "userpass"
    }
  }
  request "admin" {
    operation = "create"
    path = "dev/auth/userpass/users/dev-admin"
    data = {
      password = "sup3rs3cr3t"
      token_policies = "default,dev-admin"
    }
  }
}
