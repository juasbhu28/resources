SHELL := /bin/bash
PROJECT_NAME := $(shell basename $(PWD))

.PHONY: run_all build_docker run_docker run_colima

run_all:
	@echo "Starting project $(PROJECT_NAME)..."
	@echo "Preparing docker..."
	make build_docker
	@echo "Running docker..."
	make run_docker

build_docker:
	docker-compose up --build -d

run_docker:
	docker-compose up

run_colima:
	colima stop && colima start --cpu 2 --memory 3 --mount-type 9p --arch aarch64
	colima exec -- sudo sysctl -w vm.max_map_count=262144
