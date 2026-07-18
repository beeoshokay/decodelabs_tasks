SQL Data Analysis

**Tool used:** Microsoft SQL Server 2022 (SSMS)

---

## 1. What this project is about

This project answers business questions about an online store using **SQL**, the language used to ask questions of data stored in a database (like "which product made the most money?" or "how many orders came from a particular referral source?").

Instead of scrolling through a spreadsheet of 1,200 orders by eye, SQL lets you ask the database directly and get an instant, accurate answer.

---

## 2. The dataset

The file `Dataset_for_Data_Analytics.xlsx` converted into a csv file, contains **1,200 online orders**, one row per order, with these columns:

| Column | What it means |
|---|---|
| OrderID | Unique code for each order |
| Date | When the order was placed |
| CustomerID | Unique code for the customer |
| Product | What was bought (Chair, Printer, Laptop, Tablet, Monitor, Desk, Phone) |
| Quantity | How many units were ordered |
| UnitPrice | Price of one unit |
| ShippingAddress | Where it was shipped |
| PaymentMethod | How it was paid for (Credit Card, Debit Card, Cash, Online, Gift Card) |
| OrderStatus | Delivered, Shipped, Pending, Returned, or Cancelled |
| TrackingNumber | Shipment tracking code |
| ItemsInCart | Number of items in the cart at checkout |
| CouponCode | Discount code used, if any |
| ReferralSource | How the customer found the store (Instagram, Email, Google, Facebook, Referral) |
| TotalPrice | Final amount paid for that order |

This data was loaded into SQL Server as a table called `Dataset_for_Data_Analytics`.

---

## 3. The building blocks of SQL used here

- **SELECT** — "show me these columns"
- **WHERE** — "but only the rows that match this condition" (like a filter)
- **GROUP BY** — "bundle the rows into categories" (e.g. one bundle per product)
- **COUNT() / SUM() / AVG()** — "count how many," "add them up," "find the average" 
- **HAVING** — like WHERE, but it filters the *bundles* after they've been grouped, not the individual rows
- **ORDER BY** — "sort the results"
- **Subquery** — a mini query nested inside a bigger one, used to calculate something (like a grand total) that the outer query needs

---

## 4. A few highlights

The full 10 findings with screenshots are in the report. A couple worth flagging here:

- **Chair earns the most total revenue ($195,620)** despite Printer having more orders.
- **Credit Card customers spend the most per order** ($1,127.55 avg), Debit Card the least ($1,001.56 avg).
- **No single product dominates revenue**: the top product accounts for only 15.5% of the total, so the business isn't over-reliant on one item.

---

## 6. How to run this yourself

1. Open **SQL Server Management Studio (SSMS)** and connect to a database that has the `Dataset_for_Data_Analytics` table loaded.
2. Open `Project3_Queries.sql`.
3. Highlight any single query and press **F5** (or click Execute) to run just that one.
4. The results appear in the **Results** tab underneath the query.

---

## 7. NOTE

SQL doesn't run in the order you *type* it. You write `SELECT → FROM → WHERE → GROUP BY`, but the database actually processes it as `FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY`. That's why a query like `WHERE TotalRevenue > 50000` fails if `TotalRevenue` is a name you only just created in your SELECT — the database checks WHERE *before* it even knows that name exists. The fix is to use `HAVING` instead, since HAVING runs after the grouping and naming has already happened.

---

## 8. Conclusion

This project was about proving data can go from a raw table to a specific, defensible answer using SQL by filtering, grouping, aggregating, and catching mistakes along the way. The data didn't reveal one product or being the main character, and that was worth finding out.

