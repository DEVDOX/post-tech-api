#!/usr/bin/env bash

docker-compose build
docker-compose run --rm app mix deps.get
docker-compose run --rm app mix ecto.reset
