FROM python:3.5.3
MAINTAINER n.io <info@n.io>

# We will use tini to be our process launcher so that it passes signals
# down the process tree to our n.io process.
# This allows us to use container-run.sh like scripts to do some pre-work
# and then run n.io in the script.
# https://github.com/krallin/tini
ENV TINI_VERSION v0.14.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

ENTRYPOINT ["/tini", "-g", "--"]

# Setup Volume
VOLUME ["/nio/project"]

# Expose Ports
EXPOSE 8181

ARG WHEEL_FILE

# Install Wheel
COPY $WHEEL_FILE /nio/

RUN pip3 install /nio/$WHEEL_FILE && rm /nio/$WHEEL_FILE

# Move scripts into container
COPY ["container-run.sh", "/nio/bin/"]

COPY default_project /nio/project

# Commands
CMD ["/bin/bash", "/nio/bin/container-run.sh"]
