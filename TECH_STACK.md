# Recommended Tech Stack

## Project shape

Keep this project as a reproducible, educational Jupyter Notebook experiment. The supplied materials do not call for a web application, API, database, or deployment platform.

## Selected stack

| Area | Selection | Purpose |
| --- | --- | --- |
| Language and runtime | Python 3.11 | Main language for the experiment and a stable baseline for the scientific Python ecosystem. |
| Interactive environment | Jupyter Notebook | Run the experiment in an instructional, step-by-step format and present code, results, and explanations together. |
| Numerical computing | NumPy | Implement gradient descent, cost calculations, and least-squares comparisons directly. |
| Data handling | pandas | Load and inspect the supplied CSV datasets, validate columns and values, and select features and targets. |
| Visualization | Matplotlib | Plot observations, fitted lines, training cost, and model-validation results. |
| Machine learning | scikit-learn | Demonstrate `LinearRegression`, Ridge regression, metrics, cross-validation, and leakage-safe pipelines. |
| Data format | CSV | Keep using `PRD/regress_data1.csv` and `PRD/regress_data2.csv` as the experiment inputs. |
| Dependency installation | pip | Install the Python packages in the selected environment. |

## Dependency set

Install these packages in the Python 3.11 environment:

```text
jupyter
numpy
pandas
matplotlib
scikit-learn
```

These are the direct dependencies implied by the notebook and experiment requirements. Pin exact package versions in a dependency file if a known-good environment is established; no package versions have been verified for this workspace yet.

## Implementation conventions

- Keep the notebook as the primary implementation and report-preparation artifact.
- Use NumPy for the from-scratch univariate algorithms and scikit-learn for estimator demonstrations and evaluation.
- Use pandas to read the provided CSV files and explicitly name each input feature and target.
- Keep preprocessing that learns from data inside scikit-learn pipelines during cross-validation.
- Store datasets in `PRD/` and resolve their paths relative to the notebook or project location rather than assuming a particular current working directory.
- Use Matplotlib for labeled, interpretable plots; keep Chinese labels where useful and provide readable labels if the configured Chinese font is unavailable.

## Deliberately out of scope

Do not add a frontend framework, backend/API framework, database, container platform, or model-serving infrastructure unless requirements change. This is a course experiment, not a deployed application.
