# Ruby on Rails + MySQL Dockerfile

This repository contains a Dockerfile of Ruby on Rails and MySQL for Docker's automated build published to the public Docker Hub Registry.

## What's included

- Ruby 2.3.1
- Rails 4.2.6
- MySQL (latest)

## Installation

1. Install [Docker](https://www.docker.com/).

2. Download [automated build](https://registry.hub.docker.com/u/interactsoftware/rails-mysql/) from public [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull interactsoftware/rails-mysql`

(alternatively, you can build an image from Dockerfile: `docker build -t="interactsoftware/rails-mysql" github.com/marcioluiz/rails-mysql`)

### Usage

  docker run -it --rm interactsoftware/rails-mysql

### Run `ruby`

  docker run -it --rm interactsoftware/rails-mysql ruby

### Run `mysql`

  docker run -it --rm interactsoftware/rails-mysql mysql
