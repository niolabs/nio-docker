#!/bin/bash

# Install block dependencies first
cd /nio/project
# Find any requirements.txt files at the first level of a block and install it
find blocks -name requirements.txt -maxdepth 2 | xargs -I {} pip install -r {}

# Run the arguments to this script as an executable
exec "$@"
