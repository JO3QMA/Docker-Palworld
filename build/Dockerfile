FROM cm2network/steamcmd:root
LABEL maintainer="gumi@jo3qma.com, ayame@kataba.me"
EXPOSE 8211/udp
EXPOSE 27015/udp
EXPOSE 27015/tcp
ENV TZ=Asia/Tokyo
ENV TICKRATE=60
STOPSIGNAL SIGINT
SHELL ["/bin/bash", "-c"]
RUN apt update && apt install -y --no-install-recommends \
      xdg-user-dirs \
      procps \
      python3 \
      python3-iniparse && \
      apt clean && \
      rm -rf /var/lib/apt/lists/* && \
      curl "https://raw.githubusercontent.com/pixelb/crudini/0.9.5/crudini.py" -o "/usr/local/bin/crudini" && \
      chmod +x /usr/local/bin/crudini && \
      ln -s /usr/bin/python3 /usr/bin/python
USER steam
COPY --chmod=755 --chown=steam:steam ./*.sh /home/steam/scripts/
VOLUME /home/steam/palworld
WORKDIR /home/steam/palworld
ENTRYPOINT ["/home/steam/scripts/entrypoint.sh"]
