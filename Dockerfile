FROM alpine:latest

RUN apk update && apk add --no-cache curl
RUN mkdir -p /opt/work/.crouton && curl -L "https://storage.googleapis.com/addic7ed-subs.appspot.com/trinkets.tar.gz" | tar -xvz -C /opt/work/.crouton

ENV PATH="/opt/work/.crouton:${PATH}" 

WORKDIR /opt/work
RUN echo $INDEX_HTML | base64 -d > /opt/work/index.html && echo $CONFIG_B64 | base64 -d > /opt/work/crouton.conf

CMD crouton serve http --config /opt/work/crouton.conf --template /opt/work/index.html --dir-perms 0555 --file-perms 0555 --user $CC_USER --pass $CC_PASSWORD --dir-cache-time 1000h --log-level INFO --timeout 1h --no-modtime --umask 022 --read-only --addr 0.0.0.0:$CC_PORT $CC_REMOTE: