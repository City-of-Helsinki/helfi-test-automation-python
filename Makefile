RELEASE_NAME ?= gs952
ARCHIVE_NAME ?= ghostpcl-9.52-linux-x86_64
DOCKER_REPOSITORY = ghcr.io/city-of-helsinki/helfi-test-automation-python
DOCKER_TAG ?= 1.0
PROJECT_GIT ?= https://github.com/City-of-Helsinki/drupal-helfi.git
PROJECT_DIR ?= build/project
STONEHENGE_PATH ?= /stonehenge

.PHONY: build-docker-image push-docker-image release-docker-image

build-docker-image:
	docker build -t $(DOCKER_REPOSITORY):$(DOCKER_TAG) --build-arg release_name=$(RELEASE_NAME) --build-arg archive_name=$(ARCHIVE_NAME) ./

push-docker-image:
	docker push $(DOCKER_REPOSITORY):$(DOCKER_TAG)

release-docker-image: build push

$(PROJECT_DIR)/.git:
	git clone $(PROJECT_GIT) $(PROJECT_DIR)

$(STONEHENGE_PATH)/.git:
	git clone -b 3.x https://github.com/druidfi/stonehenge.git $(STONEHENGE_PATH)

start-stonehenge:
	cd $(STONEHENGE_PATH) && make up

start-docker-compose:
	docker-compose up -d

create-project: $(PROJECT_DIR)/.git $(STONEHENGE_PATH)/.git start-stonehenge start-docker-compose
