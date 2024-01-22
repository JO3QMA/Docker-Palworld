FROM cm2network/steamcmd:latest
ENV TZ=Asia/Tokyo
COPY --chmod=755 entrypoint.sh start.sh /home/steam/scripts/
ENTRYPOINT ["/bin/bash", "/home/steam/scripts/entrypoint.sh"]
