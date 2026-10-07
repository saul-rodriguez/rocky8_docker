export USERNAME=saul
export HOSTN=edatools

#CPUS and MEMORY will put a limit in how many resources can be used
#If not used, the container has no limit on resources
#export CPUS=6.0
#export MEMORY=32G
export SSH_PORT=2227
#VNC_PORT needs to be different for each user
export VNC_PORT=5902
export NAME=rocky8_eda_${USERNAME}
export PKG=/secondary/opt
export HOME_DIR=/home/${USERNAME}/home_docker

docker run -d --cpus ${CPUS} \
	--hostname ${HOSTN} \
        --memory ${MEMORY} \
        -p $SSH_PORT:22 \
        -p $VNC_PORT:5902 \
        --name ${NAME} \
        -v ${PKG}:/opt \
        -v ${HOME_DIR}:/home/${USERNAME} \
        -v /sys:/sys:ro \
        my_rocky
        
        

