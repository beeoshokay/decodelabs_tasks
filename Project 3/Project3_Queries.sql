-- Basic SELECT: view all columns
SELECT TOP 10 * FROM Dataset_for_Data_Analytics;

-- Basic SELECT: choose specific columns
SELECT OrderID, Product, TotalPrice, OrderStatus
FROM Dataset_for_Data_Analytics;

-- Equality: Orders with a specific value
SELECT OrderID, Product, TotalPrice
FROM Dataset_for_Data_Analytics
WHERE ReferralSource = 'Instagram';

-- Comparison: high-value orders
SELECT OrderID, Product, TotalPrice
FROM Dataset_for_Data_Analytics
WHERE TotalPrice >= 2000;

-- Pattern Matching: all tracking numbers
SELECT OrderID, TrackingNumber
FROM Dataset_for_Data_Analytics
WHERE TrackingNumber LIKE 'TRK9%';

--- Number of Orders per Product
SELECT Product, COUNT(*) AS OrderCount
FROM Dataset_for_Data_Analytics
GROUP BY Product
ORDER BY OrderCount DESC;

---Total revenue per product
SELECT Product, SUM(TotalPrice) AS TotalRevenue
FROM Dataset_for_Data_Analytics
GROUP BY Product
ORDER BY TotalRevenue DESC;

---Average order value per payment method
SELECT PaymentMethod, AVG(TotalPrice) AS AvgOrderValue
FROM Dataset_for_Data_Analytics
GROUP BY PaymentMethod
ORDER BY AvgOrderValue DESC;
 
 ---Order status breakdown per referral source
 SELECT ReferralSource, OrderStatus, COUNT(*) AS Orders
 FROM Dataset_for_Data_Analytics
 GROUP BY ReferralSource, OrderStatus
 ORDER BY ReferralSource, Orders DESC;

 --- Products with total revenue over 180,000
 SELECT Product, SUM(TotalPrice) AS TotalRevenue
 FROM Dataset_for_Data_Analytics
 GROUP BY Product
 HAVING SUM(TotalPrice) > 180000
 ORDER BY TotalRevenue DESC;

--- Product performance for Delivered/Shipped orders, revenue over 65,000
SELECT
 Product,
 COUNT(*) AS OrderCount,
 SUM(TotalPrice) AS TotalRevenue,
 AVG(TotalPrice) AS AvgOrderValue
FROM Dataset_for_Data_Analytics
WHERE OrderStatus IN ('Delivered', 'Shipped')
GROUP BY Product
HAVING SUM(TotalPrice) > 65000
ORDER BY TotalRevenue DESC;

---Percentage of total revenue contributed by each product
SELECT
 Product,
 SUM(TotalPrice) AS ProductRevenue,
 SUM(TotalPrice) * 100.0/ (SELECT SUM(TotalPrice) FROM Dataset_for_Data_Analytics) AS PercentOfTotal
FROM Dataset_for_Data_Analytics
GROUP BY Product
ORDER BY PercentOfTotal DESC;