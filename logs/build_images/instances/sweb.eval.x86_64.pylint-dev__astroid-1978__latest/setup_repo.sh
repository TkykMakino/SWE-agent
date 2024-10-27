#!/bin/bash
set -euxo pipefail
git clone -o origin https://github.com/pylint-dev/astroid /testbed
chmod -R 777 /testbed
cd /testbed
git reset --hard 0c9ab0fe56703fa83c73e514a1020d398d23fa7f
git remote remove origin
source /opt/miniconda3/bin/activate
conda activate testbed
echo "Current environment: $CONDA_DEFAULT_ENV"
python -m pip install -e .
