# Linear Regression Project — Feature Requirements

## Project research summary

This project is currently an educational Jupyter Notebook experiment, not a standalone application. The experiment brief asks for NumPy implementations of simple linear regression using gradient descent and least squares, scikit-learn models for simple and multivariable regression, comparisons between implementations and parameter choices, plots, and a written report.

The supplied data consists of:

- `PRD/regress_data1.csv`: 97 observations for a one-feature regression (`人口` / population to `收益` / revenue).
- `PRD/regress_data2.csv`: 47 observations for a two-feature housing regression (`面积` / area and `房间数` / rooms to `价格` / price).

The notebook already contains parts of data exploration, NumPy batch gradient descent, scikit-learn simple regression and Ridge, cross-validation, and a normal-equation least-squares implementation. These are partial foundations, not all complete requirements. In particular, the notebook's relative CSV paths do not match the current file layout, its scikit-learn sections do not yet demonstrate the required multivariable model, and the report brief mentions Boston housing while the supplied housing CSV is a different dataset.

**Recommended scope: 10 features.** This is a focused scope for completing and improving the experiment; it does not imply building a web application or deployment platform.

## Feature requirements

### FR-01 — Reproducible project and data loading

**Priority:** Must have  
**Status:** Needs improvement

The notebook shall load the supplied CSV files reliably from the project directory, without depending on a particular current working directory. It shall state the Python packages and versions or supported environment needed to run the experiment.

**Acceptance criteria**

- Both supplied CSV files can be loaded from the notebook in the documented run instructions.
- Missing files and missing required columns produce a clear, actionable error.
- The documented dependencies cover the imports used by the notebook.

### FR-02 — Dataset inspection and validation

**Priority:** Must have  
**Status:** Partially present

The experiment shall show dataset dimensions, column names, descriptive statistics, and checks for missing or non-numeric values before fitting models.

**Acceptance criteria**

- Inspection is shown for each dataset before model fitting.
- Validation identifies missing or invalid values and stops model fitting with a clear explanation when the data is unsuitable.
- The selected input feature(s) and target are explicitly named in the results.

### FR-03 — NumPy univariate regression with gradient descent

**Priority:** Must have  
**Status:** Partially present

Implement simple linear regression using NumPy batch gradient descent, including the cost function, parameter updates, and cost-history visualization.

**Acceptance criteria**

- The model is trained on `regress_data1.csv` with a documented learning rate and iteration limit.
- The notebook reports the learned intercept and slope and plots the fitted line and cost history.
- The cost decreases over training for the supplied data, or the notebook reports a clear convergence/configuration problem.

### FR-04 — NumPy univariate regression with least squares

**Priority:** Must have  
**Status:** Present but should be made more robust

Provide a least-squares solution for the same univariate dataset and compare its coefficients with gradient descent. Use a numerically stable least-squares solver rather than explicitly inverting the normal-equation matrix.

**Acceptance criteria**

- The least-squares model uses the same observations, target, and intercept convention as the gradient-descent model.
- It reports intercept and slope and can be compared directly with the gradient-descent result.
- The solution uses a stable solver such as `numpy.linalg.lstsq` and handles rank-deficient input without a raw matrix-inversion failure.

### FR-05 — scikit-learn simple and multivariable regression

**Priority:** Must have  
**Status:** Partially present; multivariable demonstration is missing

Use scikit-learn `LinearRegression` to fit the supplied simple-regression data and the supplied two-feature housing data. Keep feature and target selection explicit and use one consistent intercept convention.

**Acceptance criteria**

- A simple-regression fit is demonstrated with `regress_data1.csv`.
- A multivariable fit predicts `价格` from `面积` and `房间数` in `regress_data2.csv`.
- Each fit reports its intercept and feature coefficients with feature names.
- The model does not unintentionally include both a manually added constant feature and a separately fitted estimator intercept.

### FR-06 — Model comparison and evaluation metrics

**Priority:** Must have  
**Status:** Needs improvement

Compare NumPy gradient descent, NumPy least squares, and scikit-learn on the same simple-regression data. Report clearly labeled evaluation metrics and distinguish training fit from out-of-sample evaluation.

**Acceptance criteria**

- The comparison uses identical data and target definitions for all compared simple-regression models.
- Results include at least mean squared error (MSE) and coefficient of determination (R²), with the evaluated data split identified.
- Training metrics are not presented as test metrics.
- Differences in learned parameters and predictions are summarized in a readable table or equivalent output.

### FR-07 — Ridge regularization and parameter comparison

**Priority:** Should have  
**Status:** Partially present

Show how a scikit-learn parameter choice affects Ridge regression, including a comparison against ordinary linear regression. Avoid regularizing an unintended duplicate intercept.

**Acceptance criteria**

- Multiple documented `alpha` values are evaluated and their results are plotted or tabulated.
- The comparison explains what changes as regularization strength changes.
- The intercept is handled consistently and is not accidentally penalized through a manually supplied constant column.

### FR-08 — Leakage-safe model validation

**Priority:** Must have
**Status:** Needs improvement

Evaluate model and Ridge parameter choices with a reproducible validation strategy. Any learned preprocessing, including standardization, must be fit only on training data within each validation fold.

**Acceptance criteria**

- Cross-validation uses a scikit-learn `Pipeline` when preprocessing is learned from the data.
- Ridge parameter selection uses the same folds for candidates and reports the selected parameter and validation score.
- A fixed random seed is used wherever randomized splitting is applied.
- Validation scores are labeled separately from final test-set scores.

### FR-09 — Clear result visualizations and interpretation

**Priority:** Should have  
**Status:** Partially present

Provide plots and concise interpretation that support the experiment report, for both the univariate and multivariable workflows where appropriate.

**Acceptance criteria**

- The univariate plot shows observed data and a fitted line with labeled axes.
- Training cost or validation results are plotted with labeled axes and units/metric names.
- The notebook explains what the figures show and identifies the model and dataset used.
- Plot labels remain readable if the configured Chinese font is unavailable, or font configuration is documented.

### FR-10 — Report-ready learning materials

**Priority:** Should have
**Status:** Missing as a complete deliverable

Prepare notebook content that supports the experiment brief's requested algorithm flowchart, results and analysis, commented source code, and student-written summary. Explanations should make the mathematical steps and model comparisons understandable.

**Acceptance criteria**

- The notebook contains or links to a linear-regression flowchart.
- Results and analysis address NumPy versus scikit-learn, gradient descent versus least squares, and parameter choices.
- Code and outputs are organized so they can be used to prepare the experiment report.
- Any report summary or personal reflection is completed independently by the student, consistent with the experiment brief.

## Suggested implementation order

1. FR-01 and FR-02: make the notebook run reproducibly and validate its inputs.
2. FR-03, FR-04, and FR-05: complete and align the required model implementations.
3. FR-06 and FR-08: establish fair evaluation and leakage-safe validation.
4. FR-07 and FR-09: complete parameter analysis and visual interpretation.
5. FR-10: assemble the report-ready experiment materials.

## Scope clarification

The brief refers to the Boston housing dataset, but the workspace supplies `PRD/regress_data2.csv` with area, room count, and price. This file should be treated as the default multivariable dataset for these requirements unless the instructor or project owner confirms that Boston data is additionally required. Do not silently substitute one dataset for the other.

This feature list intentionally stays within the educational experiment's scope. A graphical interface, hosted service, user accounts, or model deployment are not implied by the supplied materials and would require separate requirements.
