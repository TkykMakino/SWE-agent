#!/bin/bash
set -euxo pipefail
git clone -o origin https://github.com/pvlib/pvlib-python /testbed
chmod -R 777 /testbed
cd /testbed
git reset --hard 0b8f24c265d76320067a5ee908a57d475cd1bb24
git remote remove origin
source /opt/miniconda3/bin/activate
conda activate testbed
echo "Current environment: $CONDA_DEFAULT_ENV"
python -m pip install -e .[all]
