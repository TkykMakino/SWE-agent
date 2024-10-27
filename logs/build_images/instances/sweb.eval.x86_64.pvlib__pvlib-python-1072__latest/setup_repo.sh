#!/bin/bash
set -euxo pipefail
git clone -o origin https://github.com/pvlib/pvlib-python /testbed
chmod -R 777 /testbed
cd /testbed
git reset --hard 04a523fafbd61bc2e49420963b84ed8e2bd1b3cf
git remote remove origin
source /opt/miniconda3/bin/activate
conda activate testbed
echo "Current environment: $CONDA_DEFAULT_ENV"
python -m pip install -e .[all]
