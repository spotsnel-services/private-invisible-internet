ARG TSVERSION=1.40.1
ARG TSFILE=tailscale_${TSVERSION}_amd64.tgz

FROM alpine:latest as build
ARG TSFILE
WORKDIR /app

RUN wget https://pkgs.tailscale.com/stable/${TSFILE} && \
  tar xzf ${TSFILE} --strip-components=1
COPY . ./


FROM geti2p/i2p:latest

COPY --from=build /app/tailscaled /app/tailscaled
COPY --from=build /app/tailscale /app/tailscale
COPY start.sh /app/start.sh

# Mount home and snark
VOLUME ["${APP_HOME}/.i2p"]
VOLUME ["/i2psnark"]

RUN mv /startapp.sh /app/starti2p.sh

ENTRYPOINT ["/app/start.sh"]
