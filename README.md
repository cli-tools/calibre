# Calibre server in a container

This is a fancy system around `calibre-server` to allow both
authenticated users for content management and an anonymous
endpoint for mobile users.

Some "hacks" are needed in order for this:

* Mobile users are detected using the Agent string. See nginx/conf.d/default.conf.
* Two backends: one calibre-server for authenticated users and one for anonymous users.
* The backend for anonymous users is reloaded using [superfsmon] and supervisord as a process manager.
* The environment variable `CALIBRE_LIBRARIES` is initialized on container entry by `/docker-entrypoint.sh`.

A better solution might appear, follow discussion on [reddit].

[superfsmon]: https://github.com/timakro/superfsmon
[reddit]: https://www.reddit.com/r/Calibre/comments/bx5wvq/how_to_enable_both_authenticated_and_anonymous/

TODO(provisioning):

* Library management
* Automatic certbot certificate renewal

## Setup Docker Compose

Be sure to set the following variables, either by placing them in the `.env` file
together with the `docker-compose.yml` file and be sure to run `docker-compose` from
the same directory, -OR-, by exporting the environment variables into the shell.

```
build=production
COMPOSE_FILE=docker-compose.yml:production.yml
HOSTNAME=calibre.example.com
```

For local development, without SSL certificate, use the following environment:

```
build=development
COMPOSE_FILE=docker-compose.yml:development.yml
```

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

[COPS] could potentially be relevant to look at in detail at some point.

[COPS]: https://hub.docker.com/r/linuxserver/cops/
