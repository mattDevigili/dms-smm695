# Week 1 -- Homework

_This homework is not mandatory, and not marked. You can use it to test your
understanding of the lecture_.

**1).** Create a new Database named smm695
**2).** Create a new Schema named homework1
**3).** Create a new Table with the following characteristics:

| column_name | data_type | length/precision |
|-------------|-----------|------------------|
| id          | serial    |                  |
| first_name  | varchar   | 20               |
| last_name   | varchar   | 20               |
| email       | varchar   | 80               |
| salary      | numeric   |                  |

**4).** Insert the following values:

| id | first_name | last_name | email                 | salary |
|----|------------|-----------|-----------------------|--------|
| 1  | Dave       | Alstom    | <davealstom@google.com> | 50000  |
| 2  | Hunter     | Reese     | <reese1998@hotmail.nl>  | 37000  |
| 3  | Kerys      | Mcclure   | <mcclure@gmail.com>     | 28000  |

**5).** Create a table that could contain the following values:

| id | country        | postal_code | date_of_birth |
|----|----------------|-------------|---------------|
| 1  | Italy          | 04929       | 1995-06-18    |
| 2  | United Kingdom | E2 9AD      | 1980-05-13    |
| 3  | China          | 100023      | 1994-09-12    |

**6).** Join the information of Table A and Table B:

You may use the following structure to set up your SQL query.

```sql
SELECT * FROM * JOIN * ON *
```
