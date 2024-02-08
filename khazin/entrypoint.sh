WATCH_URL=$1

U_DEST=${2:-dropbox}

TMP_FOLDER=/tmp/ramdisk-$RANDOM

GATHER_FILE=`yt-dlp --print filename $WATCH_URL`
# GATHER_FILE='<<М. Хазин>>+： план США - как с Китаем кинуть Россию [pe7fO3_RnMM].webm'
echo "Will be gathered $GATHER_FILE ..."

FILE_TO_UPLOAD=`python3 -c "
from unidecode import unidecode
import re
s = unidecode('$GATHER_FILE')[:20]
s = re.sub(r'[^\w]', '_', s)
print(s)
"`

FILE_TO_WRITE=$TMP_FOLDER/${FILE_TO_UPLOAD}

echo "${FILE_TO_WRITE} will be written"

mount_disk(){
    mkdir $TMP_FOLDER
    sudo mount -t tmpfs -o size=150m myramdisk $TMP_FOLDER/
}

download_file() {
    echo "Gathering $GATHER_FILE"
    yt-dlp -f w -x --audio-format mp3 $WATCH_URL  -o "${FILE_TO_WRITE}.%(ext)s"
}


delete_local_files() {
    echo "Removing ${FILE_TO_WRITE}.mp3 ..."
    rm $FILE_TO_WRITE.mp3
}

upload_to_dropbox() {
    echo "Uploading ${FILE_TO_WRITE}.mp3 to DropBox ..."
    /app/dropbox_uploader.sh -f /config/dropbox_uploader.config upload ${FILE_TO_WRITE}.mp3 /
}

unmount_disk(){
    sudo umount $TMP_FOLDER
    rm -rf $TMP_FOLDER
    }

upload_localy() {
    curl -T ${FILE_TO_WRITE}.mp3 ftp://$FTP_SERVER/$FTP_PATH/
}
#################################################


download_file && \
if [ "${U_DEST}" == "dropbox" ]
  then
    upload_to_dropbox
  else
    upload_localy  
fi


