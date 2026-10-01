from pathlib import Path
import pandas as pd

raw_dir = Path("data/raw")
yearly_data = []

for year in (2023, 2024):
    file_path = raw_dir / f"ttc-bus-delay-data-{year}.xlsx"
    year_data = pd.read_excel(file_path, sheet_name=str(year))
    year_data["source_year"] = year
    yearly_data.append(year_data)

combined = pd.concat(yearly_data, ignore_index=True)

print("Combined rows and columns:", combined.shape)
print("\nRows by source year:")
print(combined.groupby("source_year").size())

cleaned = combined.copy()
cleaned.columns = cleaned.columns.str.lower().str.replace(" ", "_")

cleaned["route"] = cleaned["route"].astype("string").str.strip()
cleaned["direction"] = cleaned["direction"].astype("string").str.strip().str.upper()
cleaned["incident"] = cleaned["incident"].astype("string").str.strip()
cleaned["location"] = cleaned["location"].astype("string").str.strip()

print("\nStandardized columns:", cleaned.columns.tolist())
print("Rows after standardizing:", len(cleaned))
print("Missing routes after standardizing:", cleaned["route"].isna().sum())

parsed_dates = pd.to_datetime(cleaned["date"], errors="coerce")
parsed_times = pd.to_datetime(cleaned["time"], format="%H:%M", errors="coerce")

print("\nUnparseable dates:", parsed_dates.isna().sum())
print("Unparseable times:", parsed_times.isna().sum())
print("Date and source-year mismatches:",
      (parsed_dates.dt.year != cleaned["source_year"]).sum())

print("\nDate range by source year:")
print(parsed_dates.groupby(cleaned["source_year"]).agg(["min", "max"]))

cleaned["date"] = parsed_dates

cleaned["incident_datetime"] = pd.to_datetime(
    cleaned["date"].dt.strftime("%Y-%m-%d") + " " + cleaned["time"],
    format="%Y-%m-%d %H:%M"
)

cleaned["month"] = cleaned["date"].dt.month
cleaned["hour"] = cleaned["incident_datetime"].dt.hour
cleaned["weekday"] = cleaned["date"].dt.day_name()

print("\nNew time fields:")
print(
    cleaned[
        ["date", "time", "incident_datetime", "month", "hour", "weekday"]
    ].head().to_string(index=False)
)
print("Rows after adding time fields:", len(cleaned))

reported_day = cleaned["day"].astype("string").str.strip().str.lower()
calculated_day = cleaned["weekday"].str.lower()
day_mismatch = reported_day != calculated_day

print("\nDay-label mismatches:", day_mismatch.sum())
print("Examples of mismatches:")
print(
    cleaned.loc[day_mismatch, ["date", "day", "weekday"]]
    .head(5)
    .to_string(index=False)
)

cleaned["has_measured_delay"] = cleaned["min_delay"] > 0
cleaned["has_route"] = cleaned["route"].fillna("").ne("")

print("\nRecords with measured delay by year:")
print(cleaned.groupby("source_year")["has_measured_delay"].sum())

print("\nRecords with a route by year:")
print(cleaned.groupby("source_year")["has_route"].sum())

print("\nNegative delay rows:", (cleaned["min_delay"] < 0).sum())
print("Rows still retained:", len(cleaned))

processed_dir = Path("data/processed")
processed_dir.mkdir(parents=True, exist_ok=True)

output_path = processed_dir / "ttc_bus_delays_2023_2024.csv"
cleaned.to_csv(output_path, index=False)

print("\nSaved:", output_path)
print("Saved rows:", len(cleaned))