# Linear Regression Project Context

## Purpose of this document

This is a working reference for understanding the current project materials before further development. It records what the source files contain, how the notebook is organized, the experiment's requirements, and known discrepancies to check before treating the notebook as a finished implementation.

## Project at a glance

The project is an artificial-intelligence course experiment on linear regression. Its intended learning outcomes are:

- Explain the linear model and least-squares objective.
- Implement univariate linear regression with NumPy, especially batch gradient descent and the least-squares method (LSM).
- Apply scikit-learn linear regression to univariate and multivariable data.
- Compare a handwritten implementation with scikit-learn and compare model/parameter choices, including Ridge regularization.
- Present plots, results, code, and an independently written experiment summary.

The available workspace is primarily teaching material and data; it is not currently structured as a packaged application. The main implementation is a Jupyter notebook.

## Files currently present

| File | Role / contents |
| --- | --- |
| `PRD/Experiment 2 Linear regression.docx` | Experiment brief, objectives, requirements, report expectations, and grading criteria. |
| `PRD/Experiment2-regression.ipynb` | Main notebook: univariate batch gradient descent, multivariable gradient descent, scikit-learn linear regression, Ridge, cross-validation, and LSM. |
| `PRD/Linear regression.pptx` | Lecture slides introducing the linear model, least squares, and a small NumPy simple-regression example. |
| `PRD/regress_data1.csv` | Univariate dataset with Chinese headers `人口` (population) and `收益` (profit/revenue). |
| `PRD/regress_data2.csv` | Housing data with Chinese headers `面积` (area), `房间数` (number of rooms), and `价格` (price). |

There is no observed `data/` subdirectory, Python package, dependency manifest, test suite, or separate application source code in the initial workspace inventory. A temporary Microsoft Office lock file may appear while the document is open; it is not project content.

## Experiment brief

The brief names the experiment “Design and implementation of linear regression algorithm.” It expects Python with NumPy, scikit-learn, and Matplotlib. It asks students to:

1. Implement simple linear regression with NumPy.
2. Implement simple linear regression with both gradient descent and LSM.
3. Use scikit-learn for simple and multivariable linear-regression predictions.
4. Compare the handwritten implementation with scikit-learn and compare model/parameter choices.
5. Include an algorithm flowchart, experimental result/analysis diagrams, source code with comments, and a summary/experience section in the report.

The brief mentions a Boston house-pricing dataset in one place, while the supplied `regress_data2.csv` is a small dataset with area, room count, and price. These should not be assumed to be the same dataset. Follow-up development should establish whether the supplied CSV is the intended dataset or whether Boston data is separately required.

## Data notes

### `regress_data1.csv`

- 97 data records, 2 columns, no explicit index column.
- `人口` is used as the input feature; `收益` is the target.
- Approximate observed ranges: population 5.0269–22.203; revenue -2.6807–24.147.
- The input/target Pearson correlation in this file is about 0.838 (positive).
- This is the notebook's univariate regression dataset.

### `regress_data2.csv`

- 47 data records, 3 columns, no explicit index column.
- Inputs: `面积` (area) and `房间数` (rooms); target: `价格` (price).
- Approximate observed ranges: area 852–4478; rooms 1–5; price 169900–699900.
- Pairwise correlations with price in this file: area about 0.855; rooms about 0.442.
- This is the notebook's multivariable housing dataset; its scale is consistent with the small sample format used in introductory regression exercises.

CSV headers are Chinese. The notebook sets Matplotlib's font to `SimHei` and disables Unicode minus substitution to improve rendering of Chinese labels, but `SimHei` may not be installed on every system.

## Notebook walkthrough

### 1. Univariate data exploration

The notebook imports NumPy, pandas, and Matplotlib, reads `regress_data1.csv`, inspects the head and descriptive statistics, and plots population against revenue.

The notebook currently reads:

```python
path = 'data/regress_data1.csv'
```

The provided CSV is actually alongside the notebook in `PRD/`, not under `PRD/data/`. Unless the missing directory is added or the notebook path is changed, this read will fail when run from the notebook's directory. The multivariable read has the same issue (`data/regress_data2.csv`).

### 2. Univariate batch gradient descent

The model is linear:

`h_w(x) = w_0 + w_1 x`

The cost implemented is mean squared error with the conventional half factor:

`J(w) = (1 / (2m)) * sum_i (h_w(x_i) - y_i)^2`

The notebook adds a column of ones to the feature matrix, initializes weights to zero, and uses a vectorized prediction/error calculation. `batch_gradientDescent` then calculates every parameter's gradient from the same current weights and updates the weights for each iteration. Saved settings are `alpha = 0.01` and `iters = 1500`. It plots both the fitted line and cost over iterations.

Saved notebook outputs include:

- Initial zero-weight cost: approximately `32.0727`.
- Gradient-descent weights: approximately `[-3.6303, 1.1664]` (intercept, slope).
- Cost at those weights: approximately `4.4834`.

The notebook also contains a later comment with a different gradient-descent weight pair. That comment does not match the saved output and should be treated as stale or unverified, not as an authoritative result.

### 3. Multivariable batch gradient descent

The notebook reads `regress_data2.csv`, applies pandas standardization to every column using `(data2 - data2.mean()) / data2.std()`, then inserts a ones column. The feature matrix therefore consists of the intercept column plus normalized area and room-count columns; the target is normalized price.

It reuses the univariate gradient-descent function and hyperparameters and plots the training cost. The saved final cost is approximately `0.13069` in standardized target units. The notebook does not show a scikit-learn multivariable fit in the current source, despite the brief requiring one.

### 4. scikit-learn linear regression and Ridge

The notebook fits `sklearn.linear_model.LinearRegression` to the univariate dataset and plots its predictions. It then fits `Ridge` to the same univariate data and plots that result.

The feature matrix passed to both estimators already includes an explicit all-ones column. Both estimators also default to `fit_intercept=True`, so the model has a duplicate intercept representation. For `Ridge`, the extra constant feature can also be regularized even though the estimator's own intercept is not. In a clean comparison, decide on one intercept convention (typically remove the ones column when using these scikit-learn estimators, or set `fit_intercept=False` if intentionally supplying it).

For Ridge, the notebook tests 50 alpha values spaced logarithmically from `1e-3` to `1e2`, using 5-fold cross-validation and root mean squared error derived from the negative MSE scorer. It plots alpha against average cross-validation RMSE.

One methodological caveat: `data2` normalization is performed before any cross-validation. For an unbiased validation workflow, fit preprocessing only on each training fold, for example by using a scikit-learn `Pipeline` with a scaler and estimator.

### 5. LSM

`LSM(X, y)` computes:

`w = inv(X.T @ X) @ X.T @ y`

This is the normal-equation solution in the notebook's column-vector convention. The saved output for the univariate `X, y` is approximately:

```text
intercept = -3.8958
slope     =  1.1930
```

The implementation explicitly inverts `X.T @ X`, which can fail or be numerically unstable when the matrix is singular or poorly conditioned. For future development, prefer `numpy.linalg.lstsq` or a pseudoinverse. A comparison with gradient descent should use the same input data, intercept convention, cost definition, and an adequate convergence check.

## Slides

The 19-slide presentation introduces linear regression as a linear combination of attributes, motivates fitting a line/plane/hyperplane, explains residuals and least squares, and shows a small synthetic one-feature NumPy example. Its handwritten example calculates slope and intercept from sums/means and plots the fitted line. The slides are teaching material rather than a second implementation of the supplied CSV workflow.

## Known issues and development checkpoints

1. **Dataset paths do not match the files.** — RESOLVED (Step 01): working copies live in `data/`, and the setup cell resolves the project root with `find_project_root`, so the notebook loads both CSVs from any working directory.
2. **The required multivariable scikit-learn model is missing.** — FIXED (Step 05): `LinearRegression` now fits `面积 + 房间数 → 价格` on `X2_raw`/`y2_raw` and reports the intercept plus both named coefficients.
3. **The Boston dataset statement conflicts with supplied data.** — DECIDED (pending instructor confirmation): `regress_data2.csv` (面积 + 房间数 → 价格, 47 rows) is the default multivariable dataset; see the "Scope clarification" section of `FEATURE_REQUIREMENTS.md`. Boston data is only needed if the instructor explicitly asks for it.
4. **Scikit-learn intercept is duplicated.** — FIXED (Step 05): sklearn estimators receive raw feature frames only; a runtime assertion rejects constant columns, and `Ridge`/`cross_val_score` call sites were updated too.
5. **Cross-validation preprocessing leaks information.** — FIXED (Step 07): every standardized path goes through `Pipeline([("scaler", StandardScaler()), ("model", ...)])`, so the scaler is fitted per fold; `KFold(shuffle=True, random_state=RANDOM_STATE)` fixes the folds.
6. **LSM uses an explicit matrix inverse.** — FIXED (Step 04): `LSM` uses `np.linalg.lstsq` with a pseudoinverse cross-check and a rank-deficiency warning.
7. **Saved notebook evidence is not fully consistent.** — FIXED (Step 03): the stale commented weight pair was removed; all cells were re-executed top-to-bottom (132 cells, 0 errors, re-verified 2026-10-27).
8. **Comparisons should use metrics and consistent data handling.** — FIXED (Steps 06/07): one table reports intercept, slope, Train MSE/R² and Test MSE/R² for GD, LSM and sklearn on identical data; Ridge α selection uses 5-fold CV (VALIDATION) and is kept separate from the single holdout TEST score.
9. **Environment assumptions are undocumented.** — FIXED (Step 01): `requirements.txt` pins the verified versions, and `README.md` documents install, run, folders, and the "Restart & Run All" reproduction procedure.
10. **Report requirements extend beyond the notebook.** — FIXED (Step 09): §7.1 two Mermaid flowcharts, §7.2 live-source code appendix, §7.3 result tables plus artifact inventory, §7.4 analysis; `reports/README.md` maps each figure/table to the report section. Only §7.5 (personal summary) is intentionally left as a scaffold.

## Suggested mental model for future work

Treat the notebook as a partially completed educational experiment, not as a polished application. Preserve its instructional progression—explore data, implement and visualize a NumPy model, compare against scikit-learn, then examine Ridge/LSM—but make input paths, preprocessing, intercepts, and evaluation consistent first. Keep the univariate and multivariable tasks explicit, and record which dataset and metric each result refers to.
