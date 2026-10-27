# Step 08 — Visualizations and Interpretation

**Maps to:** FR-09 (Should have) · **Depends on:** Steps 03–07
**Files touched:** `notebooks/Experiment2-regression.ipynb`, `outputs/figures/`

---

## Prompt

```text
STEP: Produce labelled, report-ready figures and write their interpretation.
(Assume the Base Prompt. Assume Steps 01-07 produced all models, metrics, and results.)

GOAL
Give every result a readable, correctly labelled figure plus a written interpretation that
supports the experiment report, for both the univariate and multivariable workflows.

BACKGROUND
- Figures should already partially exist from earlier steps (fitted line, cost history,
  alpha vs RMSE). This step unifies their style, guarantees they are saved, and adds the
  missing/interpretive ones.
- Chinese matplotlib labels rely on the SimHei font, which may be absent on other machines.

TASKS
1. Standardize figure hygiene across the notebook: a single helper or consistent preamble,
   e.g.
       def save_fig(name): FIG_DIR.mkdir(parents=True, exist_ok=True);
                          plt.savefig(FIG_DIR / name, dpi=150, bbox_inches="tight")
   Every figure must have: title, x-label, y-label (with units/metric name), legend where
   multiple series are shown, and a consistent figsize.
2. Required figures (save each to outputs/figures/ with descriptive filenames):
   a. data1 scatter + fitted line(s) for the final chosen model.
   b. Gradient-descent training cost vs iteration — y-axis labelled "J(w) (half MSE cost)".
   c. Comparison of the three simple-regression fits (GD / LSM / sklearn) in one axes.
   d. Train vs test MSE bars for the Step 06 comparison table.
   e. Ridge alpha (log scale) vs mean CV RMSE with the selected alpha marked.
   f. Multivariable: predicted vs actual 价格 scatter (identity reference line included),
      and optionally a residual-vs-predicted plot.
3. Font fallback: wrap the SimHei configuration so a missing font cannot crash the kernel;
   ensure axis titles remain readable (e.g. bilingual labels "人口 / Population (10,000s)"),
   and document the fallback in a markdown cell.
4. Write an interpretation paragraph (markdown) directly beneath EACH figure stating:
   which dataset it uses, which model produced it, what trend/pattern is visible, and what
   conclusion the report can draw from it. One or two sentences minimum per figure.
5. Note qualitative findings explicitly: positive relationship between 人口 and 收益; the
   weaker relationship between 房间数 and 价格 versus 面积; the effect of feature scaling on
   multivariable coefficients; and the shrinkage effect of Ridge alpha.
6. Add a residual-distribution comment for the multivariable fit: whether residuals look
   unstructured (a linear fit is plausible) or show curvature/heteroscedasticity.

CONSTRAINTS
- Do not invent numbers — every plotted value must come from the executed cells above.
- Do not change model code in this step; only presentation and narrative.
- Keep Chinese labels where they add clarity, English gloss alongside for portability.

DEFINITION OF DONE
[ ] All six listed figures exist, are saved under outputs/figures/ as files, and render
    inline in the notebook.
[ ] Every figure has title + labelled axes + legend where needed.
[ ] Missing SimHei font cannot crash execution; fallback is documented.
[ ] Each figure is followed by a markdown interpretation naming dataset, model, and finding.
[ ] Multivariable residuals are examined with an explicit plausibility comment.
[ ] No hard-coded numbers in labels that contradict the computed results.
```
