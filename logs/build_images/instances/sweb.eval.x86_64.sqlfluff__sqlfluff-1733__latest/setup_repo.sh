#!/bin/bash
set -euxo pipefail
git clone -o origin https://github.com/sqlfluff/sqlfluff /testbed
chmod -R 777 /testbed
cd /testbed
git reset --hard a1579a16b1d8913d9d7c7d12add374a290bcc78c
git remote remove origin
source /opt/miniconda3/bin/activate
conda activate testbed
echo "Current environment: $CONDA_DEFAULT_ENV"
python -m pip install -e .
