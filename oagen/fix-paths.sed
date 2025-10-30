#!/usr/bin/env -S sed -f

# change /local/ to ./
# required for the pipeline

s/\/local\//.\//g