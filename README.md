# Breast Cancer Data Analysis: Categorization and Encoding in SQL

This project prepares a breast cancer dataset for analysis using data transformation techniques in SQL. The process is described step by step below.

## Data Extraction and Preparation

The breast cancer data comes from the [UC Irvine Machine Learning Repository](https://archive.ics.uci.edu/dataset/14/breast+cancer).

The original `.data` file was converted to `.csv` for easier import, and a header row with the column names was added.

A table was created in MySQL, with the column names translated into Portuguese.

## Transformations

1. **Binarization of the 'Classe' (class) column**

   Binarization turns categorical variables into binary values (0 or 1). Here, the 'Classe' column was binarized to represent the two breast cancer classes: 'no-recurrence-events' became 0 and 'recurrence-events' became 1. Mapping categories to numbers makes the data easier to interpret and analyze.

2. **Binarization of the 'Irradiando' (irradiated) column**

   In the same way, 'no' values became 0 and 'yes' values became 1. Binary values are often more convenient for algorithms and visualizations.

3. **Label encoding of the 'Node_Caps' column**

   Label encoding assigns a numeric label to each category of a variable. 'Node_Caps' has three possible values ('no', 'yes' and missing): 'no' became 0, 'yes' became 1 and missing values became 2. This keeps the information about missing values usable in the analysis.

4. **Categorization of the 'Seio' (breast side) variable**

   Categorization assigns labels to categories, usually to simplify a variable. Using a `CASE` clause, 'left' became 'E' (esquerdo) and 'right' became 'D' (direito), making the values clearer for the Portuguese-language table.

5. **Recategorization of the 'Tamanho_Tumor' (tumor size) variable**

   Recategorization reorganizes the existing categories of a variable. 'Tamanho_Tumor' originally had 11 categories, which were grouped into 6 new ones: 'muito pequeno' (very small), 'pequeno' (small), 'medio' (medium), 'grande' (large), 'muito grande' (very large) and 'tratamento urgente' (urgent treatment). This makes the column easier to visualize and understand.

6. **Label encoding of the 'Quadrante' (quadrant) variable**

   As with 'Node_Caps', each quadrant was mapped to a number from 1 to 5, with the central quadrant as 5. Null values were encoded as 0 so they remain part of the analysis.

## Final Query and Export

A final query brings all the transformations together and is used to insert the transformed data into a new table.

That table was then exported to a CSV file: a cleaned and encoded version of the breast cancer dataset, ready for deeper analysis and compatible with most data visualization tools.

## Files

- `cria_tabela.sql`: creates the source table.
- `script-final.sql`: applies all the transformations and builds the final table.
- `datasets/`: original data (`breast-cancer.data`, `breast-cancer.csv`) and the transformed output (`novo_dataset.csv`).

## License

[MIT](LICENSE)
