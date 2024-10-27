#!/bin/bash
set -euxo pipefail
git clone -o origin https://github.com/pydicom/pydicom /testbed
chmod -R 777 /testbed
cd /testbed
git reset --hard 49a3da4a3d9c24d7e8427a25048a1c7d5c4f7724
git remote remove origin
source /opt/miniconda3/bin/activate
conda activate testbed
echo "Current environment: $CONDA_DEFAULT_ENV"
python -m pip install -e .
