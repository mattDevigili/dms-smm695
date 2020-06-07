**Week Two**

_This homework is not mandatory, and not marked. You can use it to test your 
understanding of the lecture_

1. Create a schema named homework 2 
2. Create a table with the following characteristics:

| column_name   | data_type | length/precision |
|---------------|-----------|------------------|
| id            | serial    |                  |
| name          | varchar   | 20               |
| department_id | int       |                  |
| phone_number  | varchar   | 20               |
| salary        | numeric   |                  |

3. Apply the following constraints:

| column        | constraints                                  |
|---------------|----------------------------------------------|
| id            | PRIMARY KEY                                  |
| name          | NOT NULL                                     |
| department_id | CHECK(department_id = 1 OR department_id =2) |
| phone_number  | UNIQUE                                       |
| salary        | NOT NULL                                     |

4. Insert the following observations:

| id | name     | department_id | phone_number | salary |
|----|----------|---------------|--------------|--------|
| 1  | John     | 2             | 690.623.6568 | 20000  |
| 2  | Leo      | 1             | 690.623.6708 | 80000  |
| 3  | Diana    | 1             | 690.623.0007 | 110000 |
| 4  | Paula    | 2             | 690.623.6500 | 35000  |
| 5  | Simon    | 2             | 690.623.9834 | 45000  |
| 6  | Jennifer | 2             |              | 18000  |

5. Calculate the average salary by department

 | department_id | avg_salary | 
 |---------------|------------|
 | 1             | 95000.00   |
 | 2             | 29500.00   |

6. Calculate the maximum salary by department

 | department_id | avg_salary |
 |---------------|------------|
 | 1             | 110000     |
 | 2             | 45000      |

7. Count the number of observations that contain the letter 'o' in the 'name' field

| count_o |
|---------|
| 3       |

8. Import location.csv and car.csv

9. Count the number of female observations with _`dob'_ between 1990 and 1992

| count |
|-------|
| 112   |

10. Select the two car models with the highest price for the last ten years

 | car_model | max    |
 |-----------|--------|
 | Caliber   | 999718 |
 | MKT       | 995884 |
