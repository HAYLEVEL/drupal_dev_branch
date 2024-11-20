#!/bin/bash
if [[ -n "$PANTHEON_ENVIRONMENT" ]]; then
    echo "You try to set a pre-commit hook on the Pantheon server. Skipping!"
else
    cp ./.githooks/pre-commit ./.git/hooks/pre-commit
    chmod +x ./.git/hooks/pre-commit
    npm install
    echo "The pre-commit hook installed"
fi
