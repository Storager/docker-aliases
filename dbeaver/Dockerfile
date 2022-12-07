# Usage
# docker run -it --rm  \
# -v /tmp/.X11-unix:/tmp/.X11-unix \
# -v ${HOME}/docker-apps/dbeaver:/root/.local/share/DBeaverData/workspace6 \
# -v ${HOME}/docker-apps/dbeaver/drivers:/root/.local/share/DBeaverData/drivers \
# -v ${HOME}/.ssh:/root/.ssh:ro \
# -e DISPLAY=172.16.123.1:0 \
# -e GDK_DPI_SCALE \
# -e GDK_SCALE \
# storager/dbeaver

FROM ubuntu:20.04 as Downloader
RUN apt-get update \
    && apt-get install -y wget
RUN  wget "https://dbeaver.io/files/dbeaver-ce-latest-linux.gtk.$(uname -m)-nojdk.tar.gz" -O /tmp/dbeaver.tgz \
    && tar -xvvf /tmp/dbeaver.tgz -C /opt/

FROM ubuntu:20.04
COPY --from=Downloader /opt/dbeaver /opt/dbeaver
RUN apt-get update \
    && apt-get install -y \
        default-jdk \
        libswt-gtk-4-java \
        libwebkit2gtk-4.0-37 \
    && apt-get clean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT [ "/opt/dbeaver/dbeaver" ]