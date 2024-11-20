#!/bin/bash
set -euxo pipefail
git clone -o origin https://github.com/sqlfluff/sqlfluff /testbed
chmod -R 777 /testbed
cd /testbed
git reset --hard a10057635e5b2559293a676486f0b730981f037a
git remote remove origin
source /opt/miniconda3/bin/activate
conda activate testbed
echo "Current environment: $CONDA_DEFAULT_ENV"
python -m pip install -e .
