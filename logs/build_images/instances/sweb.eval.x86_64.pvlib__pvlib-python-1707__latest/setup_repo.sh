#!/bin/bash
set -euxo pipefail
git clone -o origin https://github.com/pvlib/pvlib-python /testbed
chmod -R 777 /testbed
cd /testbed
git reset --hard 40e9e978c170bdde4eeee1547729417665dbc34c
git remote remove origin
source /opt/miniconda3/bin/activate
conda activate testbed
echo "Current environment: $CONDA_DEFAULT_ENV"
python -m pip install -e .[all]
