#!/bin/bash
set -euxo pipefail
git clone -o origin https://github.com/pydicom/pydicom /testbed
chmod -R 777 /testbed
cd /testbed
git reset --hard 3746878d8edf1cbda6fbcf35eec69f9ba79301ca
git remote remove origin
source /opt/miniconda3/bin/activate
conda activate testbed
echo "Current environment: $CONDA_DEFAULT_ENV"
python -m pip install -e .
