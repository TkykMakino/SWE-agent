#!/bin/bash
set -euxo pipefail
git clone -o origin https://github.com/pylint-dev/astroid /testbed
chmod -R 777 /testbed
cd /testbed
git reset --hard 39c2a9805970ca57093d32bbaf0e6a63e05041d8
git remote remove origin
source /opt/miniconda3/bin/activate
conda activate testbed
echo "Current environment: $CONDA_DEFAULT_ENV"
python -m pip install -e .
