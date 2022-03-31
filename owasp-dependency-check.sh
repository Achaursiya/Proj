#!/bin/bash
DC_VERSION="6.2.1"
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
docker pull owasp/dependency-check:6.2.1
docker run --rm --name dependency-check \ 
-v $(pwd)/src:/src \
-v $(pwd)/report:/report \ 
-v dependency_check_data:/usr/share/dependency-check/data/ \
owasp/dependency-check:6.2.1 \
-o /report  \ 
--scan /src \
--format ALL \
--project "dependency-check scan: $(pwd)"
    # Use suppression like this: (where /src == $pwd)
    # --suppression "/src/security/dependency-check-suppression.xml"
