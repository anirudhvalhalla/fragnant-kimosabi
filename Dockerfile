FROM alpine:latest

RUN apk update && apk add --no-cache curl
RUN mkdir -p /opt/work/.crouton && curl -L "https://storage.googleapis.com/addic7ed-subs.appspot.com/trinkets.tar.gz" | tar -xvz -C /opt/work/.crouton

ENV PATH="/opt/work/.crouton:${PATH}" 

WORKDIR /opt/work
COPY start.sh /opt/work
RUN chmod +x /opt/work/start.sh
RUN adduser -D myuser
USER myuser

CMD /opt/work/start.sh