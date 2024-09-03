	To use the pre-commit pipeline, make sure that the correct configurations are set
---------------------------------------------------------------------------------
		vendor/bin/phpcs --config-set installed_paths vendor/drupal/coder/coder_sniffer
		vendor/bin/phpcs --config-set default_standard Drupal,DrupalPractice
