# README

It is a sample application for creating projects and tasks and assign tasks for specific users.

## Features

* Rails 7
* Ruby 3.2
* Dockerfile and Docker Compose configuration
* Heroku configration using foreman
* PostgreSQL database
* GitHub Actions for
  * tests
  * Rubocop for linting

## Requirements

Please ensure you have docker & docker-compose

https://www.theserverside.com/blog/Coffee-Talk-Java-News-Stories-and-Opinions/How-to-install-Docker-and-docker-compose-on-Ubuntu

https://dockerlabs.collabnix.com/intermediate/workshop/DockerCompose/How_to_Install_Docker_Compose.html

Check your docker compose version with:
```
% docker compose version
Docker Compose version v2.10.2
```

## Initial setup
```
cp .env.example .env
cd docker
$ docker-compose build
```

## Running the Rails app
```
$ docker-compose up
```

## Running the Rails console
When the app is already running with `docker-compose` up, attach to the container:
```
$docker-compose exec app bin/rails c
```
When no container running yet, start up a new one:
```
$ docker-compose run --rm app bin/rails c
```
## Running tests
```
$ docker-compose run --rm app bin/rspec
```
## Author

**Mohamed Nabil**

- <https://www.linkedin.com/in/mohamed-nabil-a184125b>
- <https://leetcode.com/mohamednabil00000/>
