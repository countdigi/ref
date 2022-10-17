# OpenSSL

## Convert PFX to private key and certificate PEMS

```bash
openssl pkcs12 -in domain.pfx -nocerts -out domain.key -nodes
openssl pkcs12 -in domain.pfx -nokeys -out domain.crt -nodes
```


## Match private key, certificate, and certificate request

```bash
openssl pkey -in privateKey.key -pubout -outform pem | sha256sum
openssl x509 -in certificate.crt -pubkey -noout -outform pem | sha256sum
openssl req -in CSR.csr -pubkey -noout -outform pem | sha256sum
```

## Print a certificate (without hex dump of pubkey or signature)

```bash
openssl x509 -in <file> -noout -text -certopt no_pubkey,no_sigdump
```


## Grab cert info via https

```bash
openssl s_client -showcerts -connect www.hii.usf.edu:443 </dev/null
```


## Generate a CSR

```bash
hostname=fe

openssl req -new \
  -sha256 \
  -nodes \
  -newkey rsa:2048 \
  -out ~/.private/${hostname}.epi.usf.edu \
  -keyout ~/.private/${hostname}.epi.usf.edu \
  -config <(cat <<-EOF

[req]
default_bits = 2048
prompt = no
default_md = sha256
req_extensions = req_ext
distinguished_name = dn

[ dn ]
C=US
postalCode=33612
ST=FL
L=Tampa
street=Suite 100
street=3650 Spectrum Blvd
O=University of South Florida
OU=Health Informatics Institute
emailAddress=systems@epi.usf.edu

[ req_ext ]
subjectAltName = @alt_names

[ alt_names ]
DNS.1 = ${hostname}.epi.usf.edu
DNS.2 = ${hostname}.hii.usf.edu
EOF
)
```
