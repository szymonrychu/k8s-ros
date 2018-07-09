#!/bin/bash
if [ -z "$FAKENECT_PATH" ]; then
    echo "Using default fakenect path /session"
    export FAKENECT_PATH="/session"
fi
export LD_PRELOAD="/usr/lib/x86_64-linux-gnu/fakenect/libfreenect.so"
