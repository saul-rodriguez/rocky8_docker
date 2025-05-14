export USERNAME=saul
export CPUS=6.0
export MEMORY=32G
export SSH_PORT=2227
export VNC_PORT=5902
export NAME=rocky8_eda
export PKG=/opt
#export PROJECTS=/home/saul/projects/projects_docker
export HOME_DIR=/home/saul/projects/home_docker

docker run -d --cpus ${CPUS} \
        --memory ${MEMORY} \
        -p $SSH_PORT:22 \
        -p $VNC_PORT:5902 \
        --name ${NAME} \
        -v ${PKG}:/opt \
        -v ${HOME_DIR}:/home/${USERNAME} \
        -v /sys:/sys:ro \
        my_rocky
        
