initialize "admin_user" {
  request "policy" {
    operation = "create"
    path = "sys/policy/admin"
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
    path = "sys/auth/userpass"
    data = {
      type = "userpass"
    }
  }
  request "admin" {
    operation = "create"
    path = "auth/userpass/users/admin"
    data = {
      password = "sup3rs3cr3t"
      token_policies = "default,admin"
    }
  }
}
