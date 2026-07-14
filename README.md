# Project 1: Data Cleaning & Preparation
### DecodeLabs Industrial Training Kit — 2026 Batch

## Overview

This project is the foundation phase of the DecodeLabs Data Analytics internship track. The objective was not to build charts or models, but to take a raw dataset and prove it is reliable, consistent, and free of structural errors before any analysis is built on top of it — the principle DecodeLabs calls "Data Integrity."

The work was carried out entirely in **Microsoft Excel**, using formulas and built-in tools (Remove Duplicates, Go To Special, Number Formatting) rather than external scripts, to demonstrate core spreadsheet-based data cleaning competency.

---

## Dataset

**File:** `Dataset_for_Data_Analytics.xlsx`
**Size:** 1,200 rows × 14 columns
**Domain:** E-commerce order transactions

| Column | Description |
|---|---|
| OrderID | Unique identifier for each order |
| Date | Date the order was placed |
| CustomerID | Unique identifier for the customer |
| Product | Item purchased (e.g., Monitor, Phone, Laptop) |
| Quantity | Number of units ordered |
| UnitPrice | Price per unit (USD) |
| ShippingAddress | Delivery address |
| PaymentMethod | Method used to pay (Debit Card, Credit Card, Online, Cash, Gift Card) |
| OrderStatus | Current status (Shipped, Delivered, Pending, Cancelled, Returned) |
| TrackingNumber | Shipment tracking code |
| ItemsInCart | Number of items in the customer's cart at checkout |
| CouponCode | Discount code applied, if any |
| ReferralSource | Channel that brought the customer in (Instagram, Facebook, Email, Google, Referral) |
| TotalPrice | Final order value (USD) |

---

## What I Did

The cleaning process followed a three-phase approach, mirroring the DecodeLabs methodology of Imputation → Integrity Audit → Standardization, followed by a documented verification stage.

### Phase 1 — Missing Value Imputation
- Scanned all 14 columns for blank cells using `COUNTBLANK()` and Excel's **Go To Special → Blanks** tool.
- Identified 309 blank values, all confined to the `CouponCode` column. Every other column was fully populated.
- Determined that a blank `CouponCode` does not represent missing/lost data — it represents an order where **no coupon was used**. Because of this, the fix was not a statistical substitution (mean/median/mode), which is only appropriate for numeric fields with a natural central tendency. Instead, blanks were explicitly filled with the label **"NONE"**, turning an ambiguous null into an analyzable category.

### Phase 2 — Integrity Audit (Duplicate Detection)
- Ran Excel's **Remove Duplicates** tool on `OrderID` alone to check for repeated unique identifiers.
- Ran a second pass with all columns selected, to catch any fully duplicated rows.
- Backed both checks with a formula-based audit for a quantifiable result:
  ```
  =SUMPRODUCT((COUNTIF(OrderID_range,OrderID_range)>1)*1)
  ```

### Phase 3 — Standardization
- Verified that the `Date` column contains genuine Excel date values (not text) using `=ISNUMBER()`, and applied a consistent ISO 8601 display format (`yyyy-mm-dd`).
- Checked text columns (`ShippingAddress`, `Product`, `PaymentMethod`, `OrderStatus`, `ReferralSource`) for hidden whitespace or non-printing characters using `=TRIM(CLEAN())` compared against the original with `=EXACT()`.
- Checked for inconsistent capitalization (e.g., "mumbai" vs. "MUMBAI" vs. "Mumbai") using `=PROPER()`.
- Verified numeric precision (2 decimal places) on `UnitPrice` and `TotalPrice`, and cross-checked that `TotalPrice` was mathematically consistent with `UnitPrice × Quantity`, using:
  ```
  =SUMPRODUCT((ROUND(UnitPrice_range*Quantity_range,2)<>TotalPrice_range)*1)
  ```

### Verification Table
All four core checks were consolidated into a single "Duplicate/Formatting Check" summary table on the worksheet, so results are visible at a glance rather than buried in scattered formulas:

| Check | Result |
|---|---|
| Duplicate OrderIDs | 0 |
| Date format errors | 0 |
| Casing inconsistencies | 0 |
| TotalPrice math mismatches | 0 |

### Audit Log
Every change made to the dataset was documented in a dedicated **Audit Log** sheet, recording the Change ID, a description of the action taken, its impact, and its resolution status — so the reasoning behind every edit is traceable.

---

## Findings

| Area Checked | Result |
|---|---|
| Missing values | 309 blank `CouponCode` entries found and resolved (filled with "NONE"); all other columns fully populated |
| Duplicate OrderIDs | 0 found |
| Fully duplicate rows | 0 found |
| Date formatting errors | 0 found — all dates stored as valid Excel date values |
| Text whitespace/hidden characters | 0 found across all text columns |
| Casing inconsistencies | 0 found |
| TotalPrice calculation mismatches | 0 found — TotalPrice consistently equals UnitPrice × Quantity |

**Conclusion:** Aside from the CouponCode gap, the dataset was already structurally sound. The cleaning process focused on confirming this rigorously — through repeatable, auditable formulas — rather than assuming cleanliness at a glance. This distinction matters: a dataset that "looks fine" and a dataset that is *proven* fine are not the same thing, and the latter is what this project set out to demonstrate.

---

## Files in This Repository

- `Dataset_for_Data_Analytics.xlsx` — Cleaned dataset, including the imputed CouponCode values, verification check table, and Audit Log sheet.
- `README.md` — This file.

---

## Tools Used

Microsoft Excel — Tables, Go To Special, Remove Duplicates, conditional formulas (`COUNTIF`, `SUMPRODUCT`, `ISNUMBER`, `TRIM`, `CLEAN`, `EXACT`, `PROPER`, `ROUND`), and custom number formatting.

---

*Submitted as Project 1 of the DecodeLabs Industrial Training Kit, Data Analytics Track — 2026 Batch.*
