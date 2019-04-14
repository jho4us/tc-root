#!/bin/bash
## Author: Andrey Ivanov <jho4us@gmail.com>
## Version: 0.1.0
## Description: Script for bundling, building & deploying a web app with Docker

set -e

REBUILD=true

while getopts nh opt; do
    case $opt in
	h) echo "Usage: $0 target" && exit 1;;
        n) echo "Keep previous build"; REBUILD=false;;
	*) echo "No reasonable options found!";;
    esac
done	
shift $((OPTIND-1))

BASE_APP_NAME=tc-backend

BASE_DOCKER_TAG=jho4us/$BASE_APP_NAME
											#     Folder will be created and after build will be deleted
PRODUCTION_APP_NAME=$BASE_APP_NAME
PRODUCTION_DOCKER_TAG=$BASE_DOCKER_TAG:latest

APP_NAME=$PRODUCTION_APP_NAME
DOCKER_TAG=$PRODUCTION_DOCKER_TAG
ROOT_URL=$PRODUCTION_ROOT_URL
BUILD_ENV=production

echo "Building & deploying $DOCKER_TAG to $TARGET"
echo ""

echo "Start building container ${DOCKER_TAG} ..."

# Start Timestamp
STARTTIME=`date +%s.%N`

# build container
docker build --rm -t ${DOCKER_TAG} . &&

echo "End build of container ${CONTAINER} ..."

# End timestamp
ENDTIME=`date +%s.%N`
# Convert nanoseconds to milliseconds
# crudely by taking first 3 decimal places
TIMEDIFF=`echo "$ENDTIME - $STARTTIME" | bc | awk -F"." '{print $1"."substr($2,1,3)}'`

echo "Time elapsed: $TIMEDIFF"
