# TTC Bus Delay Analysis: Findings and Definitions

## Scope

This project analyzes 115,850 TTC bus delay records from 2023 and 2024.
It uses Python and pandas to prepare the data and PostgreSQL to validate
and explore it.

## Metric definitions

- Logged records: rows in the source data, including zero-minute delays.
- Positive-delay records: rows where `min_delay > 0`.
- Recorded delay minutes: the sum of `min_delay` across rows.
- Average positive delay: the average `min_delay` among positive-delay rows.
- Hour: the hour recorded for an incident. A record's full delay duration
  is assigned to that hour in the hourly analysis.

## Findings

1. Recorded delay minutes rose from 1,138,282 in 2023 to 1,265,531 in
   2024. The average positive delay rose from 22.1 to 23.9 minutes.
2. March 2024 had 135,702 recorded delay minutes, compared with 91,931
   in March 2023. The median positive delay was 12 minutes in both March
   periods, while records of at least 120 minutes rose from 96 to 162.
3. Diversion records accounted for 405,541 recorded delay minutes in
   2023 and 531,557 in 2024.
4. The zero-minute share of General Delay records changed from 21.2%
   in 2023 to 64.1% in 2024. Comparing category record counts alone
   would therefore be misleading.
5. Records logged at 7 AM in 2024 had unusually high summed delay
   minutes. Diversion records contributed 70,138 of the 107,518 minutes
   assigned to that hour. Several long records occurred on nearby routes
   and dates, so they may represent related disruptions.

## Interpretation limits

- These data do not include the total number of scheduled or completed
  bus trips. Incident counts cannot establish a route's delay rate or
  reliability.
- Some routes and directions are missing. Route comparisons exclude
  records without a route.
- The data have no unique disruption ID. Multiple rows may describe
  related events, so summed record-level delay minutes should not be
  described as distinct system-wide disruptions.
- The analysis retains zero-minute records and possible exact duplicates.
  Their meaning is not confirmed, so they were not silently deleted.
- Differences between years describe the published records; they do not
  establish the cause of a change.