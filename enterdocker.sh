#!/bin/bash

# Define the name of the container
CONTAINER_NAME="ardupilot_container"

# Define the Docker image to use (replace with your image name)
IMAGE_NAME="ardupilot"

# Define the local and container directory paths (replace with your paths)
LOCAL_DIRECTORY="/home/schoff2/workspace/DroneSprayer"
CONTAINER_DIRECTORY="/workspace/DroneSprayer"

# Check if the container is already running
if docker ps -a | grep -q "$CONTAINER_NAME"; then
    echo "Container $CONTAINER_NAME already exists."

    if docker ps | grep -q "$CONTAINER_NAME"; then
        echo "Attaching to the running container..."
        docker exec -it "$CONTAINER_NAME" bash
    else
        echo "Starting and attaching to the stopped container..."
        docker start "$CONTAINER_NAME"
        docker attach "$CONTAINER_NAME"
    fi
else
    echo "Running a new container..."
    docker run -it --rm \
	   -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix \
	   -p 5760-5860:5760-5860 \
	   --name "$CONTAINER_NAME" -v "$LOCAL_DIRECTORY:$CONTAINER_DIRECTORY" "$IMAGE_NAME"
fi

