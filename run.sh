#!/usr/bin/env bash
# Easy runner for the Linear Regression experiment (Git Bash / macOS / Linux).
#   ./run.sh            -> run everything and print where the results are
#   ./run.sh jupyter    -> open the notebook in Jupyter
#   ./run.sh outputs    -> open/print the outputs folder
#   ./run.sh install    -> reinstall dependencies
set -euo pipefail
cd "$(dirname "$0")"

NB="notebooks/Experiment2-regression.ipynb"
MIRROR="https://pypi.tuna.tsinghua.edu.cn/simple"
MODE="${1:-run}"

# --- pick or create the virtual environment -------------------------------
if   [ -x ".venv/Scripts/python.exe" ]; then PY=".venv/Scripts/python.exe"
elif [ -x ".venv/bin/python" ];        then PY=".venv/bin/python"
else
  SYS_PY="python"; command -v python >/dev/null 2>&1 || SYS_PY="python3"
  echo "[env] No .venv found - creating one with $SYS_PY (first run only)..."
  "$SYS_PY" -m venv .venv
  if   [ -x ".venv/Scripts/python.exe" ]; then PY=".venv/Scripts/python.exe"
  else PY=".venv/bin/python"; fi
fi
echo "[env] Python: $PY"

need_install=0
"$PY" -c "import numpy, pandas, matplotlib, sklearn, nbconvert" >/dev/null 2>&1 || need_install=1
if [ "$MODE" = "install" ] || [ "$need_install" = "1" ]; then
  echo "[env] Installing dependencies..."
  "$PY" -m pip install -r requirements.txt \
    || "$PY" -m pip install -i "$MIRROR" -r requirements.txt
  [ "$MODE" = "install" ] && { echo "[env] Dependencies OK."; exit 0; }
fi

case "$MODE" in
  jupyter)
    echo "[jupyter] Opening $NB in the browser (Ctrl+C here to stop)."
    "$PY" -m jupyter notebook "$NB"
    ;;
  outputs)
    mkdir -p outputs
    echo "[outputs] $(pwd)/outputs"
    ls -R outputs
    ;;
  run|*)
    echo "[run] Executing the notebook (same as Kernel > Restart & Run All)..."
    "$PY" -m jupyter nbconvert --to notebook --execute --inplace "$NB"
    "$PY" -m jupyter nbconvert --to html --output-dir outputs "$NB" >/dev/null 2>&1 || true
    echo "[run] Done. Generated files:"
    find outputs -type f | sort | sed 's/^/    /'
    echo
    echo "[run] Full report : $(pwd)/outputs/Experiment2-regression.html"
    echo "[run] Report guide: $(pwd)/reports/README.md"
    ;;
esac
