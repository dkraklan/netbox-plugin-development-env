NETBOX_VERSION=${NETBOX_VERSION:-master}
VENV :=$(shell pwd -P)/netbox/venv
PYTHON :=$(shell which python3)


#all
.PHONY: all
all: build install 

#Build
.PHONY: build
build: netbox/.git
	sudo docker compose build
	
netbox/.git:
	git clone --single-branch --branch=${NETBOX_VERSION} https://github.com/netbox-community/netbox.git netbox/

#venv
.PHONY: venv
venv: netbox/requirements.txt 
	${PYTHON} -m venv ${VENV}
	${VENV}/bin/pip install --upgrade pip
	${VENV}/bin/pip install -r netbox/requirements.txt
	
#Update
.PHONY: update
update: netbox/.github
	cd netbox && git pull
	
#Run
.PHONY: run
run:
	sudo docker compose up

#Stop
.PHONY: stop
stop:
	sudo docker compose down

#Clean
.PHONY: clean
clean:
	rm -rf netbox
	rm -rf /var/lib/postgresql/data
	docker compose down
	docker compose rm
