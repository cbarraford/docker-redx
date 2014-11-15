#!/bin/bash

# configure config.lua
./configure.bash

command="$@"
${command}
