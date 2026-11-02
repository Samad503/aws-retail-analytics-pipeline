
import pandas as pd
from pathlib import Path

folder = Path(__file__).resolve().parent
excel_file = folder / "online_retail_II.xlsx"

sheets = {
    "Year 2009-2010": "retail_year_1.csv",
    "Year 2010-2011": "retail_year_2.csv"
}

for sheet_name, csv_name in sheets.items():
    print(f"Converting {sheet_name}...")

    df = pd.read_excel(
        excel_file,
        sheet_name=sheet_name,
        engine="openpyxl",
        dtype={
            "Invoice": str,
            "StockCode": str,
            "Customer ID": str
        }
    )

    df.to_csv(
        folder / csv_name,
        index=False,
        encoding="utf-8"
    )

    print(f"Created: {csv_name}")
    print(f"Rows: {len(df):,}")
    print(f"Columns: {len(df.columns)}")

print("Conversion completed successfully!")
