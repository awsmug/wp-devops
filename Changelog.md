# Changelog

## 0.5.0
- Added dbexport param
- Set standard upload filesize to 20 MB
- Added cached param to www volume for faster work
- Different layers on PHP Dockerfile

## 0.4.0
- Added mailcatcher
- Building dockerfiles on startup

## 0.3.0
- Added hosts functions
- Working with container ID after changing container names by docker
- Fixed not working bin directory

## 0.2.0
- Added param for logs [logs]
- Added subparams for init [all/links/files]
- Fixed wrong quotations because of uppercase and spaced dir names
- Removed "restarting: always" of docker phpMyAdmin container
- Downgraded docker-compose.yml version to 3.2 because of compatibility

## 0.1.0
- Initial commit.