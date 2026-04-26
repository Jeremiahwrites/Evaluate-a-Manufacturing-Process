# Evaluate a Manufacturing Process

## Project Overview

This project applies **Statistical Process Control (SPC)** techniques using SQL window functions and nested queries to evaluate the stability and consistency of a manufacturing process.

The objective was to monitor product **height measurements** across multiple machine operators and identify production points that fall outside statistically acceptable control limits.

By using rolling averages and rolling standard deviations, the process was assessed in real time to detect abnormal variation, quality drift, and potential operator or machine issues.

---

## Business Problem

Manufacturing quality depends on consistency. Even small deviations in product dimensions can lead to:

* Defective products
* Customer complaints
* Increased waste and rework
* Production downtime
* Reduced operational efficiency

The manufacturing team required a data-driven system to determine when process adjustments should be made instead of relying on guesswork.

---

## Dataset Information

The dataset `manufacturing_parts` contains:

| Column   | Description              |
| -------- | ------------------------ |
| item_no  | Sequential item produced |
| length   | Product length           |
| width    | Product width            |
| height   | Product height           |
| operator | Machine operator         |

This project focused on **height**, the critical quality measurement.

---

## Methodology

Using SQL, a rolling 5-part sample was created for each operator.

For every production point after the first 4 units:

* Calculated moving average height
* Calculated moving standard deviation
* Computed Upper Control Limit (UCL)
* Computed Lower Control Limit (LCL)
* Flagged products outside control range as alerts

### Control Limit Formula

UCL = Avg Height + 3 × (Std Dev / √5)

LCL = Avg Height - 3 × (Std Dev / √5)

---

## Tools Used

* SQL
* Window Functions
* Nested Queries
* Statistical Process Control (SPC)
* GitHub Documentation

---

## SQL Techniques Applied

* `ROW_NUMBER()`
* `AVG() OVER()`
* `STDDEV() OVER()`
* `PARTITION BY`
* Rolling Windows (`ROWS BETWEEN 4 PRECEDING AND CURRENT ROW`)
* CASE statements for anomaly detection

---

## Key Insights

## 1. Multiple Operators Produced Out-of-Control Parts

Several operators generated parts outside acceptable control limits, indicating unstable production behavior.

Operators with repeated alerts included:

* Op-14
* Op-16
* Op-7
* Op-5
* Op-2
* Op-9

This suggests targeted operator-level intervention is required.

---

## 2. Operator 14 Showed Frequent Instability

Operator 14 had multiple alerts across the production run, including both high and low height deviations.

This may indicate:

* Machine calibration inconsistency
* Tool wear
* Operator handling variability
* Maintenance issues

Operator 14 should be prioritized for investigation.

---

## 3. Operator 6 Was Highly Stable

Operator 6 maintained tight control limits with minimal variation and almost no alerts.

This operator demonstrates best-practice process behavior and can be used as a benchmark for others.

---

## 4. Sudden Spikes Suggest Process Drift

Examples of abnormal spikes:

* Height 23.39 (Op-5)
* Height 23.31 (Op-3)
* Height 23.11 (Op-2)

These values significantly exceeded expected variation and likely represent assignable causes rather than random fluctuation.

---

## 5. Low Measurements Also Caused Quality Risk

Examples of unusually low values:

* 17.97
* 18.05
* 18.51
* 18.57

This indicates the process risk exists on both extremes, not only overproduction.

---

## 6. Some Operators Showed Strong Mean Shifts

Certain operators experienced changing average heights over time, indicating the process centerline moved during production.

This can happen due to:

* Temperature changes
* Equipment fatigue
* Raw material inconsistency
* Operator adjustments

---

## Recommendations

### Immediate Actions

* Audit Operator 14, 16, 7, and 5 production lines
* Recalibrate machines showing repeated alerts
* Review maintenance schedules
* Inspect tooling wear

### Medium-Term Actions

* Deploy automated SPC dashboards
* Trigger alerts in real time when limits are exceeded
* Standardize best practices from Operator 6
* Train operators on process consistency

### Long-Term Actions

* Introduce predictive maintenance models
* Combine SPC with machine sensor data
* Use SQL + Power BI for continuous monitoring

---

## Business Impact

Implementing this SPC model can help reduce:

* Scrap rate
* Rework cost
* Downtime
* Customer returns

And improve:

* Product consistency
* Process confidence
* Operational efficiency
* Manufacturing profitability

---

## Sample Conclusion

The manufacturing process showed pockets of strong control alongside several unstable operator lines. Statistical monitoring successfully identified abnormal production points and highlighted where corrective action is needed. With real-time deployment, the business can shift from reactive quality control to proactive process excellence.

---

## Author

Jeremiah Kehinde
Data Analyst | SQL | Process Improvement | Business Intelligence
