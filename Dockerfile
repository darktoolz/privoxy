# syntax=docker/dockerfile:1
FROM alpine:latest AS builder
RUN apk --no-cache add privoxy ca-certificates curl
COPY .curlrc /root/
WORKDIR /etc/privoxy
RUN for i in *.new; do mv $i `basename $i .new`; done
COPY config /etc/privoxy/config
EXPOSE 8118
CMD ["/usr/sbin/privoxy", "--no-daemon", "/etc/privoxy/config"]
HEALTHCHECK --start-period=30s --start-interval=3s --retries=3 --timeout=6s --interval=30s CMD curl google.com || exit 1
