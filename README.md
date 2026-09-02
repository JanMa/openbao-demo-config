# OpenBao Demo Config

This repository contains the configuration to setup a demo OpenBao cluster to
showcase latest features.

To connect to the `bao.local` domain, add the following to `/etc/hosts`:

```
127.0.0.1  bao.local
```

And then run:

```
$ BAO_ADDR=http://localhost:8080 bao read -field=certificate pki-root/cert/ca > root.pem
$ BAO_ADDR=https://bao.local:8200 BAO_CAPATH=root.pem bao write auth/userpass/login/admin password=sup3rs3cr3t
```

Note that for ACME issuance to work, you'll have to run as root to bind to
port `80` for solving HTTP challenges (or, bind the listener to port 443 for
solving ALPN challenges).

```
$ reset ; sudo rm -rf storage certmagic && sudo mkdir storage && sudo bao server -exit-on-core-shutdown -config=openbao.d
```
