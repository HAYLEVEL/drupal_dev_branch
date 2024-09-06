	To use the pre-commit pipeline, make sure that the correct configurations are set
        ---------------------------------------------------------------------------------


1)
	Firstly you need to replace your pre-commit file which is stored in .git/hooks directory. 
	Also if you want to change the file inside .githooks and your changes are applied to .git/hooks/ you need create symbolic link.

2)
	Secondly you need install PHPCS:
	  - composer global require "squizlabs/php_codesniffer=*"

3)
	After that you need set right configuration:
	  vendor/bin/phpcs --config-set installed_paths vendor/drupal/coder/coder_sniffer
	  vendor/bin/phpcs --config-set default_standard Drupal,DrupalPractice

4)
	Enjoy it!
