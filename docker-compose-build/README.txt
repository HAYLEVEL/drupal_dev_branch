This is a simple docker-compose.yml with can help you create an LNMP stack for Drupal. 
In this case, MySql is used instead MariaDB.
Pay attention to the version db described in the .yml file. Also you need to have a backup.sql file and the right path to it. 

Use your own Drupal files for deployment.
Don`t forget to place these files on volumes attached to containers.
After configuring and replacing credentials to the database you can use docker-compose for starting containers.

Enjoy your site on port 8080 or change it in the ports section.
