# Step 05 — scikit-learn Simple and Multivariable Regression

**Maps to:** FR-05 · **Priority:** Must have · **Depends on:** Steps 01–04
**Files touched:** `notebooks/Experiment2-regression.ipynb`

---

## Prompt

```text
STEP: scikit-learn LinearRegression on both univariate and multivariable data.
(Assume the Base Prompt. Assume Steps 01-04 provide loaders, validation, and NumPy models.)

GOAL
Demonstrate sklearn LinearRegression on regress_data1.csv (simple) AND on
regress_data2.csv (multivariable), with explicit feature/target naming and ONE
consistent intercept convention.

BACKGROUND (known defects to fix here)
- The notebook currently passes a design matrix that already contains a manually added
  all-ones column into sklearn estimators whose fit_intercept defaults to True. That is a
  DUPLICATE intercept representation: LinearRegression gets a redundant constant feature,
  and for Ridge the supplied constant can even be regularized though its own intercept
  would not be.
- The brief requires a multivariable scikit-learn model; the notebook's sklearn section
  currently uses only univariate X, y, so that demonstration is missing.

TASKS
1. Define clean, raw feature/target frames WITHOUT any ones column:
       X1_raw = data1[["人口"]];  y1_raw = data1["收益"]
       X2_raw = data2[["面积", "房间数"]];  y2_raw = data2["价格"]
   Use pandas DataFrames so column names survive into the reported coefficients.
2. Fit univariate: LinearRegression().fit(X1_raw, y1_raw). Print intercept_ and coef_ paired
   with feature names ("人口"). Report MSE and R^2 clearly labelled as TRAINING metrics.
3. Fit multivariable: LinearRegression().fit(X2_raw, y2_raw). Print intercept_ and both
   coefficients mapped to "面积" and "房间数". Report training MSE and R^2.
4. Add an explicit discussion/output cell proving the intercept convention is correct:
   show that coef_/intercept_ from sklearn match the NumPy LSM parameters from Step 04
   on the same data (within tolerance), and note that no ones column was supplied.
5. Add a short "duplicate intercept" note in markdown: explain what happens when a manual
   ones column is combined with fit_intercept=True, and state the project rule
   (sklearn estimators use their own intercept; no manual constant column).
6. Because 面积, 房间数 and 价格 differ hugely in scale, add a clearly labelled side note or
   optional cell comparing coefficients expressed in raw units vs in standardized units —
   explicitly stating that raw coefficients are in "price per unit area / per room" terms
   and are not a measure of feature importance. Do NOT put the standardization before any
   validation yet (Step 07 handles leakage-safe scaling).
7. Keep every reported result labelled with dataset name, model name, and metric scope.

CONSTRAINTS
- Fix any cell that passes a ones column into sklearn; update call sites rather than
  leaving two competing conventions in the notebook.
- Do not use PolynomialFeatures, SGDRegressor, or anything outside the documented stack.
- Preserve the teaching order: exploration -> from scratch -> sklearn -> comparison.

DEFINITION OF DONE
[ ] Univariate sklearn fit reports intercept + coefficient named 人口.
[ ] Multivariable sklearn fit predicts 价格 from 面积 and 房间数 and reports intercept
    plus BOTH named coefficients.
[ ] No manually added ones column is passed to any sklearn estimator.
[ ] sklearn parameters agree with Step 04's NumPy LSM parameters within tolerance.
[ ] Training MSE and R^2 are printed for both fits, labelled as training metrics.
[ ] Markdown explains the intercept convention and the raw-coefficient interpretation.
```
