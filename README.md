# Categorical Encoding in SQL: Breast Cancer Dataset

Most machine learning models need numbers, but clinical datasets are full of categories: yes/no answers, labels and value ranges. This project prepares a real breast cancer dataset for modeling using only SQL, applying the four most common techniques for categorical data: **binarization**, **label encoding**, **categorization** and **recategorization**.

## The dataset

The [Breast Cancer dataset](https://archive.ics.uci.edu/dataset/14/breast+cancer) from the UC Irvine Machine Learning Repository: **286 patients** and **10 attributes**, all categorical except the malignancy degree.

| Attribute (table column) | Original values | Notes |
| --- | --- | --- |
| `classe` (class) | `no-recurrence-events`, `recurrence-events` | 201 vs. 85: imbalanced target |
| `idade` (age) | 10-year ranges, `20-29` to `70-79` | |
| `menopausa` (menopause) | `premeno`, `ge40`, `lt40` | |
| `tamanho_tumor` (tumor size, mm) | 11 ranges, `0-4` to `50-54` | |
| `inv_nodes` (involved lymph nodes) | ranges, e.g. `0-2`, `3-5` | |
| `node_caps` | `no`, `yes`, `?` | 8 missing values |
| `deg_malig` (malignancy degree) | 1, 2, 3 | already numeric |
| `seio` (breast) | `left`, `right` | |
| `quadrante` (quadrant) | `left_up`, `left_low`, `right_up`, `right_low`, `central`, `?` | 1 missing value |
| `irradiando` (irradiated) | `no`, `yes` | |

The original `.data` file was converted to CSV, a header row was added, and the data was loaded into a MySQL table with the column names in Portuguese (`cria_tabela.sql`).

## Transformations

| Column | Technique | Mapping |
| --- | --- | --- |
| `classe` | Binarization | `no-recurrence-events` → 0, `recurrence-events` → 1 |
| `irradiando` | Binarization | `no` → 0, `yes` → 1 |
| `node_caps` | Label encoding | `no` → 0, `yes` → 1, missing → 2 |
| `quadrante` | Label encoding | `left_up` → 1, `right_up` → 2, `left_low` → 3, `right_low` → 4, `central` → 5, missing → 0 |
| `seio` | Categorization | `left` → `E` (*esquerdo*), `right` → `D` (*direito*) |
| `tamanho_tumor` | Recategorization | 11 ranges grouped into 6 categories (below) |

**Why these choices**

- **Binarization** fits columns with exactly two values, and the target `classe` becomes ready for a classifier.
- **Label encoding with an explicit code for missing values** keeps the 8 + 1 rows with `?` in the dataset instead of dropping them, while still flagging them.
- **Recategorization** reduces 11 thin size ranges, some with very few patients, to 6 groups that are easier to read and compare:

| New category | Original ranges (mm) | Patients |
| --- | --- | --- |
| Muito Pequeno (very small) | 0-4, 5-9 | 12 |
| Pequeno (small) | 10-14, 15-19 | 58 |
| Medio (medium) | 20-24, 25-29 | 104 |
| Grande (large) | 30-34, 35-39 | 79 |
| Muito Grande (very large) | 40-44, 45-49 | 25 |
| Tratamento Urgente (urgent treatment) | 50-54 | 8 |

## Result

`script-final.sql` runs each transformation on its own (so every step can be checked), then combines them in one query and stores the result in a new table, `TB_DADOS2`. The table was exported to `datasets/novo_dataset.csv`:

```text
Before:  no-recurrence-events,30-39,premeno,30-34,0-2,no,3,left,left_low,no
After:   0;"30-39";"premeno";"Grande";"0-2";0;3;"E";3;0
```

## How to run

1. Create a schema called `db` in MySQL.
2. Run `cria_tabela.sql` to create `TB_DADOS`.
3. Import `datasets/breast-cancer.csv` into `TB_DADOS`, for example with MySQL Workbench's Table Data Import Wizard.
4. Run `script-final.sql`. It ends by creating `TB_DADOS2` and counting its rows (286).

## Next steps

- **One-hot encoding** for `quadrante` and `menopausa`: label encoding implies an order (5 > 1) that quadrants don't have, so one column per category would suit most models better.
- **Ordinal encoding** for the range columns (`idade`, `inv_nodes`, `tamanho_tumor`), which do have a natural order.
- A first **classification model** on the encoded table, accounting for the 70/30 class imbalance.

## Files

| File | Content |
| --- | --- |
| `cria_tabela.sql` | Creates the source table `TB_DADOS` |
| `script-final.sql` | Step-by-step transformations and creation of `TB_DADOS2` |
| `datasets/breast-cancer.data` | Original UCI file |
| `datasets/breast-cancer.csv` | Original data as CSV with a header |
| `datasets/novo_dataset.csv` | Encoded output |

## License

[MIT](LICENSE). The dataset belongs to the UCI Machine Learning Repository and keeps its original license.
