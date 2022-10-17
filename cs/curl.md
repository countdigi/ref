# Curl Reference

## Post JSON

```bash
curl \
  --header "Content-Type: application/json" \
  --request POST \
  --data '{"username":"xyz", "password":"xyz"}' \
  http://localhost:3000/api/login
```

## Use Certificate to Authenticate

```bash
curl \
  --cacert /site/ca.crt \
  --cert /site/node.crt \
  --key /site/node.key \
  https://localhost
```

## Adding Headers

```bash
curl -v -s \
  --header 'Host: payments.iad.livingsocial.net' \
  --header "Accept: application/json" \
  --header "Accept-Encoding: gzip, deflate" \
  --header "Content-Length: 2" \
  --header "Content-Type: application/json" \
  --header "X-LivingSocial-API-Key: a9ed0def87fcdbbf47c4d22d7a9761016b12f59c"
  https://ls.com
```

## Get HTTP Return Code

```bash
curl -s -w "%{http_code}\n" -o /dev/null https://example.com
```

## Options

- `-i, --include` - Include the HTTP-header in the output.
- `-I, --head` - Fetch the HTTP-header only. For FTP or FILE displays the file size and last modification time only.
- `-L, --location` - Make curl redo the request on a redirect (3xx)
- `-s, --silent` - Silent or quiet mode. Don't show progress meter or error messages. Makes Curl mute.
- `-S, --show-error` - When used with -s it makes curl show an error message if it fails.
- `-u, --user <user:password>` - Specify the user name and password to use for server authentication.
- `-k, --insecure` - This option explicitly allows curl to perform "insecure" SSL connections and transfers.
- `-d, --data <data>` - (`'-d name=daniel -d skill=lousy'` would generate a post chunk that looks like `'name=daniel&skill=lousy'`)
- `--data-urlencode` - (`@foo.txt` - use the contents of file `foo.txt`)
