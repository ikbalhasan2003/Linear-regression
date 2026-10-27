# Prompts — Linear Regression Experiment

Modular prompts for building this project step by step. Each file is a standalone prompt
for one implementation step; combine it with `00-base-prompt.md` (shared project context)
when sending it to the AI agent.

## How to use

1. Read `00-base-prompt.md` once — it carries project identity, datasets, stack, and the
   global conventions every step must follow.
2. Run the steps **in order**. Each step assumes the previous ones are done.
3. For each step, send: `00-base-prompt.md` + the step file. Optionally append the current
   step in `PROMPT_CHECKLIST.md` status notes.
4. Do not skip forward: later steps depend on earlier helpers (loaders, cost functions,
   model wrappers) existing in the notebook.

## Steps

| # | File | Purpose | Maps to |
| - | ---- | ------- | ------- |
| 00 | [00-base-prompt.md](./00-base-prompt.md) | Shared context for all steps | — |
| 01 | [01-environment-and-data-loading.md](./01-environment-and-data-loading.md) | Reproducible env, deps, robust CSV loading | FR-01 |
| 02 | [02-data-inspection-and-validation.md](./02-data-inspection-and-validation.md) | Inspect + validate both datasets | FR-02 |
| 03 | [03-numpy-gradient-descent.md](./03-numpy-gradient-descent.md) | Univariate batch gradient descent from scratch | FR-03 |
| 04 | [04-numpy-least-squares.md](./04-numpy-least-squares.md) | Stable least-squares (normal equation w/ lstsq) | FR-04 |
| 05 | [05-sklearn-simple-and-multivariable.md](./05-sklearn-simple-and-multivariable.md) | sklearn LinearRegression on both datasets | FR-05 |
| 06 | [06-model-comparison-and-metrics.md](./06-model-comparison-and-metrics.md) | Compare GD vs LSM vs sklearn with labeled metrics | FR-06 |
| 07 | [07-ridge-and-leakage-safe-validation.md](./07-ridge-and-leakage-safe-validation.md) | Ridge alpha sweep inside leakage-safe Pipelines | FR-07, FR-08 |
| 08 | [08-visualization-and-interpretation.md](./08-visualization-and-interpretation.md) | Labeled plots + written interpretation | FR-09 |
| 09 | [09-report-deliverables.md](./09-report-deliverables.md) | Flowchart, result tables, report-ready package | FR-10 |

Ordering follows the "Suggested implementation order" in `FEATURE_REQUIREMENTS.md`:
FR-01/02 → FR-03/04/05 → FR-06/08 → FR-07/09 → FR-10.

## Notes

- Steps 07 and 08 can be swapped if you prefer figures early; `09` must come last because
  it assembles everything produced above.
- Every step prompt ends with a **Definition of Done** checklist — run it before moving on.
- Update the status column in [PROMPT_CHECKLIST.md](./PROMPT_CHECKLIST.md) after each step.
