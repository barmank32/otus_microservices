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
	$(DB) crawler_ui docker/ui
	docker image tag crawler_ui $(USER_NAME)/crawler_ui:$(TAG)

crawler:
	$(DB) crawler docker/crawler
	docker image tag crawler $(USER_NAME)/crawler:$(TAG)

test_ui:
	$(DB) crawler_ui:test -f docker/ui/Dockerfile_test docker/ui

test_crawler:
	$(DB) crawler:test -f docker/crawler/Dockerfile_test docker/crawler

push:
	$(DP) $(USER_NAME)/crawler_ui:$(TAG)
	$(DP) $(USER_NAME)/crawler:$(TAG)

.PHONY: crawler ui test_ui  test_crawler push
