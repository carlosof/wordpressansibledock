#!/bin/bash
set -e

newUser(){
    echo "MAQ2-->usuarioBD-->${USUARIO}" > /root/datos.txt
    useradd -rm -d /home/"${USUARIO}" -s /bin/bash "${USUARIO}" 
    echo "root:${PASSWD}" | chpasswd
    echo "${USUARIO}:${PASSWD}" | chpasswd
}

config_Sudoers(){
    echo "${USUARIO} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
}

config_ssh(){
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
    sed -i 's/#Port 22/Port 22/' /etc/ssh/sshd_config
    if [ ! -d /root/.ssh ]
    then
        mkdir /root/.ssh
        cat /root/id_rsa.pub >> /root/.ssh/authorized_keys
    fi
    /etc/init.d/ssh start
}

main(){
    newUser
    config_Sudoers
    config_ssh
}

main

tail -f /dev/null