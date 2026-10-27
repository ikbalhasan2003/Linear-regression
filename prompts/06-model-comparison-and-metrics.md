# Step 06 — Model Comparison and Evaluation Metrics

**Maps to:** FR-06 · **Priority:** Must have · **Depends on:** Steps 03–05
**Files touched:** `notebooks/Experiment2-regression.ipynb`, `outputs/results/`

---

## Prompt

```text
STEP: Fair comparison of NumPy gradient descent, NumPy least squares, and scikit-learn.
(Assume the Base Prompt. Assume Step 03 (GD), Step 04 (LSM), Step 05 (sklearn) are done.)

GOAL
Compare all three simple-regression approaches on identical data using clearly labelled
metrics, keeping training fit distinct from out-of-sample evaluation.

BACKGROUND
- PROJECT_CONTEXT.md flags that the notebook mostly shows plots and costs; it does not
  present named comparison metrics, and it never separates training from test numbers.
- The brief explicitly requires comparing the handwritten implementation with sklearn.

TASKS
1. Build one shared comparison cell for the SIMPLE regression task (regress_data1.csv,
   人口 -> 收益). All three models must use IDENTICAL data, identical target definition,
   and the same intercept convention:
   - NumPy batch gradient descent (Step 03 weights),
   - NumPy least squares via lstsq (Step 04 weights),
   - sklearn LinearRegression (Step 05).
2. Add an evaluation block with a fixed random_state=RANDOM_STATE (from Step 01) using
   train_test_split (e.g. test_size=0.2):
   - Fit each simple model on the SAME training split; evaluate on the SAME held-out split.
   - IMPORTANT: use raw features for this split comparison, so no preprocessing
     leakage can occur. (Pipeline-based scaling belongs to Step 07.)
3. Report a pandas DataFrame summary table with rows = model and columns:
   Intercept, Slope (人口), Train MSE, Train R^2, Test MSE, Test R^2.
   Round consistently (4 decimals) and give the table a caption naming the dataset and
   the split ratio/seed.
4. Save the table to outputs/results/ as CSV (e.g. model_comparison_data1.csv) and also
   display it inline in the notebook.
5. Add numeric checks: max absolute parameter difference between the three fits and a
   short statement of whether they agree within tolerance. Explain any disagreement
   (GD is iterative and depends on alpha/iters; LSM and sklearn are closed-form).
6. Produce a compact comparison plot: observed points plus the three fitted lines
   (distinguished by style/legend), saved to outputs/figures/.
7. Write a markdown analysis section covering:
   - NumPy vs scikit-learn: agreement of parameters, practical differences (control vs
     convenience), when each is appropriate.
   - Gradient descent vs least squares: convergence vs closed form, sensitivity to
     learning rate/iterations, scaling to many features.
   - Explicit statement that train MSE/R^2 are optimistic and that test metrics are the
     honest generalization estimate.

CONSTRAINTS
- Never reuse a test split for training, and never report training metrics as test metrics.
- Use sklearn metrics functions (mean_squared_error, r2_score) for all rows so scoring is
  identical across models.
- Keep the table readable — no raw dumps of arrays.

DEFINITION OF DONE
[ ] One summary table covers GD, LSM, and sklearn on the identical simple-regression data.
[ ] Table includes intercept, slope, Train MSE, Train R^2, Test MSE, Test R^2.
[ ] The train/test split uses RANDOM_STATE and the ratio/seed is stated.
[ ] Table is saved to outputs/results/ AND displayed in the notebook.
[ ] Parameter differences between the three implementations are quantified and explained.
[ ] A markdown section discusses NumPy vs sklearn and GD vs LSM.
[ ] Train and test metrics are never conflated anywhere in the output.
```
