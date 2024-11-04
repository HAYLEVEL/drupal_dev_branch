#!/bin/bash

# Parse arguments
REMOTE_USER=$1
REMOTE_HOST=$2
ENVIRONMENT_CONTAINER=$3
BITBUCKET_BRANCH=$4
NODE_CONTAINER=$5
BITBUCKET_COMMIT=$6
SITE_DIR=$7

# Connect to remote
ssh $REMOTE_USER@$REMOTE_HOST << EOF
CURRENT_COMMIT_HASH=\$(docker exec $ENVIRONMENT_CONTAINER sh -c 'git rev-parse HEAD')

red() { echo -e "\033[0;31m\$1\033[0m" }
green() { echo -e "\033[0;32m\$1\033[0m" }
yellow() { echo -e "\033[1;33m\$1\033[0m" }

deploy_func() {( set -e  # Exit if any command within the function fails
    git checkout origin/$BITBUCKET_BRANCH
    git pull origin $BITBUCKET_BRANCH

    yellow "Starting database backup--------------------------------------"
    docker exec $ENVIRONMENT_CONTAINER sh -c 'vendor/bin/drush sql:dump --result-file=/var/www/html/back_sql/backup.sql --gzip --skip-tables-list=cache*'
    docker cp $ENVIRONMENT_CONTAINER:/var/www/html/back_sql/backup.sql.gz ~/back_sql/$DEPLOYMENT_ENVIRONMENT/backup_$BITBUCKET_COMMIT.sql.gz

    yellow "Deploy to docker stack----------------------------------------"
    docker start $NODE_CONTAINER
    sleep 20
    docker exec $ENVIRONMENT_CONTAINER sh -c 'composer install --optimize-autoloader'
    docker exec $ENVIRONMENT_CONTAINER sh -c 'vendor/bin/drush deploy -y -v'
)}

rollback_func() {( set -e  # Exit if any command within the function fails
    yellow "Reverting Drupal site to commit hash \$CURRENT_COMMIT_HASH"
    git checkout \$CURRENT_COMMIT_HASH
    docker exec $ENVIRONMENT_CONTAINER sh -c 'composer install --optimize-autoloader'
    docker start $NODE_CONTAINER
    sleep 20
    docker exec $ENVIRONMENT_CONTAINER sh -c 'vendor/bin/drush deploy -y -v'
)}

########################################################################
cd "\$SITE_DIR"
deploy_func
DEPLOY_EXIT_CODE=\$?
if [ \$DEPLOY_EXIT_CODE -ne 0 ]; then
    red "Deployment failed with exit code \$DEPLOY_EXIT_CODE"
    rollback_func
    ROLLBACK_EXIT_CODE=\$?
    if [ \$ROLLBACK_EXIT_CODE -ne 0 ]; then
        red "Rollback failed with exit code \$ROLLBACK_EXIT_CODE"
        exit \$ROLLBACK_EXIT_CODE
    else
        yellow "Rollback succeeded but deployment failed with exit code \$DEPLOY_EXIT_CODE"
        exit \$DEPLOY_EXIT_CODE
    fi
else
    green "Deployment succeeded-----------------------------------------"
    exit 0
fi
EOF
