FROM python:3.5.3
MAINTAINER n.io <info@n.io>

# Setup Volume
VOLUME ["/nio/project"]

# Expose Ports
EXPOSE 8181

# Move pre run script into container
COPY ["container-entrypoint.sh", "/nio/bin/"]
ENTRYPOINT ["/nio/bin/container-entrypoint.sh"]

ARG WHEEL_FILE
ARG PK_WHEEL_FILE

# update pip
RUN pip3 install --upgrade pip setuptools

# Install Wheels
# Uncomment following lines to install PK server
# COPY $PK_WHEEL_FILE /nio/
# RUN pip3 install /nio/$PK_WHEEL_FILE && rm /nio/$PK_WHEEL_FILE

COPY $WHEEL_FILE /nio/
RUN pip3 install /nio/$WHEEL_FILE && rm /nio/$WHEEL_FILE

COPY default_project /nio/project

# Launch nio
CMD ["niod", "-r", "/nio/project"]
