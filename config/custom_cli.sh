#!/bin/bash

###################################
# Author: Ibrar Ansari
# Date: 20-05-2025
# Version: 1
#
# This is my ustom commands script
###################################

########################
## Installation steps ##
########################
# nano custom_cli.sh
# chmod +x custom_cli.sh
# bash custom_cli.sh


COMMAND_PATH=/usr/bin
GIVE_PERMISSION='chmod 777'

# Create Help command
echo $COMMAND_PATH/dhp
cat << 'EOF' > $COMMAND_PATH/dhp
#!/bin/bash
echo "dpl = docker pull"
echo "dis = docker images"
echo "drn = docker run"
echo "dps = docker ps -a"
echo "dpe = docker ps exited containers"
echo "dhc = docker healthcheck"
echo "dpp = list containers with ports only"
echo "dpi = list containers without command column"
echo "dpia = list containers with my format"
echo "dsp = docker stop"
echo "dst = docker start"
echo "drt = docker restart"
echo "dre = docker rename"
echo "dec = docker exec -it"
echo "dls = logs -fn 20 $1"
echo "drm = docker rm -f"
echo "dri = docker rmi -f"
echo "dit = docker inspect"
echo "dvl = docker volume ls"
echo "dss = docker stats"
echo "drs = docker rm $(docker ps -q -f status=exited)"
echo "dhy = docker history"
echo "ddi = docker rmi $(docker images --filter "dangling=true" -q --no-trunc)"
echo "drntest = docker run -itd --name=test $1 /bin/bash"
EOF
$GIVE_PERMISSION $COMMAND_PATH/dhp

# Create static command which can not create with generator
echo $COMMAND_PATH/dec
cat << 'EOF' > $COMMAND_PATH/dec
#!/bin/bash
dec() {
  docker exec -it "$@" /bin/bash
}
dec $1
EOF
$GIVE_PERMISSION $COMMAND_PATH/dec

echo $COMMAND_PATH/decx
cat << 'EOF' > $COMMAND_PATH/decx
#!/bin/bash
decx() {
  docker exec -it "$@" /bin/sh
}
decx $1
EOF
$GIVE_PERMISSION $COMMAND_PATH/decx

echo $COMMAND_PATH/dpi
cat << 'EOF' > $COMMAND_PATH/dpi
#!/bin/bash
clear && echo -e "List of running containers" && docker ps --format "table {{.ID}}\t{{.RunningFor}}\t{{.Status}}\t{{.Image}}\t{{.Names}}"
EOF
$GIVE_PERMISSION $COMMAND_PATH/dpi

echo $COMMAND_PATH/dpp
cat << 'EOF' > $COMMAND_PATH/dpp
#!/bin/bash
clear && docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Ports}}"
EOF
$GIVE_PERMISSION $COMMAND_PATH/dpp


echo $COMMAND_PATH/dpe
cat << 'EOF' > $COMMAND_PATH/dpe
#!/bin/bash
clear && docker ps -a -f "status=exited"
EOF
$GIVE_PERMISSION $COMMAND_PATH/dpe

echo $COMMAND_PATH/dup
cat << 'EOF' > $COMMAND_PATH/dup
#!/bin/bash
dup() {
    # Check if the new `docker compose` command exists by checking its version
    if docker compose version > /dev/null 2>&1; then
        # Use the newer 'docker compose' command
        #echo "Using 'docker compose up -d'"
        docker compose up -d
    elif docker-compose version > /dev/null 2>&1; then
        # Fallback to the older 'docker-compose' command
        #echo "Using 'docker-compose up -d'"
        docker-compose up -d
    else
        # If neither command is found
        echo "Error: Docker Compose not found!"
        return 1
    fi
}
dup
EOF
$GIVE_PERMISSION $COMMAND_PATH/dup

echo $COMMAND_PATH/ddown
cat << 'EOF' > $COMMAND_PATH/ddown
#!/bin/bash
ddown() {
    # Check if the new `docker compose` command exists by checking its version
    if docker compose version > /dev/null 2>&1; then
        # Use the newer 'docker compose' command
        #echo "Using 'docker compose down'"
        docker compose down
    elif docker-compose version > /dev/null 2>&1; then
        # Fallback to the older 'docker-compose' command
        #echo "Using 'docker-compose down'"
        docker-compose down
    else
        # If neither command is found
        echo "Error: Docker Compose not found!"
        return 1
    fi
}
ddown
EOF
$GIVE_PERMISSION $COMMAND_PATH/ddown

echo $COMMAND_PATH/dhc
cat << 'EOF' > $COMMAND_PATH/dhc
#!/bin/bash
clear
echo "Fetching container status..."
echo "TABLE OF CONTAINER HEALTH STATUS"
echo "-------------------------------------"
docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Ports}}\t{{.Status}}" | while read -r line; do
    if [[ $line == *"Up"* ]]; then
        container_id=$(echo $line | awk '{print $1}')
        health=$(docker inspect --format='{{.State.Health.Status}}' $container_id 2>/dev/null || echo "N/A")
        echo -e "$line\t$health"
    else
        echo "$line"
    fi
done
EOF
$GIVE_PERMISSION $COMMAND_PATH/dhc


echo $COMMAND_PATH/dpia
cat << 'EOF' > $COMMAND_PATH/dpia
#!/bin/bash
clear && docker ps --format "table {{.Names}}\t{{.ID}}\t{{.Status}}\t{{.Ports}}\t{{.Image}}\t{{.Command}}\{{.RunningFor}}\{{.Status}}"
EOF
$GIVE_PERMISSION $COMMAND_PATH/dpia

# Generate all docker commands
generate_docker_command() {
    local cmd_name="$1"
    local cmd_content="$2"
    cat <<EOF > "$COMMAND_PATH/$cmd_name"
#!/bin/bash
$cmd_content
EOF
    $GIVE_PERMISSION "$COMMAND_PATH/$cmd_name"
}

# put \ before $ in every commands
docker_commands=(
    "ll:ls -alshtrin"
    "dpl:docker pull \$1"
    "dis:docker images"
    "drn:docker run \$1"
    "dps:docker ps -a"
    "dsp:docker stop \$1"
    "dst:docker start \$1"
    "drt:docker restart \$1"
    "dre:docker rename \$1"
    "dls:docker logs --tail 20 -f \$1"
    "drm:docker rm \$1 -f"
    "dri:docker rmi \$1 -f"
    "dit:docker inspect \$1"
    "dvl:docker volume ls"
    "dss:docker stats"
    "drs:docker rm \$(docker ps -q -f status=exited)"
    "dhy:docker history \$1"
    "ddi:docker rmi \$(docker images --filter \"dangling=true\" -q --no-trunc)"
    "drntest:docker run -itd --name=test \$1 /bin/bash"
    # Add more commands here
)

# Write commands
for cmd in "${docker_commands[@]}"; do
    IFS=':' read -ra cmd_parts <<< "$cmd"
    cmd_name="${cmd_parts[0]}"
    cmd_content="${cmd_parts[1]}"
    generate_docker_command "$cmd_name" "$cmd_content"
done


# Uninstall all commands
# cd /usr/bin && rm -rf dpl dis drn dps dsp drt dre dls drm dri dit dvl dss drs dhy ddi dec dhp
