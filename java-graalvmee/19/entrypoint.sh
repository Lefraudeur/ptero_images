#!/bin/bash
cd /home/container || (exit 1 && echo "Unable to change to /home/container. Something went real wrong.")

# Configure colors
CYAN='\033[0;36m'
BLUE='\033[0;34m'
RESET_COLOR='\033[0m'

# Print Current Java Version
java -version

# Set environment variable that holds the Internal Docker IP
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

echo -e "JAVA 19 GraalVM Enterprise Edition
By Lefraudeur: ${BLUE}https://github.com/Lefraudeur/ptero_images${RESET_COLOR}"
# Replace Startup Variables
# shellcheck disable=SC2086
MODIFIED_STARTUP=$(echo -e ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo -e "${CYAN}STARTUP /home/container: ${MODIFIED_STARTUP} ${RESET_COLOR}"

# Run the Server
# shellcheck disable=SC2086
eval ${MODIFIED_STARTUP}
