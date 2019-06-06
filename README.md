# Calibre server in a container

TODO(provisioning):

* Calibre will not start on an empty library
* Manage libraries
* Automatic certbot certificate renewal

TODO(workflow):

* Support both authenticated and anonymous users simultaneously [reddit]

[reddit]: https://www.reddit.com/r/Calibre/comments/bx5wvq/how_to_enable_both_authenticated_and_anonymous/

## Setup Calibre users

Run the interactive `manage-users` admin service.

```
# docker-compose -f docker-compose.yml -f admin.yml \
                 run --rm manage-users
```

## Setup SSL

Obtain a SSL certificate using the certbot admin service.  The certificates
will be stored in a docker volume mapped to `/etc/letsencrypt` in the certbot
container.

```
# docker-compose -f docker-compose.yml -f admin.yml \
                 run --rm --service-ports           \
                 certbot certonly
```

Add the `--dry-run` option to `certbot` to test out the configuration before
executing the command live.

# Management

## Library organization

See [Universal Decimal Classification].

[Universal Decimal Classification]: https://en.wikipedia.org/wiki/Universal_Decimal_Classification

## File formats

Prefer EPUB over other formats, see [EPUB].

[EPUB]: https://blog.reedsy.com/epub-vs-mobi-vs-pdf/

# Other resources

COPS [COPS].

[COPS]: https://hub.docker.com/r/linuxserver/cops/
