# Ruby on Rails + Nodejs Dockerfile

This repository contains a Dockerfile of Ruby on Rails, nodejs and npm for Docker's automated build published to the public Docker Hub Registry.

## What's included

- Ruby 2.4.0
- Rails 4.2.6
- Nodejs (latest)
- npm

## Installation

1. Install [Docker](https://www.docker.com/).

2. Download [automated build](https://registry.hub.docker.com/u/interactsoftware/rails-node/) from public [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull interactsoftware/rails-node`

(alternatively, you can build an image from Dockerfile: `docker build -t="interactsoftware/rails-node" github.com/marcioluiz/rails-node`)

### Usage

  docker run -it --rm interactsoftware/rails-node

### Run `ruby`

  docker run -it --rm interactsoftware/rails-node ruby

### Run `node`

  docker run -it --rm interactsoftware/rails-node node
