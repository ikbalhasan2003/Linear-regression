# Base Prompt (shared context for every step)

Paste this block at the top of every step prompt, or use it as the "system" context
when working on any part of this project. Step prompts in this folder assume you have
already read this file.

```text
You are working inside the project at:
d:/WIT/6th semester/AI/Linear regression

## Project identity
This is an AI-course experiment titled "Design and implementation of linear regression
algorithm" (Experiment 2). It is an EDUCATIONAL, notebook-first workflow — NOT a web
app, NOT an API, NOT a service. Do not introduce a frontend, backend, database, Docker,
or deployment layer.

## Authoritative documents (read these before changing anything)
- README.md               — folder structure and run instructions
- PROJECT_CONTEXT.md      — current state, dataset stats, known issues/checkpoints
- FEATURE_REQUIREMENTS.md — FR-01 … FR-10 with acceptance criteria
- ARCHITECTURE.md         — component responsibilities and data/model flows
- TECH_STACK.md           — selected stack and conventions
- PRD/Experiment 2 Linear regression.docx — the instructor brief (source of truth)

## Datasets (Chinese headers — keep them visible in outputs)
- data/regress_data1.csv : 97 rows. Feature 人口 (population) -> target 收益 (profit).
                           Correlation ~0.838. Ranges: x 5.0269–22.203, y -2.6807–24.147.
- data/regress_data2.csv : 47 rows. Features 面积 (area) + 房间数 (rooms) -> target 价格 (price).
                           Ranges: area 852–4478, rooms 1–5, price 169900–699900.
                           Corr with price: area ~0.855, rooms ~0.442.
Note: the brief mentions a Boston housing dataset, but the supplied multivariable file
is regress_data2.csv. Treat regress_data2.csv as the default multivariable dataset.
Never silently substitute one dataset for the other.

## Tech stack (do not add new major dependencies without being asked)
Python 3.11 + Jupyter Notebook, numpy, pandas, matplotlib, scikit-learn.
Run from a venv:
  python -m venv .venv && ./.venv/Scripts/activate
  pip install jupyter numpy pandas matplotlib scikit-learn
  jupyter notebook notebooks/Experiment2-regression.ipynb

## Global engineering conventions
1. The notebook `notebooks/Experiment2-regression.ipynb` is the single source of
   implementation. Explanations, code, results, and figures live together.
2. Keep the teaching progression intact: explore data -> implement from scratch ->
   compare with scikit-learn -> analyse parameters/regularization -> report material.
3. Paths: resolve data paths relative to the project root, never assume the current
   working directory. Follow the documented layout (`data/`, `outputs/`, `reports/`).
4. Intercept convention: exactly ONE per model. NumPy from-scratch code may add an
   explicit ones column; scikit-learn estimators must use their own `fit_intercept`
   and must NOT receive a manually added constant column.
5. Reproducibility: fixed random seed wherever randomness occurs.
6. Leakage-safety: any preprocessing learned from data (standardization etc.) must be
   fit inside each cross-validation fold, i.e. inside a sklearn Pipeline.
7. Numerically stable solvers: use `numpy.linalg.lstsq` / pseudoinverse, never a raw
   `inv(X.T @ X)`.
8. Label every result with its dataset, model, and whether it is a TRAINING,
   VALIDATION, or TEST metric. Never present training cost as test performance.
9. Chinese labels: the notebook sets `SimHei` for matplotlib. Keep Chinese labels where
   useful but ensure labels stay readable if the font is missing (document fallback).
10. `PRD/` is read-only teaching material. Never edit files inside `PRD/`.

## Existing known issues to respect (see PROJECT_CONTEXT.md § Known issues)
- CSV paths in the notebook may still point at a missing location.
- The multivariable scikit-learn model is missing.
- Standardization currently happens before cross-validation (leak).
- LSM explicitly inverts the normal-equation matrix.
- Notebook saved outputs may contain stale/conflicting comments — trust freshly
  executed output, not stray comments.

## Style of work
- Make minimal, targeted changes; do not refactor unrelated cells.
- Add short Chinese/English markdown explanations next to new code cells so the work is
  usable directly in the lab report.
- Every step must end with Definition-of-Done checks passing.
```
