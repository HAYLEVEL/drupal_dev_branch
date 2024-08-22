#!/bin/bash

# Variables
DRUPAL_CONTAINER_NAME="drupal-site"
MYSQL_CONTAINER_NAME="drupal-db"
NETWORK_NAME="drupal-network"
MYSQL_ROOT_PASSWORD="password_root"
MYSQL_DATABASE="drupal_db"
MYSQL_USER="drupal_user"
MYSQL_PASSWORD="your_password"
DRUPAL_PORT="8080"

# Create a Docker network
echo "Creating Docker network: $NETWORK_NAME..."
docker network create $NETWORK_NAME

# Run the MySQL container
echo "Starting MySQL container: $MYSQL_CONTAINER_NAME..."
docker run --name $MYSQL_CONTAINER_NAME \
  --network $NETWORK_NAME \
  -v /home/serhii/volumes/mysql:/var/lib/mysql \
  -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD \
  -e MYSQL_DATABASE=$MYSQL_DATABASE \
  -e MYSQL_USER=$MYSQL_USER \
  -e MYSQL_PASSWORD=$MYSQL_PASSWORD \
  -d mysql:8.0.39

# Run the Drupal container
echo "Starting Drupal container: $DRUPAL_CONTAINER_NAME..."
docker run --name $DRUPAL_CONTAINER_NAME \
  --network $NETWORK_NAME \
  -v /home/serhii/volumes/drupal/modules:/opt/drupal/modules \
  -v /home/serhii/volumes/drupal/themes:/opt/drupal/themes \
  -v /home/serhii/volumes/drupal/sites:/opt/drupal/web/sites \
  -p $DRUPAL_PORT:80 \
  -d drupal:latest
