#!/bin/bash
set -euxo pipefail
git clone -o origin https://github.com/pvlib/pvlib-python /testbed
chmod -R 777 /testbed
cd /testbed
git reset --hard 27a3a07ebc84b11014d3753e4923902adf9a38c0
git remote remove origin
source /opt/miniconda3/bin/activate
conda activate testbed
echo "Current environment: $CONDA_DEFAULT_ENV"
python -m pip install -e .[all]
