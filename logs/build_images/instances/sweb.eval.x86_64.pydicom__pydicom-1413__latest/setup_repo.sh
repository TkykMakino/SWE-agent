#!/bin/bash
set -euxo pipefail
git clone -o origin https://github.com/pydicom/pydicom /testbed
chmod -R 777 /testbed
cd /testbed
git reset --hard f909c76e31f759246cec3708dadd173c5d6e84b1
git remote remove origin
source /opt/miniconda3/bin/activate
conda activate testbed
echo "Current environment: $CONDA_DEFAULT_ENV"
python -m pip install -e .
