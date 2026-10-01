from pathlib import Path
import pandas as pd

file_path = Path("data/raw/ttc-bus-delay-data-2024.xlsx")
workbook = pd.ExcelFile(file_path)

print("Sheets:", workbook.sheet_names)

first_sheet = workbook.sheet_names[0]
sample = pd.read_excel(workbook, sheet_name=first_sheet, nrows=5)

print("\nFirst sheet:", first_sheet)
print("\nColumns:", sample.columns.tolist())
print("\nFirst five rows:")
print(sample.to_string(index=False))

data = pd.read_excel(workbook, sheet_name=first_sheet)

print("\nRows and columns:", data.shape)
print("\nData types:")
print(data.dtypes.to_string())
print("\nMissing values by column:")
print(data.isna().sum().to_string())
print("\nExact duplicate rows:", data.duplicated().sum())
print("Zero-minute delay rows:", (data["Min Delay"] == 0).sum())

print("\nExamples with missing routes:")
print(data.loc[data["Route"].isna()].head(5).to_string(index=False))

print("\nExamples of identical rows:")
print(data.loc[data.duplicated(keep=False)].head(10).to_string(index=False))

print("\nMost common incident types with zero-minute delays:")
print(
    data.loc[data["Min Delay"] == 0, "Incident"]
    .value_counts()
    .head(10)
    .to_string()
)

print("\nNegative delay values:", (data["Min Delay"] < 0).sum())

file_path_2023 = Path("data/raw/ttc-bus-delay-data-2023.xlsx")
workbook_2023 = pd.ExcelFile(file_path_2023)

print("\n2023 sheets:", workbook_2023.sheet_names)

data_2023 = pd.read_excel(
    workbook_2023,
    sheet_name=workbook_2023.sheet_names[0]
)

print("2023 rows and columns:", data_2023.shape)
print("2023 columns:", data_2023.columns.tolist())
print("Columns match 2024:", data_2023.columns.tolist() == data.columns.tolist())
print("\n2023 missing values:")
print(data_2023.isna().sum().to_string())