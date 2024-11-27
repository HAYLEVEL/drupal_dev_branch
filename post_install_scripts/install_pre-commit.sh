#!/bin/bash
if [[ -n "$PANTHEON_ENVIRONMENT" ]]; then
    echo "You try to set a pre-commit hook on the Pantheon server. Skipping!"
else
    ./vendor/bin/grumphp git:init
    npm install
    echo "The pre-commit hook installed"
fi
