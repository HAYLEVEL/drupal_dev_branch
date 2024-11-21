# GrumPHP, CI, and pre-commit. Setup, usage, and features.
This repository contains a configuration file for GrumPHP, a tool for enforcing code quality checks in your Git workflow. 
The configuration integrates tools like PHPCS, ESLint, Composer checks, Trivy, and PHPMD to ensure best practices and secure coding standards are followed.

## Configuration Overview
### 1. PHP CodeSniffer (PHPCS)

Standards:
 - Drupal
 - DrupalPractice

Triggered By:
 - File extensions: .php, .install, .module, .theme, .inc, .test, .profile, .info, .yml

Report Format:
 - checkstyle
### 2. ESLint

Bin:
 - node_modules/.bin/eslint

Metadata:
 - Enabled.

Triggered By:
 - File extensions: .js, .jsx, .ts, .tsx, .vue

Configuration File:
 - ci_configuration/.eslintrc.json

Format:
 - Not specified (defaults to ESLint's standard output).
### 3. Composer

Checks:
 - composer.json file for validity.

Ensures dependencies are correctly managed.
Options:
 - no_check_all: false
 - no_check_lock: false
 - no_check_publish: false
 - no_local_repository: false
 - with_dependencies: false
 - strict: false
### 4. Shell

Script:
```Runs Trivy to check for filesystem vulnerabilities:```

### 5. PHPMD

Report Format:
 - text

Ruleset:
 - cleancode
 - codesize
 - naming
 - unusedcode

Triggered By:
 - File extension: .php

## Usage Instructions

### 1. Install Dependencies

Run composer install. Check the post-install-cmd section in composer.json for better understanding of process.:
```
composer install
```

Run npm install for installing eslint and required dependencies
```
npm install
```
