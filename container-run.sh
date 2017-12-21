#!/bin/bash

# Install block dependencies
cd /nio/project
# Find any requirements.txt files at the first level of a block and install it
find blocks -name requirements.txt -maxdepth 2 | xargs -I {} pip install -r {}

# Run nio
exec nio_run -r /nio/project
