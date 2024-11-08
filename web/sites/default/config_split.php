<?php
if (getenv('DRUPAL_ENV') === 'production') {
  $config['config_split.config_split.config_development']['status'] = FALSE;
  $config['config_split.config_split.config_production']['status'] = TRUE;
}
elseif(getenv('DRUPAL_ENV') === 'development') {
  $config['config_split.config_split.config_development']['status'] = TRUE;
  $config['config_split.config_split.config_production']['status'] = FALSE;
}
else {
  $config['config_split.config_split.config_development']['status'] = FALSE;
  $config['config_split.config_split.config_production']['status'] = FALSE;
}
