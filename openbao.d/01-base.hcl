ui            = true
cluster_addr  = "https://127.0.0.1:8201"
api_addr      = "https://127.0.0.1:8200"

storage "raft" {
  path = "storage"
  node_id = "node_1"
}

listener "tcp" {
  address       = "127.0.0.1:8200"
  tls_cert_file = "openbao.d/certs/bao.local.crt"
  tls_key_file  = "openbao.d/certs/bao.local.key"
}

seal "static" {
  current_key_id = "demo"
  current_key = "b0p2yCyCMhT2CIJ8QerO3tzCxCufXWjKfEVC3mRX4VQ="
}
