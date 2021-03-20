FROM ubuntu
RUN apt update && apt install -yq --no-install-recommends \
    apt-utils \
    wget \
    nano \
    net-tools \
    sudo \
    curl \
    unzip \
    openssh-server \
    openssh-client \
    dos2unix \
    python3\
    software-properties-common

#indicamos el timezone
ARG TZ=Europe/Madrid
ENV TZ=${TZ}
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

EXPOSE 22

COPY ./id_rsa.pub /root
COPY ./start.sh /root

RUN dos2unix /root/start.sh 
RUN chmod +x /root/start.sh
ENTRYPOINT [ "/root/start.sh" ]