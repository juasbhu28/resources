SHELL := /bin/bash
PROJECT_NAME := $(shell basename $(PWD))

# Puedes usar un comando para generar un valor único, como la fecha y hora actual
CACHEBUST := $(shell date +%s)

.PHONY: run_db

run_db:
	docker-compose up -d mysql_latest
	# docker build -t your-mysql-image .
	# docker run -d --name your-mysql-container -p 3306:3306 your-mysql-image
