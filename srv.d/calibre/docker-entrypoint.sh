#!/bin/sh
CALIBRE_LIBRARIES="$(echo /books/*)"
export CALIBRE_LIBRARIES
exec "$@"
