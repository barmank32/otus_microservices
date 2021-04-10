DB = docker build -t
DP = docker push
TAG = 1.0
USER_NAME = barmank32

ifeq ($(USER_NAME),)
    $(info USER_NAME is empty. Examle export USER_NAME=user)
	exit 1
endif

all:
	@echo "make build - Builds all images"
	@echo "make push - Push all images"

build: ui crawler

ui:
	$(DB) $(USER_NAME)/crawler_ui:$(TAG) docker/ui

crawler:
	$(DB) $(USER_NAME)/crawler:$(TAG) docker/crawler

push:
	$(DP) $(USER_NAME)/crawler_ui:$(TAG)
	$(DP) $(USER_NAME)/crawler:$(TAG)

.PHONY: crawler ui
