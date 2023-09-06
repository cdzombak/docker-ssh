#!/bin/bash

# Set the root passwd on each container start; check for it in Docker logs.
ROOT_PASSWORD=$(pwgen -c -n -1 32)
echo "root:$ROOT_PASSWORD" | chpasswd
echo "root login password: $ROOT_PASSWORD"

# Launch supervisor
supervisord -n
