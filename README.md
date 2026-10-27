# Linear Regression — Project Structure

AI course experiment: “Design and implementation of linear regression algorithm.”
Notebook-first workflow — there is no app, API, or database tier.

```text
Linear regression/
├── PRD/                          # Original teaching material (do not modify)
│   ├── Experiment 2 Linear regression.docx   # experiment brief / requirements
│   ├── Linear regression.pptx                # lecture slides
│   ├── regress_data1.csv                     # univariate source: 人口 → 收益 (97 rows)
│   └── regress_data2.csv                     # multivariable source: 面积+房间数 → 价格 (47 rows)
│
├── data/                         # Working copies of the datasets used by the notebook
│   ├── regress_data1.csv
│   └── regress_data2.csv
│
├── notebooks/                    # Main implementation
│   └── Experiment2-regression.ipynb
│
├── outputs/                      # Generated artifacts (git-ignored except .gitkeep)
│   ├── figures/                  # plots: fitted line, cost history, alpha vs RMSE
│   └── results/                  # metric tables (MSE, R², CV scores)
│
├── reports/                      # Experiment deliverables
│
├── prompts/                      # Step-by-step prompts used to build this project
│   ├── 00-base-prompt.md         # shared project context for every step
│   ├── 01 … 09-*.md              # one prompt per implementation step (FR-01 … FR-10)
│   └── PROMPT_CHECKLIST.md       # per-step status tracker
│
├── ARCHITECTURE.md               # architecture overview and design decisions
├── TECH_STACK.md                 # Python 3.11 + Jupyter/numpy/pandas/matplotlib/scikit-learn
├── PROJECT_CONTEXT.md            # current state, known issues, checkpoints
├── FEATURE_REQUIREMENTS.md       # FR-01 … FR-10 acceptance criteria
└── README.md                     # this file
```

## Folder responsibilities

| Folder | Contents | Rule |
| --- | --- | --- |
| `PRD/` | Instructor-supplied brief, slides, and original CSVs | Read-only source of truth |
| `data/` | CSV copies actually read by the notebook | Matches the notebook's `data/regress_data1.csv` path |
| `notebooks/` | The experiment itself: code + narrative + outputs | Single source of implementation |
| `outputs/figures/` | Saved plots | Regenerable from the notebook |
| `outputs/results/` | Saved metric tables | Regenerable from the notebook |
| `reports/` | Report-ready material: flowchart, analysis, summary | Written by the student |

## Run

```bash
cd "Linear regression"
python -m venv .venv && ./.venv/Scripts/activate
pip install -r requirements.txt
# if PyPI is unreachable, use a mirror:
# pip install -i https://pypi.tuna.tsinghua.edu.cn/simple -r requirements.txt
jupyter notebook notebooks/Experiment2-regression.ipynb
```

`requirements.txt` pins the versions this notebook was verified with
(jupyter 1.1.1, numpy 2.5.4, pandas 3.1.0, matplotlib 3.11.2, scikit-learn 1.9.1).

Paths are resolved from the project root (the folder containing `data/`) by the setup cell,
so the notebook runs identically whether you start Jupyter from the project root or from
`notebooks/`. No machine-specific absolute path is used.

Outputs are written to `outputs/figures/` and `outputs/results/`; both folders are created
by the notebook itself.

## Reproduce every result

1. Activate the venv and install the pinned dependencies (see **Run** above).
2. Open `notebooks/Experiment2-regression.ipynb`.
3. **Kernel → Restart & Run All.** The notebook is deterministic: the data paths are
   resolved from the project root, `RANDOM_STATE = 42` fixes every split, and every figure
   and CSV is rewritten by this single run.
4. Check the run finished clean: the last section prints an artifact inventory
   (`outputs/figures/*.png`, `outputs/results/*.csv`) — if any file is missing, a cell failed.

Nothing else needs to be executed by hand; no cell depends on a particular working directory.

## Generated artifacts (regenerable)

| Path | Contents |
| --- | --- |
| `outputs/figures/gd_data1_fitted_line.png`, `gd_data1_cost_history.png` | Step 03 — NumPy gradient-descent fit and cost history |
| `outputs/figures/sklearn_data1_fitted_line.png` | Step 05 — scikit-learn univariate fit |
| `outputs/figures/model_comparison_data1_lines.png` | Step 06 — GD / LSM / sklearn on one axes |
| `outputs/figures/fig_a … fig_f2_*.png` | Step 08 — the six report-ready figures (see `reports/README.md`) |
| `outputs/figures/ridge_alpha_sweep_data1.png`, `ridge_alpha_sweep_data2.png` | Step 07 — α vs CV RMSE |
| `outputs/results/model_comparison_data1.csv` | Step 06 — intercept/slope + Train and Test MSE/R² |
| `outputs/results/ridge_alpha_sweep_data2.csv` | Step 07 — α sweep: `alpha, mean_rmse, std_rmse` |

Report material (flowcharts, result tables, code appendix, summary scaffold) lives in the
notebook's final sections; see [reports/README.md](./reports/README.md) for what to embed
in the lab report.
