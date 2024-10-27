#!/bin/bash
set -euxo pipefail
git clone -o origin https://github.com/pydicom/pydicom /testbed
chmod -R 777 /testbed
cd /testbed
git reset --hard b9fb05c177b685bf683f7f57b2d57374eb7d882d
git remote remove origin
source /opt/miniconda3/bin/activate
conda activate testbed
echo "Current environment: $CONDA_DEFAULT_ENV"
python -m pip install -e .
