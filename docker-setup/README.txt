This  simple script resolves the task below:

 - Up a Drupal website using docker commands (not docker compose).
 - Acceptance criteria: a bash script (could be named drupal_setup_docker.sh) that set up the Drupal site under containers + volumes + networks.

Steps for configuring drupal_setup_docker.sh:
	
	1)Check and change variables(you can use your existing database).
	2)Also, you must review and change the pass to docker volumes.
	3)You can start docker containers with database and Drupal.
	4)After the previous three steps, I checked and changed ownerships and permissions on MySQL files. This needs to be done in volume attached to drupal-db container.
	5)Enjoy your site on 8080 port.
