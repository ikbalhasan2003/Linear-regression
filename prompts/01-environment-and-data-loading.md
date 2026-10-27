# Step 01 — Environment & Reproducible Data Loading

**Maps to:** FR-01 · **Priority:** Must have · **Depends on:** nothing
**Files touched:** `requirements.txt` (new), `README.md`, `notebooks/Experiment2-regression.ipynb`

---

## Prompt

```text
STEP: Reproducible environment and data loading.
(Assume the Base Prompt for this project.)

GOAL
Make the notebook load both supplied CSV files reliably from the project directory,
without depending on the current working directory, and document the environment
required to run the experiment.

BACKGROUND
- The notebook's existing cells read 'data/regress_data1.csv' / 'data/regress_data2.csv'.
  That breaks whenever Jupyter is launched from a different folder.
- The project root is d:/WIT/6th semester/AI/Linear regression
- Working CSV copies live in data/; the pristine instructor copies live in PRD/
  (PRD/ is read-only — never modify it).
- There is no dependency manifest yet.

TASKS
1. Create requirements.txt at the project root with:
       jupyter
       numpy
       pandas
       matplotlib
       scikit-learn
   (Unpinned is acceptable; if versions are actually verified, pin them and note it.)
2. In the notebook, add a setup cell near the top that:
   - defines PROJECT_ROOT robustly, e.g.
         from pathlib import Path
         PROJECT_ROOT = Path.cwd().parent if Path.cwd().name == "notebooks" else Path.cwd()
     (adjust so it resolves to the folder that contains data/)
   - exposes DATA_DIR = PROJECT_ROOT / "data", FIG_DIR = PROJECT_ROOT / "outputs" / "figures",
     RESULT_DIR = PROJECT_ROOT / "outputs" / "results", and creates those output dirs with
     mkdir(parents=True, exist_ok=True).
3. Replace hard-coded relative CSV strings with a reusable loader function:
       def load_csv(filename, required_columns=None):
           path = DATA_DIR / filename
           if not path.exists(): raise FileNotFoundError(...)
           df = pd.read_csv(path)
           missing = [c for c in (required_columns or []) if c not in df.columns]
           if missing: raise ValueError(f"{filename} missing required columns: {missing}")
           return df
   Use it for:
       data1 = load_csv("regress_data1.csv", ["人口", "收益"])
       data2 = load_csv("regress_data2.csv", ["面积", "房间数", "价格"])
   Error messages must state the missing file/column and the expected location.
4. Set a global seed constant (e.g. RANDOM_STATE = 42) in the setup cell for later use.
5. Configure matplotlib once in the setup cell: try rcParams["font.sans-serif"] = ["SimHei"]
   with rcParams["axes.unicode_minus"] = False, wrapped so a missing font does not crash
   (document the fallback in a markdown cell).
6. Update README.md run instructions only if they no longer match reality.

CONSTRAINTS
- Do not change analysis/model cells in this step — only loading/setup/plumbing.
- Do not add new third-party dependencies beyond the documented stack.
- Keep executing the notebook top-to-bottom afterwards so saved outputs are real.

DEFINITION OF DONE
[ ] requirements.txt exists at project root and lists the five packages.
[ ] Both datasets load by name via load_csv with their Chinese column requirement.
[ ] Deleting/renaming a CSV or a required column raises a clear FileNotFoundError /
    ValueError naming the missing item.
[ ] Notebook runs top-to-bottom from `notebooks/` AND from the project root.
[ ] Figure/result output directories are created by code, not by hand.
[ ] No absolute machine-specific path is hard-coded in the notebook.
