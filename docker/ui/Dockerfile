FROM python:3.6.0-alpine

ENV MONGO mongodb
ENV MONGO_PORT 27017

RUN apk --no-cache --update add git && \
    git clone https://github.com/express42/search_engine_ui.git /app &&\
    pip install -r /app/requirements.txt

WORKDIR /app/ui
EXPOSE 8000
ENV FLASK_APP=ui.py
CMD [ "gunicorn", "ui:app", "-b", "0.0.0.0" ]
