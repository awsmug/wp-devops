# WordPress Devops

The WP Devops contains an environment is based on docker. It supports site, plugin and theme development.

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

## Local Development

### Docker container for development

The docker on which the environment is based contains.

* Nginx webserver
* WordPress
* WP-CLI
* PHP
* phpMyAdmin