VERSION := $(or $(NETBOX_VERSION),master)
VENV :=$(shell pwd -P)/netbox/venv
PYTHON :=$(shell which python3)


PHONY: help
help: # Show help for each of the Makefile recipes.
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  Makefile | sort | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done

.PHONY: all 
all: build venv## Build and install

.PHONY: build
build: netbox/.git #Clone the repo Build the docker containers
	sudo docker compose build
	
netbox/.git:
	git clone --single-branch --branch=${VERSION} https://github.com/netbox-community/netbox.git netbox/

.PHONY: venv
venv: netbox/requirements.txt  #Create a virtual environment and install the requirements
	${PYTHON} -m venv ${VENV}
	${VENV}/bin/pip install --upgrade pip
	${VENV}/bin/pip install -r netbox/requirements.txt
	
.PHONY: update
update: netbox/.github #Update the repo
	cd netbox && git pull
	
.PHONY: run
run: #Run the containers
	sudo docker compose up

.PHONY: stop
stop: #Stop the containers
	sudo docker compose down

.PHONY: clean
clean: #Remove netbox files, docker containers, and postgres data
	rm -rf netbox
	sudo docker compose down --volumes --rmi all

.PHONY: migrations
migrations: #Create migrations, use PLUGIN=plugin_name to create migrations for a plugin
	sudo docker compose exec netbox /opt/netbox/netbox/manage.py makemigrations ${PLUGIN}

.PHONY: migrate
migrate: #Apply migrations
	sudo docker compose exec netbox /opt/netbox/netbox/manage.py migrate
	
.PHONY: nbshell
nbshell: #Run the netbox shell
	sudo docker compose exec netbox /opt/netbox/netbox/manage.py nbshell
	
.PHONY: dbshell
dbshell: #Run the database shell
	sudo docker compose exec netbox /opt/netbox/netbox/manage.py dbshell
	
