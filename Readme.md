# WordPress Devops

The WP Devops contains an environment is based on docker-compose. It supports site, plugin and theme development.

## Setting up environment

### Requirements

For this library [Composer](https://getcomposer.org/download/) and [Docker](https://www.docker.com/) is required. Please 
install before starting.

### Install

Add WP Devops functionality by using Composer. 

```bash
composer require awsmug/wp-devops:dev-master
```

Install the environment by setting up config files. Just follow the instructions. If you have setup a theme or a plugin
installation you can put your code to the ./src directory and it will be displayed in the wp-admin theme or plugin 
section.

```bash
vendor/bin/devops.sh init
```

Start the local server (After the first start, just wait a while until you see a ready installed WordPress):

```bash
./devops.sh up
```

Stop the local server:

```bash
./devops.sh down
```

Updating devops scripts:

```bash
./devops.sh update
```

### Open the site

The site can be reached at http://localhost at the browser. The admin can be reached at http://localhost/wp-admin/.

Use the user 'admin' and password 'password' to login.

### WP-CLI

Use the WP CLI with the wp.sh script. Example to list all plugins (see the documentation of WP CLI at https://wp-cli.org):

```bash
./wp.sh plugin list
```

### Debugging

To debug your script we implemented Xdebug to the PHP configuration. To get it running for your project, just add your 
local IP to the php.ini file. This can be done in the 'conf/php' directory and replace the *#DEBUG_REMOTE_IP#* string with 
your local IP. The default remote debugging port is *9000*.

### phpMyAdmin

You can reach the phpMyAdmin interface at the URL http://localhost:8080.

## System

### Docker environment for development

In contrast to the one container structure of the WordPress docker container, the WP devops is based on a docker-compose 
environment which is a lot more configurable. It contains a docker-compose file for the three types of development for 
sites, themes and plugins. 

The environment contains:

* Nginx
* PHP (with Xdebug)
* Mariadb
* WordPress
* WP-CLI
* phpMyAdmin