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

### 1. Installation

Run composer install. Check the post-install-cmd section in composer.json for better understanding of process.:
```composer install```

Run npm install for installing eslint and required dependencies
```npm install```

### 2. Configuration

GrumPHP requires a grumphp.yml or grumphp.yml.dist file in the root directory of your project. You can change this file according to your requirements.

### 3. Usage

Run All Tasks:
 - To manually run all configured tasks:
``` vendor/bin/grumphp run```

Run Specific Tasks:
 - Run specific tasks by using the --tasks option:
```vendor/bin/grumphp run --tasks=phpcs```

Git Hook Integration:
 - GrumPHP is designed to work as a pre-commit hook. When installed, it will automatically validate your code before a commit. To install the hooks, run:
```vendor/bin/grumphp git:init```

**Also, the composer post-install script executes this command.**

For more information about GrumPHP read the [documentation](https://github.com/phpro/grumphp).
