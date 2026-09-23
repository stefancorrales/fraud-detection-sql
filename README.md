# Credit Card Fraud Detection — SQL Analysis

## Overview
SQL analysis of 284,807 credit card transactions to identify fraud patterns.
Built on PostgreSQL using window functions, conditional aggregation, and 
temporal analysis to surface actionable insights for fraud prevention teams.

## Dataset
- **Source:** [Kaggle — Credit Card Fraud Detection](https://www.kaggle.com/datasets/mlg-ulb/creditcardfraud)
- **Records:** 284,807 transactions
- **Fraud cases:** 492 (0.17%)
- **Features:** 28 anonymized PCA components + Amount + Time

## Key Insights

1. **Highly imbalanced dataset** — only 0.17% of transactions are fraud.
   A naive model predicting "all legitimate" would be 99.83% accurate but
   useless. Recall and F1-score are the correct metrics here.

2. **Fraudsters spend 38% more per transaction** — avg fraud amount $122.21
   vs $88.29 for legitimate transactions. However, max fraud ($2,125) is far
   below max legitimate ($25,691) — fraudsters avoid large amounts to evade
   automatic alerts.

3. **Card testing pattern detected** — transactions under $10 have a
   0.26% fraud rate, the 3rd highest. This is a classic card testing
   behavior where fraudsters make small purchases to verify a stolen card
   before making larger transactions.

4. **2 AM is peak fraud hour** — fraud rate at 2 AM is 1.332%, nearly
   8x the dataset average. Hours 3-5 AM also show elevated fraud rates.
   Fraudsters operate at night when cardholders are asleep and monitoring
   is reduced.

## SQL Techniques Used
- Window functions (`SUM() OVER()`)
- Conditional aggregation (`CASE WHEN`)
- Temporal analysis (`FLOOR`, time conversion)
- Percentage calculations
- Range bucketing

## Files
| File | Description |
|------|-------------|
| `schema.sql` | PostgreSQL table definition |
| `fraud_analysis_queries.sql` | All analysis queries with comments |

## How to Reproduce
1. Download dataset from Kaggle link above
2. Run `schema.sql` to create the table
3. Import `creditcard.csv` into PostgreSQL
4. Run `fraud_analysis_queries.sql` to reproduce all insights

## Skills Demonstrated
`SQL` `PostgreSQL` `Window Functions` `Fraud Analysis` `Data Analytics` `Pattern Detection`
