# How I Worked Through This Dataset

This tab explains what I did to this order data and why, in plain terms. If you're not a data person, you should still be able to follow the reasoning here, that's the point.

## What's in this workbook

Five tabs beyond this one. **RawData** is the file exactly as it came to me, I never touched it, so there's always an original copy to check against. **WorkingData** is where I actually cleaned and analyzed things. **Stats** has my data quality checks and basic statistics. **Analysis** has the outlier detection, correlation work, and **PivotTrends** has the pivot tables and charts. **Summary** pulls it all into the findings that actually matter.

## Data Cleaning

Before calculating anything, I checked whether the data itself could be trusted. 1,200 orders, 14 columns. I counted blanks in every single column. 13 of the 14 came back completely full. The one exception was CouponCode, which was empty in 309 orders, a little over a quarter of the total.

My first instinct was to treat that as a problem. But when I looked closer, it made sense on its own: an empty CouponCode certainly means that the customer didn't use a coupon at all, not that someone forgot to enter one. So instead of leaving 309 blank cells sitting there looking like an error, I filled them with the word "None." Now anyone opening this sheet can tell at a glance that it's a real answer, not a missing one. A blank cell is ambiguous, "None" isn't.

I also checked that OrderID has no duplicates and I checked that TotalPrice actually equals Quantity times UnitPrice for every row. It does, every single time, with zero mismatches. So the money numbers in this dataset are internally consistent.

## The basic numbers

For Quantity, UnitPrice, and TotalPrice, I pulled the count, average, median, minimum, maximum, and the middle 50% range (Q1 to Q3) using Excel's built-in functions: AVERAGE, MEDIAN, QUARTILE.INC, and so on. The standard toolkit for understanding what a typical order looks like versus what an extreme one looks like.

One thing worth flagging: the average order value is noticeably higher than the median order value. That happens when a smaller number of big orders pull the average up while most orders actually sit lower than that average suggests. In plain terms, if someone asks "what does a typical customer spend?", the average is the wrong number to quote here. The median is closer to reality.

## Finding the unusual orders

To catch orders that stand out from the rest, I used something called the IQR method. It looks at the middle 50% of all order values and flags anything sitting far outside that range as unusual. I picked this method over a more common alternative (Z-scores) because Z-scores assume the data is shaped like a normal bell curve, and this data isn't. It leans toward a small number of high-value orders, which is exactly the skew I mentioned above. Using a method built for symmetric data on lopsided data gives you the wrong flags.

Every order flagged this way, I looked at individually rather than deleting automatically. Some are genuine large orders; big quantities of higher-priced items like laptops or printers and those stay in, because they're real business, not mistakes.

## What patterns showed up

Using pivot tables, I broke revenue down by month, by product, by referral source, by coupon code, by payment method, and by order status. A few things stood out enough to mention:

Order status is split almost evenly across five stages: cancelled, returned, pending, shipped, and delivered, each sitting somewhere between roughly 230 and 250 orders. That means a large chunk of orders never actually reach "delivered." It points to something worth someone looking into on the fulfillment side.

I also checked whether products with higher unit prices tend to get ordered in smaller quantities, or whether that's unrelated. The relationship between those two came back close to zero, meaning customers don't really change how much they buy based on price point, which is worth knowing if anyone's planning pricing strategy around assumed customer behavior.

## One honest caveat

Anywhere I found two things moving together, like a referral source tied to higher order values, I didn't assume one caused the other. There could easily be something else underneath it, like that channel simply attracting a different mix of products. I've noted this directly next to any finding where it applies, rather than overstating what the data can actually prove.

## Conclusion

This dataset holds up under scrutiny. 13 of 14 columns came back fully complete, and order totals matched quantity × price without a single mismatch across 1,200 orders.

What it points to: revenue is carried by a smaller number of large orders, so the average order value overstates what a typical customer actually spends, the median tells the truer story. Discounting has moved from occasional to close to default, with roughly 3 in 4 orders using a code. And the clearest issue in the data isn't a statistical one at all, it's operational: a large share of orders never make it to "delivered," which suggests something in the fulfillment process needs attention before anything else gets optimized. Pricing decisions, meanwhile, shouldn't lean on the assumption that customers buy less as prices rise, this data doesn't back that up.

Taken together, the numbers don't just describe what happened, they point to where to look next. The fulfillment gap is the one finding here that moves to "worth acting on."
