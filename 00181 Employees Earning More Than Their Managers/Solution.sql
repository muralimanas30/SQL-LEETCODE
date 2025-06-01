# METHDOD 1
select e1.name as Employee from employee e1
join employee e2 on e1.managerId = e2.id
where e1.salary>e2.salary;

#METHOD 2
-- select E.name as Employee from Employee as E
-- where E.managerId is not null
-- and E.Salary > (
--     Select Salary from Employee E2
--     where E2.id = E.managerID
-- )