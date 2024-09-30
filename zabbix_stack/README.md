# In this folder, you can find zabbix stack configuration on docker which can monitor your site and server. Also, you can add a notification about problems.

## Requirements:

1. Installed docker and docker compose.
2. Working stack of Portainer+Traefik
3. Configured subdomain for Zabbix

## Deployment Stack

1. Add zabbix stack from zabbix.yml file to your runnig Portainer.
2. Import variables from .env file to the stack.
3. Up stack.
4. Check container logs and ensure that everything is working as it should.
5. Log in Zabbix using your subdomain <em>(Defaul user - Admin password - zabbix).</em>
6. Import Hosts from zbx_export_hosts.yaml file.
7. Add your custom metrics and configurations.

## Preconfigured users groups and hosts

1. User:Group
         server:server - user for remote server monitoring 
         website:website - user for website monitoring
         liqx:Zabbix administrators - new admin user

# The capabilities of this stack

1. Web application monitoring.
2. Server monitoring.
3. Sending a letter to the server user's mail if CPU unilization for 5 minutes is more than 90%.
4. Sending a letter to the website user's mail if the site returns a 404 error.

