SHELL := /bin/bash
PROJECT_NAME := $(shell basename $(PWD))

.PHONY: run_colima, run_mysql, run_sonar, clean, stop_all, run_DBNEWSQL, connect_db

default:
	@echo "Please specify a target to run"

run_colima:
	colima stop && colima start --cpu 2 --memory 3 --mount-type 9p --arch aarch64
	colima exec -- sudo sysctl -w vm.max_map_count=262144

run_mysql:
  ## Print directory
	@echo "Starting project $(PROJECT_NAME)..."
	@echo "Preparing environment..."
	@echo "directory: $(PWD)"
	cd docker/mysql && make run_db

run_sonar:
	cd docker/sonarQube && make run_all

clean:
	# yes | docker system prune -a
	yes | docker container prune
	yes | docker volume prune -a
	yes | docker network prune
	# yes | docker image prune

stop_all:
	docker ps -aq | xargs docker stop | xargs docker rm


run_DBNEWSQL:
	cd docker/newsqlDB && make run_db

connect_db:
	mysql -u root -h localhost -P 3306 -p
