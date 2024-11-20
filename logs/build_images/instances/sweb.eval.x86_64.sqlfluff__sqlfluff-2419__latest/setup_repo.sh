#!/bin/bash
set -euxo pipefail
git clone -o origin https://github.com/sqlfluff/sqlfluff /testbed
chmod -R 777 /testbed
cd /testbed
git reset --hard f1dba0e1dd764ae72d67c3d5e1471cf14d3db030
git remote remove origin
source /opt/miniconda3/bin/activate
conda activate testbed
echo "Current environment: $CONDA_DEFAULT_ENV"
python -m pip install -e .
