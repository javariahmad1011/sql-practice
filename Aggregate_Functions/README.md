# Aggregate Functions for Reconciliation

## Overview

Aggregations are used to validate dashboard KPIs, batch totals, payroll summaries, counts, and grouped business rules.

## Concepts Covered

- COUNT
- SUM
- AVG
- MIN/MAX
- GROUP BY
- HAVING

## Learning Objectives

- Reconcile UI totals to source records
- Validate monetary batch totals
- Compare averages by business segment
- Check range boundaries
- Find groups that violate expected cardinality

## Example Queries

```sql
SELECT status, COUNT(*) AS order_count, SUM(total_amount) AS total_value
FROM orders
GROUP BY status
ORDER BY status;
```

## Best Practices

- Validate the filtered population before trusting an aggregate.
- Use DECIMAL/NUMERIC for currency.
- Be aware that most aggregate functions ignore NULL values.
- Use HAVING for conditions on aggregate results, not WHERE.
