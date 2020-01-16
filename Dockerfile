FROM alpine:latest
LABEL maintainer "Steven Iveson <steve@iveson.eu>, Fatih Boy <fatih@enterprisecoding.com>"
LABEL source "https://github.com/fatihboy/nfs-server"
LABEL branch "master"

WORKDIR /

COPY files/ .

RUN apk add --no-cache --update --verbose nfs-utils bash iproute2 && \
    rm -rf /var/cache/apk /tmp /sbin/halt /sbin/poweroff /sbin/reboot && \
    mkdir -p /var/lib/nfs/rpc_pipefs /var/lib/nfs/v4recovery && \
    echo "rpc_pipefs    /var/lib/nfs/rpc_pipefs rpc_pipefs      defaults        0       0" >> /etc/fstab && \
    echo "nfsd  /proc/fs/nfsd   nfsd    defaults        0       0" >> /etc/fstab && \
    chmod +x /usr/bin/nfsd.sh

ENTRYPOINT ["/usr/bin/nfsd.sh"]
