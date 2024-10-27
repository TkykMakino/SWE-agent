#!/bin/bash
set -euxo pipefail
git clone -o origin https://github.com/pvlib/pvlib-python /testbed
chmod -R 777 /testbed
cd /testbed
git reset --hard c78b50f4337ecbe536a961336ca91a1176efc0e8
git remote remove origin
source /opt/miniconda3/bin/activate
conda activate testbed
echo "Current environment: $CONDA_DEFAULT_ENV"
python -m pip install -e .[all]
