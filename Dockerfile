# https://help.github.com/en/actions/building-actions/creating-a-docker-container-action

# Container image that runs your code
FROM vvakame/review:latest

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# ラベルの内容を増やす必要があるときは\（継続マーカー）を利用すること（LABELで始まるLABEL命令を増やさない） 
LABEL maintainer="mhidaka <rabbitlog@gmail.com>"

RUN apt-get update && apt-get install -y \
build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev python3-pip \
&& pip install --break-system-packages pygments && wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq && \
chmod +x /usr/bin/yq

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
