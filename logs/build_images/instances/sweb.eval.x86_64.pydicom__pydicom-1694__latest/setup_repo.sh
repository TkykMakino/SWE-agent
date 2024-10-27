#!/bin/bash
set -euxo pipefail
git clone -o origin https://github.com/pydicom/pydicom /testbed
chmod -R 777 /testbed
cd /testbed
git reset --hard f8cf45b6c121e5a4bf4a43f71aba3bc64af3db9c
git remote remove origin
source /opt/miniconda3/bin/activate
conda activate testbed
echo "Current environment: $CONDA_DEFAULT_ENV"
python -m pip install -e .
