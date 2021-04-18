#!/bin/bash -e
grep docker-compose spec.json | sed -e "s#\\\n#\n#g" | sed -e 's/",//g' | sed -e "s/    \"docker-compose\": \"//g" | sed -e 's#\\"#\"#g' > spec.yml
sed -i "s|image.*|$DOCKER_REGISTRY/$IMAGE:$CI_COMMIT_SHORT_SHA|g" spec.yml
