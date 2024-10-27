#!/bin/bash
set -euxo pipefail
git clone -o origin https://github.com/pylint-dev/astroid /testbed
chmod -R 777 /testbed
cd /testbed
git reset --hard d2a5b3c7b1e203fec3c7ca73c30eb1785d3d4d0a
git remote remove origin
source /opt/miniconda3/bin/activate
conda activate testbed
echo "Current environment: $CONDA_DEFAULT_ENV"
python -m pip install -e .
