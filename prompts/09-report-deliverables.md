# Step 09 — Report-Ready Deliverables

**Maps to:** FR-10 (Should have) · **Depends on:** Steps 01–08
**Files touched:** `notebooks/Experiment2-regression.ipynb`, `reports/`, `README.md`

---

## Prompt

```text
STEP: Assemble the experiment deliverables required by the brief.
(Assume the Base Prompt. Assume Steps 01-08 are complete and the notebook runs cleanly.)

GOAL
Produce the material the instructor's brief asks for: an algorithm flowchart, results and
analysis, commented source code, and a clear place for the student's own summary.

BACKGROUND
The brief requests: (1) an algorithm flowchart, (2) experimental results and analysis
diagrams, (3) source code with comments, and (4) a summary/experience section written
independently by the student. Only (4) must NOT be generated wholesale — provide structure.

TASKS
1. Flowchart: add a markdown cell containing a Mermaid flowchart of the whole experiment
   pipeline (load -> validate -> select features -> fit models -> evaluate -> compare ->
   report). Additionally provide a focused flowchart for the batch gradient descent loop
   (initialize w -> predict -> compute cost -> compute gradient -> update -> repeat until
   convergence/iterations). Optionally also render it as matplotlib shapes or save an SVG
   to outputs/figures/ if a static image is needed for the report.
2. Commented source code: create a "Consolidated code appendix" section at the end of the
   notebook that gathers the key functions — load_csv, summarize_dataset, computeCost,
   batch_gradientDescent, LSM — each with a concise docstring explaining parameters,
   return values, and the formula implemented. Comments should explain WHY, not restate
   Python syntax.
3. Results appendix: re-display (or link) the final result tables produced in Steps 06-07
   and copy them into outputs/results/ as CSV files; list every CSV/PNG artifact in the
   notebook so report writing can cite them.
4. Analysis write-up: add a markdown "Results and Analysis" section that explicitly covers
   the four comparisons the brief asks for:
   - NumPy handwritten vs scikit-learn implementation,
   - gradient descent vs least squares (including convergence behaviour),
   - parameter/model choices (learning rate, iterations, alpha for Ridge, scaling),
   - univariate vs multivariable behaviour.
   Reference concrete numbers/saved tables rather than speaking generally.
5. Summary scaffold: add a "实验总结 / Summary and Reflection" markdown section with
   headings (What was implemented; Key findings; Difficulties encountered; How they were
   solved; What I learned) that the STUDENT completes in their own words. Do not fill it
   with generated first-person prose presented as the student's own reflection — leave it
   as headings plus short factual reminders only.
6. Update README.md: run instructions, dependency install, what each folder holds, which
   artifacts are regenerable, and a "how to reproduce every result" note
   (Kernel -> Restart & Run All).
7. Optionally add a short reports/README.md listing exactly which figures/tables the report
   should embed and where to find them.

CONSTRAINTS
- Do not fabricate results; only cite numbers produced by actual executed cells.
- Keep the summary section as a scaffold for the student's independent writing.
- Do not add a web UI, packaging, or any non-notebook deliverable.
- Ensure the whole notebook executes top-to-bottom (Restart & Run All) without errors.

DEFINITION OF DONE
[ ] A Mermaid flowchart of the experiment pipeline and of the GD loop exists in the notebook.
[ ] A consolidated, commented code appendix contains all key functions with docstrings.
[ ] Every result table is available as CSV in outputs/results/ and listed in the notebook.
[ ] The analysis markdown covers NumPy vs sklearn, GD vs LSM, parameter choices, and
    univariate vs multivariable, citing concrete numbers.
[ ] The summary section is a scaffold awaiting the student's own writing.
[ ] README.md documents install, run, folders, and full reproducibility steps.
[ ] Full notebook restart-and-run-all completes with no errors and no stale outputs.
```
