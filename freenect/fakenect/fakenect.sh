#!/bin/bash
if [ -z "$FAKENECT_PATH" ]; then
    echo "Provide FAKENECT_PATH pointing to session recording"
    exit 1
fi
LD_PRELOAD="/usr/lib/x86_64-linux-gnu/fakenect/libfreenect.so" $@
