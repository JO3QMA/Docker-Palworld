FROM cm2network/steamcmd
ENV TZ=Asia/Tokyo

RUN mkdir -p /home/steam/scripts
COPY --chmod=755 entrypoint.sh /home/steam/scripts/
COPY --chmod=755 start.sh /home/steam/scripts/

ENTRYPOINT ["/bin/bash", "/home/steam/scripts/entrypoint.sh"]