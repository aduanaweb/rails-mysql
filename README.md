Ruby on Rails + Nodejs Dockerfile

This repository contains a Dockerfile of Ruby on Rails, nodejs and npm for Docker's automated build published to the public Docker Hub Registry.

What's included

Ruby 2.4.0
Rails 4.2.6
Nodejs (latest)
npm
Installation

Install Docker.

Download automated build from public Docker Hub Registry: docker pull marcioluiz/rails-node

(alternatively, you can build an image from Dockerfile: docker build -t="marcioluiz/rails-node" github.com/marcioluiz/rails-node)

Usage

docker run -it --rm marcioluiz/rails-node
Run ruby

docker run -it --rm marcioluiz/rails-node ruby
Run node

docker run -it --rm marcioluiz/rails-node node
