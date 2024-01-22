FROM cm2network/steamcmd:latest
ENV TZ=Asia/Tokyo
SHELL ["/bin/bash", "-c"]
COPY --chmod=755 entrypoint.sh start.sh healthcheck.sh /home/steam/scripts/
ENTRYPOINT ["/home/steam/scripts/entrypoint.sh"]
