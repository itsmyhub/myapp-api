FROM python:3.7-alpine
MAINTAINER amjad <itsbiznet@gmail.com>

ENV PYTHONUNBUFFERED 1

# initial: Install dependencies
#COPY ./requirements.txt /requirements.txt
#RUN pip install -r /requirements.txt

#
# Rev: Install dependencies
#
COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client
RUN apk add --update --no-cache --virtual .tmp-build-deps \
      gcc libc-dev linux-headers postgresql-dev
RUN pip install -r /requirements.txt
RUN apk del .tmp-build-deps

#
# Setup directory structure
#   Step 8/10 : COPY ./app /app
#   COPY failed: stat /var/lib/docker/tmp/docker-builder068359594/app: no such file or directory
#
#     On MBP it fails if directory is "/app" thus i manually created and ran build again...
#
RUN mkdir app
WORKDIR /app
COPY ./app /app

RUN adduser -D user
USER user
