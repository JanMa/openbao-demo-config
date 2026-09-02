ui            = true
cluster_addr  = "https://127.0.0.1:8201"
api_addr      = "https://127.0.0.1:8200"

log_level  = "trace"

storage "raft" {
  path = "storage"
  node_id = "node_1"
}

listener "tcp" {
  address       = "0.0.0.0:8200"

  tls_acme_ca_directory = "http://127.0.0.1:8080/v1/pki-int-acme/roles/bao-local/acme/directory"
  tls_acme_cache_path   = "./certmagic"
  tls_acme_domains = ["bao.local"]
}

listener "tcp" {
  address       = "127.0.0.1:8080"
  tls_disable   = true
}

seal "static" {
  current_key_id = "demo"
  current_key = "b0p2yCyCMhT2CIJ8QerO3tzCxCufXWjKfEVC3mRX4VQ="
}

audit "file" "stdout" {
  options = {
    file_path = "stdout"
    log_raw = "true"
  }
}
