#!/bin/bash

# Parse arguments
REMOTE_USER=$1
REMOTE_HOST=$2
ENVIRONMENT_CONTAINER=$3
BITBUCKET_BRANCH=$4
NODE_CONTAINER=$5
BITBUCKET_COMMIT=$6

# Connect to remote
ssh $REMOTE_USER@$REMOTE_HOST << EOF

  deploy_func
  DEPLOY_EXIT_CODE=\$?

  if [ \$DEPLOY_EXIT_CODE -ne 0 ]; then
    echo "Deployment failed with exit code \$DEPLOY_EXIT_CODE"
    exit \$DEPLOY_EXIT_CODE  # Propagate the error to the caller
  else
    echo "Deployment succeeded"
  fi







  deploy_func() {
    set -e  # Exit if any command within the function fails

    docker exec $ENVIRONMENT_CONTAINER sh -c 'git fetch && git checkout $BITBUCKET_BRANCH'
    docker exec $ENVIRONMENT_CONTAINER sh -c 'git pull origin $BITBUCKET_BRANCH'

    echo "Starting database backup--------------------------------------"
    docker exec $ENVIRONMENT_CONTAINER sh -c 'vendor/bin/drush sql:dump --result-file=/var/www/html/back_sql/backup.sql --gzip --skip-tables-list=cache*'
    docker cp $ENVIRONMENT_CONTAINER:/var/www/html/back_sql/backup.sql.gz ~/back_sql/$DEPLOYMENT_ENVIRONMENT/backup_$BITBUCKET_COMMIT.sql.gz

    echo "Deploy to docker stack----------------------------------------"
    docker start $NODE_CONTAINER
    sleep 20
    docker exec $ENVIRONMENT_CONTAINER sh -c 'composer install --no-dev --optimize-autoloader'
    docker exec $ENVIRONMENT_CONTAINER sh -c 'vendor/bin/drush deploy -y -v'
  }

EOF
