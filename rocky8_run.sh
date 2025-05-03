export USERNAME=dockeruser
export CPUS=4.0
export MEMORY=16G
export SSH_PORT=2227
export VNC_PORT=5901
export NAME=rocky8_eda
export PKG=/home/saul/installs/pkg
export PROJECTS=/home/saul/projects/projects_docker

docker run -d --cpus ${CPUS} \
        --memory ${MEMORY} \
        -p $SSH_PORT:22 \
        -p $VNC_PORT:5901 \
        --name ${NAME} \
        -v ${PKG}:/pkg \
        -v ${PROJECTS}:/home/${USERNAME}/projects \
        -v /sys:/sys:ro \
        my_rocky
        
