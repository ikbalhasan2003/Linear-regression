# Step 07 — Ridge Regularization & Leakage-Safe Validation

**Maps to:** FR-07 (Should have), FR-08 (Must have) · **Depends on:** Steps 01–06
**Files touched:** `notebooks/Experiment2-regression.ipynb`, `outputs/results/`

---

## Prompt

```text
STEP: Ridge parameter comparison with leakage-safe cross-validation.
(Assume the Base Prompt. Assume Steps 01-06 exist, including loaders and comparisons.)

GOAL
Show how the Ridge alpha parameter affects results, select alpha reproducibly with
cross-validation, and eliminate the existing preprocessing leakage.

BACKGROUND (known defects to fix here)
- The notebook currently standardizes data2 BEFORE cross-validation: every fold has seen
  statistics computed over all data. That leaks information and biases validation scores.
- Ridge is currently fed a design matrix containing a manual ones column, so the supplied
  constant feature can be regularized unintentionally.
- Existing Ridge sweep: 50 alphas log-spaced 1e-3 -> 1e2, 5-fold CV, RMSE derived from
  neg_mean_squared_error.

TASKS
1. Introduce sklearn Pipeline objects so preprocessing is fit per fold:
       pipe = Pipeline([("scaler", StandardScaler()), ("model", Ridge(alpha=a))])
   Use X2_raw (面积, 房间数) and y2_raw (价格) for the multivariable task, and X1_raw/y1_raw
   for the simple task. NEVER call StandardScaler().fit_transform on the full dataset
   before cross_validate/cross_val_score again.
2. Sweep alpha = np.logspace(-3, 2, 50) with:
       cross_val_score(pipe, X, y, cv=KFold(n_splits=5, shuffle=True,
                       random_state=RANDOM_STATE), scoring="neg_mean_squared_error")
   Convert to RMSE = sqrt(-score_mean). Record mean and std per alpha.
3. Select the best alpha (lowest mean CV RMSE) and report: chosen alpha, its CV RMSE and
   std deviation, alongside an ordinary LinearRegression baseline in an equivalent
   Pipeline with the same folds. Same folds, same metric, same seed for every candidate.
4. Save the sweep to outputs/results/ (e.g. ridge_alpha_sweep_data2.csv) with columns
   alpha, mean_rmse, std_rmse, and display the top rows inline.
5. Plot alpha (log x-axis) vs mean CV RMSE with labelled axes and a marker on the best
   alpha; save to outputs/figures/.
6. After selecting alpha, refit the chosen Pipeline on the full training data and report a
   clearly separate TEST/HOLDOUT score only if a holdout was created in Step 06; otherwise
   state explicitly that numbers shown are VALIDATION scores, not test scores.
7. Add a markdown/data cell that visually demonstrates leakage: show or approximate what
   happens to the score when scaling is done before CV versus inside the Pipeline, and
   explain why the latter is correct.
8. Explain how alpha changes the model: coefficient shrinkage as alpha grows, bias-variance
   trade-off, why very large alpha drives coefficients toward zero, and that the intercept
   is not regularized (because no manual ones column is supplied).

CONSTRAINTS
- All preprocessing must live INSIDE the Pipeline.
- Use the same random_state everywhere; a rerun must reproduce identical numbers.
- Do not silently reuse a leaky cell — if an old standardized array is referenced later,
  update those references.
- Keep validation scores labelled "validation" and separate from Step 06's test metrics.

DEFINITION OF DONE
[ ] Every standardized model path goes through a sklearn Pipeline.
[ ] Ridge alpha sweep runs with KFold(shuffle=True, random_state=RANDOM_STATE).
[ ] Chosen alpha, its CV RMSE and std are reported and saved to outputs/results/.
[ ] Ordinary LinearRegression baseline uses identical folds and scoring.
[ ] log-alpha vs mean CV RMSE plot exists in outputs/figures/ with labelled axes.
[ ] No `StandardScaler(...).fit_transform(X_all)` before cross-validation remains.
[ ] Validation vs test terminology is used correctly in every label and markdown cell.
[ ] Markdown explains coefficient shrinkage, bias-variance, and why leakage matters.
```
