DB = docker build -t
DP = docker push
TAG = latest
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
	$(DB) crawler_ui docker/search_engine_ui
	docker image tag crawler_ui $(USER_NAME)/crawler_ui:$(TAG)

crawler:
	$(DB) crawler docker/search_engine_crawler
	docker image tag crawler $(USER_NAME)/crawler:$(TAG)

push:
	$(DP) $(USER_NAME)/crawler_ui:$(TAG)
	$(DP) $(USER_NAME)/crawler:$(TAG)

.PHONY: crawler ui push
