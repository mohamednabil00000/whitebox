# README

It is a sample application for creating projects and tasks and assign tasks for specific users.

## Features

* Rails 7
* Ruby 3.2
* Dockerfile and Docker Compose configuration
* Heroku configration using foreman
* PostgreSQL database
* Devise auth & jwt token based
* Rspec & Factorybot
* GitHub Actions for
  * tests
  * security checks
  * Rubocop for linting(upcoming)
* I18n
* Logger(upcoming)
* Swagger(upcoming)


## Requirements

Please ensure you have docker & docker-compose

https://www.theserverside.com/blog/Coffee-Talk-Java-News-Stories-and-Opinions/How-to-install-Docker-and-docker-compose-on-Ubuntu

https://dockerlabs.collabnix.com/intermediate/workshop/DockerCompose/How_to_Install_Docker_Compose.html

Check your docker compose version with:
```
% docker compose version
Docker Compose version v1.27.4
```

## Initial setup
```
$ cp .env.example .env
$ cd docker
$ docker-compose build
```

## Running the Rails app
```
$ docker-compose --env-file ../.env up
```
## Running the Rails console
When the app is already running with `docker-compose` up, attach to the container:
```
$ docker-compose exec app bin/rails c
```
When no container running yet, start up a new one:
```
$ docker-compose run --rm app bin/rails c
```
## Running tests
```
$ docker-compose run --rm app bin/rspec
```

## Postman script
```
There is a postman script that contains the whole scenario.
you can find it in postman folder.
```

## Author

**Mohamed Nabil**

- <https://www.linkedin.com/in/mohamed-nabil-a184125b>
- <https://leetcode.com/mohamednabil00000/>

