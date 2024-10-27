#!/bin/bash
set -euxo pipefail
git clone -o origin https://github.com/pylint-dev/astroid /testbed
chmod -R 777 /testbed
cd /testbed
git reset --hard ce5cbce5ba11cdc2f8139ade66feea1e181a7944
git remote remove origin
source /opt/miniconda3/bin/activate
conda activate testbed
echo "Current environment: $CONDA_DEFAULT_ENV"
python -m pip install -e .
