#!/bin/bash
set -euxo pipefail
git clone -o origin https://github.com/sqlfluff/sqlfluff /testbed
chmod -R 777 /testbed
cd /testbed
git reset --hard 14e1a23a3166b9a645a16de96f694c77a5d4abb7
git remote remove origin
source /opt/miniconda3/bin/activate
conda activate testbed
echo "Current environment: $CONDA_DEFAULT_ENV"
python -m pip install -e .
