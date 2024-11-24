#!/bin/bash

export CORNN_DIR=/CoRNN_T1

source $CORNN_DIR/venv/bin/activate
python3 $CORNN_DIR/src/generate.py $@
deactivate
