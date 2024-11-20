#!/bin/bash

export CORNN_DIR=/CoRNN_T1
export SCIL_DIR=/apps/scilpy

source $CORNN_DIR/venv/bin/activate
python $CORNN_DIR/src/generate.py $@
deactivate