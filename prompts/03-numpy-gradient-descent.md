# Step 03 — NumPy Univariate Regression: Batch Gradient Descent

**Maps to:** FR-03 · **Priority:** Must have · **Depends on:** Steps 01–02
**Files touched:** `notebooks/Experiment2-regression.ipynb`

---

## Prompt

```text
STEP: Univariate linear regression with NumPy batch gradient descent.
(Assume the Base Prompt for this project. Assume Step 01 loader and Step 02 validation.)

GOAL
Implement, from scratch with NumPy, simple linear regression on regress_data1.csv using
batch gradient descent, including cost history and fitted-line visualisation.

BACKGROUND
- Existing notebook already has `computeCost(X, y, w)` and
  `batch_gradientDescent(X, y, w, alpha, iters)` — keep/clean them rather than writing
  competing duplicates.
- Model:      h_w(x) = w0 + w1*x
- Cost:       J(w) = 1/(2m) * sum( h_w(x_i) - y_i )^2
- Update:     w := w - alpha * (1/m) * X.T @ (X @ w - y)   (simultaneous update, all j)
- Existing notebook settings: alpha = 0.01, iters = 1500, weights start at zero,
  X has a leading ones column.
- Reference outputs currently saved in the notebook (do NOT hard-code, re-derive):
  initial cost ~32.0727; final weights ~[-3.6303, 1.1664]; cost ~4.4834.

TASKS
1. Clean up the design matrix construction: build X1 (ones + 人口) and y1 (收益) in a
   single clearly named cell, using np.asarray with explicit float dtype and shapes.
2. Keep/refactor `computeCost(X, y, w)` — pure function, returns the scalar half-MSE
   cost, no printing, no side effects, no plotting.
3. Keep/refactor `batch_gradientDescent(X, y, w, alpha, iters)` so that it:
   - computes gradients using ONE consistent weight vector per iteration (true batch GD,
     not sequential/stochastic updates),
   - records cost every iteration in `cost_history` and returns (w_final, cost_history),
   - does not mutate the caller's `w` unexpectedly (copy, or document the behaviour),
   - is fully vectorised with NumPy — no Python loop over training examples.
4. Train with documented hyperparameters: alpha = 0.01, iters = 1500; put them in named
   variables with a markdown note explaining what they control.
5. Print/format intercept w0 and slope w1 to 4 decimals, plus the cost before and after
   training.
6. Produce two figures, saved to outputs/figures/:
   - scatter of 人口 vs 收益 with the fitted line overlaid, axis labels named,
   - cost_history vs iteration clearly labelled "training cost J(w)".
7. Add a brief convergence check cell: assert/report that cost decreased monotonically
   (within tolerance), or explicitly report divergence and its cause.
8. Add explanatory markdown: hypothesis form, cost definition, update rule as a formula,
   why all parameters update simultaneously, and why features at very different scales
   (cf. data2 later) need care.
9. Delete or correct stale comments that conflict with re-executed output.

CONSTRAINTS
- NumPy only for the algorithm — no sklearn in this step's fitting path.
- Preserve existing function names if other cells already call them, unless you update
  every call site.
- Report numbers with labels; never present training cost as a test metric.

DEFINITION OF DONE
[ ] `batch_gradientDescent` performs true batch updates and returns cost history.
[ ] Trained on regress_data1.csv with alpha and iters stated in the output.
[ ] Reproduces approximately intercept -3.63, slope 1.17, cost ~4.48 (small deviation is
    acceptable if explained; large deviation must be investigated).
[ ] Cost is decreasing across iterations (or divergence is explained).
[ ] Both figures exist, have labelled axes, and are saved under outputs/figures/.
[ ] A markdown cell documents the math shown above.
```
