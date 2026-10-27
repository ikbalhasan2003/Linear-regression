# Step 02 — Dataset Inspection & Validation

**Maps to:** FR-02 · **Priority:** Must have · **Depends on:** Step 01
**Files touched:** `notebooks/Experiment2-regression.ipynb`

---

## Prompt

```text
STEP: Dataset inspection and validation before modelling.
(Assume the Base Prompt for this project. Assume Step 01 is done: load_csv exists.)

GOAL
Show, for each dataset, its shape, columns, descriptive statistics and data-quality
checks BEFORE any model is fitted, and stop the workflow with a clear message when data
is unsuitable.

BACKGROUND
- regress_data1.csv: 人口 -> 收益 (97 rows).
- regress_data2.csv: 面积 + 房间数 -> 价格 (47 rows).
- The experiment must later remain interpretable: every model result has to be traceable
  to named features and a named target.

TASKS
1. Add a reusable validation helper:
       def summarize_dataset(df, name, features, target):
           ...
   which prints/returns: name, shape, column list, df.head(), df.describe(),
   missing-value counts, and the dtype of each feature/target column.
2. Add checks that raise a clear ValueError when:
   - any required feature/target column is missing,
   - any NaN / infinite values exist in the selected columns,
   - any required column is non-numeric,
   - the row count is empty.
   Messages must name the offending column(s). Fail loudly and stop — do not silently
   drop rows in this step.
3. Explicitly declare the modelling contract once per dataset, e.g.
       FEATURES_1, TARGET_1 = ["人口"], "收益"
       FEATURES_2, TARGET_2 = ["面积", "房间数"], "价格"
   and print them so the role of each column is visible in the output.
4. Report basic statistics per dataset: row count, feature/target ranges, mean, std, and
   the Pearson correlation between each feature and the target.
5. Add short markdown before each block stating which dataset is being inspected, what
   the columns mean (English gloss alongside the Chinese header), and what to notice in
   the numbers (e.g. the differing scales in data2 motivating standardization later).

CONSTRAINTS
- Do not fit or plot any model yet — this step is inspection only. (A plain data
  scatter from Step 01-or-earlier teaching cells may stay, but add no fitted line.)
- Do not modify the CSV files; validation happens in the notebook.
- Keep one helper used by both datasets instead of duplicated ad-hoc print calls.

DEFINITION OF DONE
[ ] Both datasets are inspected before any model cell runs.
[ ] shape, columns, head, describe, missing values and dtypes are shown for each.
[ ] Feature list and target name are explicitly printed per dataset.
[ ] NaN / non-numeric / empty-data conditions raise a clear, named error.
[ ] Correlations with the target are reported (expect ~0.838 for data1;
    ~0.855 area and ~0.442 rooms for data2).
[ ] A markdown cell explains each inspection block in the report's language.
