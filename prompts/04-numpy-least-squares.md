# Step 04 — NumPy Least Squares (Normal Equation)

**Maps to:** FR-04 · **Priority:** Must have · **Depends on:** Steps 01–03
**Files touched:** `notebooks/Experiment2-regression.ipynb`

---

## Prompt

```text
STEP: Least-squares solution for univariate regression, numerically stable.
(Assume the Base Prompt. Assume Step 03 already trains gradient descent on X1, y1.)

GOAL
Compute the least-squares closed-form solution for the SAME univariate data and compare
its coefficients directly with gradient descent, using a stable solver.

BACKGROUND
- The notebook already defines `LSM(X, y)` implementing
      w = inv(X.T @ X) @ X.T @ y
  with saved output intercept -3.8958, slope 1.1930 for X1, y1.
- Explicitly inverting X.T @ X is numerically unstable and fails on singular /
  rank-deficient matrices — this is listed as a known defect in PROJECT_CONTEXT.md.

TASKS
1. Rewrite `LSM(X, y)` to use a stable solver:
       w, residuals, rank, sv = np.linalg.lstsq(X, y, rcond=None)
   Report `rank` alongside the coefficients, and warn when rank < number of columns
   (the fit is then not unique). Optionally show np.linalg.pinv as a cross-check.
2. Keep the returned convention identical to Step 03: column vector of shape (2, 1) in
   the order [intercept, slope], so results are directly comparable.
3. Fit LSM on the SAME X1, y1 used by gradient descent — same observations, same target,
   same intercept convention. Do not re-standardize or re-subset.
4. Print intercept and slope to 4 decimals, plus the cost computed with the SAME
   `computeCost` from Step 03.
5. Add a side-by-side comparison cell that shows, for GD vs LSM:
   - intercept, slope (difference and % relative difference),
   - cost J(w) under the identical cost function,
   - MSE and R^2 on the same data, labelled clearly as TRAINING metrics.
6. Also fit LSM on the multivariable dataset (data2 features 面积 + 房间数, target 价格)
   to demonstrate that the closed-form solution generalises to multiple features — report
   intercept and each named coefficient.
7. Add markdown explaining: the normal equation and how it is derived by setting the
   gradient to zero; why lstsq/pinv is preferred over inv(X.T @ X); cost/robustness and
   complexity differences versus gradient descent (closed form vs iterative, scaling with
   feature count, behaviour with large feature counts).

CONSTRAINTS
- No sklearn fitting in this step; comparison here is NumPy GD vs NumPy LSM.
- Do NOT delete `computeCost`; reuse it so both models are scored identically.
- Keep differences explained rather than only printed.

DEFINITION OF DONE
[ ] `LSM` uses np.linalg.lstsq (or pinv) and no raw matrix inverse remains.
[ ] LSM is fitted exactly on Step 03's X1, y1 with the same intercept convention.
[ ] Output shows intercept ~ -3.8958, slope ~ 1.1930 (small deviation acceptable).
[ ] GD vs LSM costs are computed with the same function and are shown side by side.
[ ] Rank is reported; a rank-deficient matrix produces a warning, not a crash.
[ ] Multivariable LSM fit reports intercept + named coefficients.
[ ] Markdown explains the normal equation, stability, and GD-vs-LSM trade-offs.
```
