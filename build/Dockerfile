FROM cm2network/steamcmd:latest
LABEL maintainer="gumi@jo3qma.com, ayame@kataba.me"
EXPOSE 8211/udp
EXPOSE 27015/udp
EXPOSE 27015/tcp
ENV TZ=Asia/Tokyo
STOPSIGNAL SIGINT
SHELL ["/bin/bash", "-c"]
COPY --chmod=755 ./*.sh /home/steam/scripts/
VOLUME /home/steam/palworld
WORKDIR /home/steam/palworld
ENTRYPOINT ["/home/steam/scripts/entrypoint.sh"]
