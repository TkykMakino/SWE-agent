#!/bin/bash
set -euxo pipefail
git clone -o origin https://github.com/marshmallow-code/marshmallow /testbed
chmod -R 777 /testbed
cd /testbed
git reset --hard b40a0f4e33823e6d0f341f7e8684e359a99060d1
git remote remove origin
source /opt/miniconda3/bin/activate
conda activate testbed
echo "Current environment: $CONDA_DEFAULT_ENV"
python -m pip install -e '.[dev]'
