#!/bin/bash
set -euxo pipefail
git clone -o origin https://github.com/pylint-dev/astroid /testbed
chmod -R 777 /testbed
cd /testbed
git reset --hard 6cf238d089cf4b6753c94cfc089b4a47487711e5
git remote remove origin
source /opt/miniconda3/bin/activate
conda activate testbed
echo "Current environment: $CONDA_DEFAULT_ENV"
python -m pip install -e .
