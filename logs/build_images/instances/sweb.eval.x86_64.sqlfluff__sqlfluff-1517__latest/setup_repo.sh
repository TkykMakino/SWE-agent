#!/bin/bash
set -euxo pipefail
git clone -o origin https://github.com/sqlfluff/sqlfluff /testbed
chmod -R 777 /testbed
cd /testbed
git reset --hard 304a197829f98e7425a46d872ada73176137e5ae
git remote remove origin
source /opt/miniconda3/bin/activate
conda activate testbed
echo "Current environment: $CONDA_DEFAULT_ENV"
python -m pip install -e .
