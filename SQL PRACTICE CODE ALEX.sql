-- one shot sql practice 

use parks_and_recreation;

-- SELECT STATEMENT IN SQL 
SELECT * 
FROM parks_and_recreation.employee_demographics;
-- here semcolon tells end of this querry

-- selecting specific column 
select first_name,
birth_date, 
last_name,
age,
(age+10)+10 
from parks_and_recreation.employee_demographics;
-- calcualtion follows the rule of pemdas, paranthesis, exponent, multipy, divide, add, subtract
-- DISTINCT- unique values 
select gender 
from parks_and_recreation.employee_demographics; 

-- using distinct 
select distinct gender 
from parks_and_recreation.employee_demographics; 


-- using multiple columns aat a time with distint will be considerd togather as unique 

select distinct  first_name, gender 
from parks_and_recreation.employee_demographics; 


-- we can save this file by using save button in this terminal only;


-- WHERE CLAUSE _ FILTERNING OUR DATA 
select * 
from parks_and_recreation.employee_salary
where salary >= 50000
;
# here operator >=  is used 
-- more examples 
select * 
from parks_and_recreation.employee_demographics
where gender = 'female'
;

select * 
from parks_and_recreation.employee_demographics
where birth_date> '1985-01-01'
;


-- logical operators AND, OR, NOT, 
select * 
from parks_and_recreation.employee_demographics
where birth_date> '1985-01-01' AND gender='male'
;

-- or 
select * 
from parks_and_recreation.employee_demographics
where birth_date> '1985-01-01' or gender='male'
;
-- or not 
select * 
from parks_and_recreation.employee_demographics
where birth_date> '1985-01-01' or not gender='male'
;
 -- USING PEMDAS HERE IN OPERATORS
 select * 
from parks_and_recreation.employee_demographics
where (first_name = ' leslie' and age = 44) or age > 55
;

-- LIKE STAEMENT, FOR SPECIFIC PATTERNS 
-- % - anything 
-- _ specific value 
select * 
from parks_and_recreation.employee_demographics
where first_name like 'er%' # here er at the beginnig and then anything after that 

;

select * 
from parks_and_recreation.employee_demographics
where first_name like '%er%' # here anything comes before, anything comes after but er comes in to middle 
;
select * 
from parks_and_recreation.employee_demographics
where first_name like 'a%' # here a must comes at the beginning 
;
select * 
from parks_and_recreation.employee_demographics
where first_name like 'a__' #  starts with a and has two characters after no more no less
;
select * 
from parks_and_recreation.employee_demographics
where first_name like 'a___%' #  starats with a and then 3 characters and then anything 
;



-- GROUP BY AND ORDER BY
-- once you group those column you can run aggreagte functions on those rows 
select gender 
from parks_and_recreation.employee_demographics
group by gender 
;

-- mistakes 
select first_name
from parks_and_recreation.employee_demographics
group by gender 
; #here selected cloumn must be matching with group by column, if we are not performing aggregate functions on it 


-- using agg funtions 
select gender, avg(age)# here avg age is being calculated based on the grouped genders from age column 
from parks_and_recreation.employee_demographics
group by gender 
;

select occupation, salary
from parks_and_recreation.employee_salary
group by occupation, salary
;

select gender, avg(age), max(age), min(age), count(age)
from parks_and_recreation.employee_demographics
group by gender
;


-- order by - ascending or descending order 
# by default its ascending order
select*
from parks_and_recreation.employee_demographics
order by first_name asc
;
select*
from parks_and_recreation.employee_demographics
order by first_name desc
;

select*
from parks_and_recreation.employee_demographics
order by gender, age desc # here first gender will be ordered first. so placing matters 
;
 -- here we can use column positions 
 

select*
from parks_and_recreation.employee_demographics
order by 5,4
;

-- HAVING VS WHERE 
select gender, avg(age) # here avg is only performed after the group by, so here where action cant be performed without avg implementaion, and will show error
# here Having comes into the role 
from parks_and_recreation.employee_demographics
where avg(age)>40
group by gender
;

select gender, avg(age)
from parks_and_recreation.employee_demographics
group by gender
having avg ( age) >40
;

-- USING BOTH IN ONE QUERRY 
select occupation, avg(salary)
from parks_and_recreation.employee_salary
where occcupation like '%manager%' # row level filteration 
group by occupation
having avg(salary)> 750000 # agg funtion level filteration 
;

-- LIMITS AND ALIASING 
select * 
from parks_and_recreation.employee_demographics
order by age desc
limit 2,1;  # here sorting is from oldest sequnce, starting with 2nd and 1 after that.

-- aliasing, a way to change the name of column , and also be used in joins 
select gender, avg(age) as avg_age
from parks_and_recreation.employee_demographics
group by gender
having avg_age> 40;
-- it can be used as too
select gender, avg(age)  avg_age
from parks_and_recreation.employee_demographics
group by gender
having avg_age> 40;

-- JOINS- aloows to combine two tables or more if they have common column data in it 
-- INNER JOIN- returns rows that are the same in both column from both the columns 
select *
 from parks_and_recreation.employee_demographics
 ;
 
 select *
 from parks_and_recreation.employee_salary
 ;

 select *
 from parks_and_recreation.employee_demographics as dem # first table/ left table
 inner join parks_and_recreation.employee_salary as sal # second table/ right table
    on dem.employee_id = sal.employee_id  # here dem.employee_id indicates which table to pick to reamove ambiguity( confusion ) of picking table column 
    ;
    # if some valuse is missing in the left table it will not be poulated or print in the final result.
    
    
     -- selecting the actual columns 
      select dem.employee_id, age, occupation # here dem.employee_id tells that select from the demographics table to stop ambiguity
 from parks_and_recreation.employee_demographics as dem # first table/ left table
 inner join parks_and_recreation.employee_salary as sal # second table/ right table
    on dem.employee_id = sal.employee_id  
    ;
    
    -- OUTER JOIN 1. LEFT JOIN/LEFT OUTER JOIN, 2. RIGHT JOIN/ RIGHT OUTER JOIN 
    -- LEFT JOIN- TAKES EVERYTHING FROM LEFT AND COMMON WITH RIGHT JOIN AND VICE VERSA. 
select *
     from parks_and_recreation.employee_demographics as dem
         RIGHT  join parks_and_recreation.employee_salary as sal
         on dem.employee_id = sal.employee_id  
    ;
    -- SELF JOIN 
    SELECT * 
    FROM parks_and_recreation.employee_salary as emp1
    join parks_and_recreation.employee_salary as emp2 
        on emp1.employee_id = emp2.employee_id
    
    ;
    # one one match 
    
    
        SELECT *
    FROM parks_and_recreation.employee_salary as emp1
    join parks_and_recreation.employee_salary as emp2 
        on emp1.employee_id +1 = emp2.employee_id
    
    ;
    
    
-- joining multiple tables togather 
 select *
 from parks_and_recreation.employee_demographics as dem 
 inner join parks_and_recreation.employee_salary as sal 
    on dem.employee_id = sal.employee_id   
    ;
    
select *
 from parks_and_recreation.employee_demographics as dem 
 inner join parks_and_recreation.employee_salary as sal 
    on dem.employee_id = sal.employee_id   
    inner join parks_departments as pd
    on sal.dept_id= pd.department_id
    ;
    
    select * 
    from parks_and_recreation;
    
    -- UNIONS - unions allows to combine rows togather, 
  
  select age, gender 
  from parks_and_recreation.employee_demographics
  union 
  select first_name, last_name
  from parks_and_recreation.employee_salary
  ;
# here data types is not same wo lets recombine again 
# by default union is itself distinct ie 

 select age, gender 
  from parks_and_recreation.employee_demographics
  union distinct
  select first_name, last_name
  from parks_and_recreation.employee_salary
  ;
  -- without distinct 
  
 select age, gender 
  from parks_and_recreation.employee_demographics
  union all 
  select first_name, last_name
  from parks_and_recreation.employee_salary
  ;

 select first_name, last_name,  'old man ' as label # here old is labeling 
  from parks_and_recreation.employee_demographics
  where age > 40 and gender = 'male'
  union 
   select first_name, last_name,  'old lady' as label # here old is labeling 
  from parks_and_recreation.employee_demographics
  where age > 40 and gender = 'female'
  union 
   select first_name, last_name,  'highly paid employee' as label 
  from parks_and_recreation.employee_salary # salary is different table
  where salary >70000
  order by first_name, last_name
  ;
 
 
 -- string funtions- built in funtions which helps to use strings 
 -- 
# length()
select 
first_name, length(first_name)
from parks_and_recreation.employee_demographics
order by 2
;
# upper()
select upper('sky');
select lower('SKY');

SELECT first_name, upper(first_name)
from employee_demographics;

-- TRIMM- TAKING WHITE SPACES 
SELECT trim('    sky    ');
SELECT ltrim('    sky    ');
SELECT rtrim('    sky    ');

-- SUBSTRINGS 
select first_name, 
left(first_name, 4),#  here 4 means how many charaters from left do we want to select 
right(first_name, 4),
substring(first_name,3,2)# starats from 3rd position and then 2 charaters from there
birth_date,
substring(birth_date, 6, 2) as birth_month
from parks_and_recreation.employee_demographics
;
-- REPLACE- replace a specific charater with a specific character 
select first_name, replace(first_name, 'a', 'z')
from parks_and_recreation.employee_demographics
;
-- LOCATE - 
select locate('x', 'alexander');
select first_name, locate('an', first_name)
from parks_and_recreation.employee_demographics
;
-- concatination
select first_name, last_name,
concat(first_name, ' ', last_name) as full_name
from parks_and_recreation.employee_demographics
;

-- CASE STATEMENTS- allow to add logic in your select statement 
select first_name,
last_name,
age,
case
when age<= 30 then 'young'
when age between 31 and 50 then 'old'
when age>= 50 then 'on deaths door'
end as age_bracket
from parks_and_recreation.employee_demographics
;


-- pay increase and bonus
-- < 50000 = 5% 
-- > 50000 = 7% 
-- finance = 10% 

select first_name, last_name, salary,
case 
	 when salary <50000 then salary + (salary*0.05)
     when salary >50000 then salary*1.07
     # now challenge is that department is in different table so use another case statements 
     
  end as new_salary,
  case 
  when dept_id = 6 then salary*.10
  end as bonus
from parks_and_recreation.employee_salary
;


-- SUBQUERIES - A QUERY WITH IN ANOTHER QUERY 
 
 SELECT *
FROM parks_and_recreation.employee_demographics
WHERE employee_id IN (
    SELECT employee_id # here only one operand can run.
    FROM parks_and_recreation.employee_salary 
    WHERE dept_id = 1
);


 
-- using subquerry in select statement
select first_name, salary, avg(salary)
from parks_and_recreation.employee_salary
 group by first_name, salary
;

# but we want avg of entire column 
select first_name, salary, 
                       ( select avg(salary)
                       from parks_and_recreation.employee_salary
                                                               )
from parks_and_recreation.employee_salary
;
 
 -- using subquerry using from statement 
 select gender, avg(age), max(age), min(age), count(age)
 from parks_and_recreation.employee_demographics
 group by gender
 ;
select gender, avg(`max(age)`)# use backtick or alias 
from ( select gender, avg(age), max(age), min(age), count(age)
     from parks_and_recreation.employee_demographics
      group by gender )as agg_table
      group by gender
 ;
 
 select gender, avg(avg_age)# use backtick or alias 
from ( select gender, 
       avg(age) as avg_age, 
       max(age) as max_age,
       min(age) as min_age, 
       count(age) as count
     from parks_and_recreation.employee_demographics
      group by gender )as agg_table
      group by gender
 ;
 
 -- WINDOW FUNTIONS- allow us to look a partition or a group by the each keep thier own uniwue rows in the output, 
 select gender,avg(salary) as avg_salary
 from parks_and_recreation.employee_demographics dem
 join parks_and_recreation.employee_salary as sal
  on dem.employee_id = sal.employee_id
  group by gender
 ;
 
 select gender,avg(salary) over( partition by gender) 
 from parks_and_recreation.employee_demographics dem
 join parks_and_recreation.employee_salary as sal
  on dem.employee_id = sal.employee_id
  
 ;
 # aprtition by is kind of group which aprtition category for their own indivisual rows, which doesnt affect the existing column calculation of avg, and independent from other operations 
 
 
 select dem.first_name, dem.last_name, gender,avg(salary) over( partition by gender) 
 from parks_and_recreation.employee_demographics dem
 join parks_and_recreation.employee_salary as sal
  on dem.employee_id = sal.employee_id
  
 ;
 
  select dem.first_name, 
  dem.last_name, gender,
  sum(salary) over(partition by gender order by dem.employee_id) as rolling_total # here the sum is rolling toatal adding to the existing total
 from parks_and_recreation.employee_demographics dem
 join parks_and_recreation.employee_salary as sal
  on dem.employee_id = sal.employee_id
  
 ;

