FROM python:3.10-slim-buster

ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1

RUN apt-get update \
    && apt-get install -y --no-install-recommends git postgresql-client libpq-dev gcc build-essential \
    && pip install --upgrade pip

# Install NetBox

COPY ./netbox /opt/netbox
RUN pip install -r /opt/netbox/requirements.txt

# Install Netbox Plugin
#COPY . /test-plugin 
copy ./test-plugin /plugin/test-plugin
RUN pip install --editable /plugin/test-plugin

COPY dev-entrypoint.sh /opt/dev-entrypoint.sh

WORKDIR /opt/netbox/netbox
ENTRYPOINT ["/opt/dev-entrypoint.sh"]
