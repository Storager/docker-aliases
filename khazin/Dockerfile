# Usage:
# docker run -it --rm \
# -v ${PWD}/_data/dropbox.config:/config/dropbox_uploader.config:ro \
# -e FTP_SERVER=127.0.0.1
# -e FTP_PATH=/path/on/server
# storager/khazin https://rutube.ru/video/6c09456e9150d9b0b0c7f44ad1905f61 local

FROM python:3

WORKDIR /app

RUN apt-get update \
    && apt-get install -y ffmpeg curl

ADD /requirements.txt .

RUN pip install -r requirements.txt 

ADD / .

ENTRYPOINT [ "bash", "/app/entrypoint.sh" ]

CMD ["$@"]
