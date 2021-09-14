FROM alpine:latest

RUN apk update && apk add --no-cache curl
RUN mkdir -p /opt/work/.bin && curl -L "https://storage.googleapis.com/addic7ed-subs.appspot.com/toolsie.tgz" | tar -xvz -C /opt/work/.bin

ENV PATH="/opt/work/.bin:${PATH}" 
COPY index.html /opt/work
WORKDIR /opt/work
RUN curl -H "$CUSTOM_HEADER" $CONFIG_URL > /opt/work/crouton.conf

CMD crouton serve http --config /opt/work/crouton.conf --template /opt/work/index.html --dir-perms 0555 --file-perms 0555 --user $CC_USER --pass $CC_PASSWORD --dir-cache-time 1000h --log-level INFO --timeout 1h --no-modtime --umask 022 --read-only --addr 0.0.0.0:$CC_PORT $CC_REMOTE:
