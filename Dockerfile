FROM netboxcommunity/netbox:latest


COPY plugins/ /plugins/
# RUN /opt/netbox/venv/bin/pip install --editable /plugin/test-plugin

COPY dev-entrypoint.sh /opt/dev-entrypoint.sh

# WORKDIR /opt/netbox/netbox
ENTRYPOINT ["/opt/dev-entrypoint.sh"]
