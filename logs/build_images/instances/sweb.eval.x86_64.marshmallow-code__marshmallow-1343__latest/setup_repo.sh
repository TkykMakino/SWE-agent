#!/bin/bash
set -euxo pipefail
git clone -o origin https://github.com/marshmallow-code/marshmallow /testbed
chmod -R 777 /testbed
cd /testbed
git reset --hard 2be2d83a1a9a6d3d9b85804f3ab545cecc409bb0
git remote remove origin
source /opt/miniconda3/bin/activate
conda activate testbed
echo "Current environment: $CONDA_DEFAULT_ENV"
python -m pip install -e '.[dev]'
