FROM python:3.6.0-alpine

ENV MONGO mongodb
ENV MONGO_PORT 27017

ENV RMQ_HOST rabbitmq
ENV RMQ_QUEUE 5672
ENV RMQ_USERNAME rabbitmq_user
ENV RMQ_PASSWORD rabbitmq_pass

ENV CHECK_INTERVAL 60
ENV EXCLUDE_URLS '.*github.com'

RUN apk --no-cache --update add git && \
    git clone https://github.com/express42/search_engine_crawler.git /app &&\
    pip install -r /app/requirements.txt

WORKDIR /app
ENTRYPOINT [ "python", "-u", "crawler/crawler.py" ]
CMD [ "https://vitkhab.github.io/search_engine_test_site/" ]
