# WordPress Devops

The WP Devops contains an environment is based on docker-compose. It supports site, plugin and theme development.

## Setting up environment

### Requirements

For this library [Composer](https://getcomposer.org/download/) and [Docker](https://www.docker.com/) is required. Please install before starting.

### Install

Add WP Devops functionality by using Composer. 

```bash
composer require awsmug/wp-devops:dev-master
```

Install the environment by setting up config files for git, composer, phpunit and so on.

```bash
vendor/bin/devops.sh init
```

Start the local server.

```bash
./devops.sh up
```

Stop the local server.

```bash
./devops.sh down
```

Updating devops scripts

```bash
./devops.sh down
```

### Open the site

The site can be reached at http://localhost at the browser. The admin can be reached at http://localhost/wp-admin/.

Use the user 'admin' and password 'password' to login.

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