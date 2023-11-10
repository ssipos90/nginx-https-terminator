# Nginx HTTPS Terminator

Simple container for terminating SSL/TSL for an application.

## Getting Started

Required environment variables:

- `UPSTREAM` - A host and port without protocol (for example `192.0.2.64:3000`)

Optional environment variables:

- `SUBJ` - The subject line used when generating a self signed certificate.
- `SERVER_NAME` - Added in nginx as the `server_name` directive and used in the
  subject line if generating a self signed certificate and SUBJ is not provided.

The image looks for the certificate and private key at
`/etc/nginx/certs/server.crt` and `/etc/nginx/certs/server.key` respectively.
Set up a volume with the `server.crt` and `server.key` or individual volumes
like below:

```shell
docker run \
      --name https-term \
      -v /some/host/some.crt:/etc/nginx/certs/server.crt \
      -v /some/host/some.key:/etc/nginx/certs/server.key \
      -e UPSTREAM=www.google.com \
      ssipos90/nginx-https-terminator
```

Not specifying either of the files, generates self signed certificates:

```shell
docker run \
      --name https-term \
      -e UPSTREAM=www.google.com \
      ssipos90/nginx-https-terminator
```

## Credits

- Base [nginx](https://registry.hub.docker.com/_/nginx/) docker image
- Snippets from [nginx-proxy](https://github.com/nginx-proxy/nginx-proxy)
- Inspired from
  [nginx-ssl-terminator](https://github.com/PurpleBooth/nginx-ssl-terminator)

## License

See [LICENSE.md](LICENSE.md)
