# Run tor browser in a container
#
# docker run -v /tmp/.X11-unix:/tmp/.X11-unix \
# 	-v /dev/snd:/dev/snd \
# 	-v /dev/shm:/dev/shm \
# 	-v /etc/machine-id:/etc/machine-id:ro \
# 	-e DISPLAY=unix$DISPLAY \
# 	storager/intellij-idea
# WSL:
# docker run -d --rm -v /tmp/.X11-unix:/tmp/.X11-unix -v /mnt/wslg:/mnt/wslg \
#    -e DISPLAY=$DISPLAY -e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
#    -e XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR -e PULSE_SERVER=$PULSE_SERVER \
#    -v ${HOME}/docker-apps/idea/config:/root/.config \
#    -v ${HOME}/docker-apps/idea/workspace:/root/workspace \
#    -v ${HOME}/docker-apps/idea/share:/root/.local/share/JetBrains \
#    -v ${HOME}/docker-apps/idea/cache:/root/.cache/JetBrains \
#    -v ${HOME}/docker-apps/idea/jdks:/root/.jdks \
#    storager/intellij-idea
FROM busybox as Unarchiver
ARG IDEA_VERSION
# ADD https://download.jetbrains.com/idea/ideaIC-2023.3.5.tar.gz /tmp
ADD https://download.jetbrains.com/idea/${IDEA_VERSION}.tar.gz /tmp
# ADD /ideaIC-2023.3.5.tar.gz /tmp/
ENV IDEA_VERSION=${IDEA_VERSION}
RUN cd /tmp \
    && tar -xvvf *.tar.gz \
    && mv idea-IC* ./idea


FROM ubuntu:20.04

RUN useradd storager -m -s /bin/bash \
    && mkdir /app \
    && chown storager:storager /app \
    && apt-get update \
    && apt-get install -y \
        fontconfig \
        libfreetype6 \
        libxrender1 \
        libxi6 \
	    libxtst6 \
	    ttf-dejavu
USER storager
COPY --from=Unarchiver --chown=storager:storager /tmp/idea /app/
USER root
ENTRYPOINT /app/bin/idea.sh 
