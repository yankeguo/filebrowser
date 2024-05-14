FROM alpine:3.19

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN apk add --no-cache ca-certificates curl tini

RUN curl -sSLo filebrowser.tar.gz 'https://github.com/filebrowser/filebrowser/releases/download/v2.29.0/linux-amd64-filebrowser.tar.gz' && \
    mkdir -p /tmp/filebrowser && \
    tar -xvf filebrowser.tar.gz -C /tmp/filebrowser && \
    mv /tmp/filebrowser/filebrowser /filebrowser && \
    rm -rf filebrowser.tar.gz /tmp/filebrowser

WORKDIR /data

ENTRYPOINT [ "/sbin/tini", "--" ]

CMD ["/filebrowser", "-a", "0.0.0.0", "-r", "/srv", "-p", "80"]