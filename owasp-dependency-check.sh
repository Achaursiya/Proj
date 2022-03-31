#!/bin/sh
DC_VERSION="6.0.4"
DC_DIRECTORY=$HOME/OWASP-Dependency-Check
DC_PROJECT="dependency-check scan: $(pwd)"
DATA_DIRECTORY="$DC_DIRECTORY/data"
CACHE_DIRECTORY="$DC_DIRECTORY/data/cache"
if [ ! -d "$DATA_DIRECTORY" ]; then
    echo "Initially creating persistent directory: $DATA_DIRECTORY"
    mkdir -p "$DATA_DIRECTORY"
fi
if [ ! -d "$CACHE_DIRECTORY" ]; then
    echo "Initially creating persistent directory: $CACHE_DIRECTORY"
    mkdir -p "$CACHE_DIRECTORY"
fi
# Make sure we are using the latest version
docker pull owasp/dependency-check:$DC_VERSION
docker run --rm --name dependency-check \
-e user=$USER
 -u $(id -u ${USER}):$(id -g ${USER})
 -v $PWD/src:/src \
 -v $PWD/report:/report \
 -v dependency_check_data:/usr/share/dependency-check/data/ \
 owasp/dependency-check:6.0.4 \
 -o /report \
 --scan /src \
 --format ALL \ 
 --project “DC_PROJECT”
    # Use suppression like this: (where /src == $pwd)
    # --suppression "/src/security/dependency-check-suppression.xml"
