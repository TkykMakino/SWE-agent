#!/bin/bash
set -euxo pipefail
git clone -o origin https://github.com/pyvista/pyvista /testbed
chmod -R 777 /testbed
cd /testbed
git reset --hard db6ee8dd4a747b8864caae36c5d05883976a3ae5
git remote remove origin
source /opt/miniconda3/bin/activate
conda activate testbed
echo "Current environment: $CONDA_DEFAULT_ENV"
python -m pip install -e .
