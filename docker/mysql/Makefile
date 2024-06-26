SHELL := /bin/bash
PROJECT_NAME := $(shell basename $(PWD))

# Puedes usar un comando para generar un valor único, como la fecha y hora actual
CACHEBUST := $(shell date +%s)

.PHONY: run, test_api, .precommit, run_colima, run_db, start_db, clean

run:
	@echo "Starting project $(PROJECT_NAME)..."
	@echo "Preparing environment..."
	fury run


test_api:
	@echo "Testing API..."
	fury test
	./gradlew clean build test
	fury code-quality run
	docsify serve docs/guide

.precommit:
	@echo "Installing pre-commit hooks..."
	pre-commit install
	pre-commit run --all-files


run_colima:
	colima stop && colima start --cpu 2 --memory 3 --mount-type 9p --arch aarch64
	colima exec -- sudo sysctl -w vm.max_map_count=262144

run_db:
	docker-compose up -d newsql
	# docker build -t your-mysql-image .
	# docker run -d --name your-mysql-container -p 3306:3306 your-mysql-image


start_db:
	# make stop_all
	make run_colima
	make clean
	make run_db

clean:
	# yes | docker system prune -a
	yes | docker container prune
	yes | docker volume prune -a
	yes | docker network prune 
	# yes | docker image prune

stop_all:
	docker ps -aq | xargs docker stop | xargs docker rm
	
