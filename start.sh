#!/bin/bash

set -e 

echo $INDEX_HTML | base64 -d > /opt/work/index.html
echo $CONFIG_B64 | base64 -d > /opt/work/crouton.conf

exec crouton serve http --config /opt/work/crouton.conf --template /opt/work/index.html --dir-perms 0555 --file-perms 0555 --user $CC_USER --pass $CC_PASSWORD --dir-cache-time 1000h --log-level INFO --timeout 1h --no-modtime --umask 022 --read-only --addr 0.0.0.0:$CC_PORT jc: