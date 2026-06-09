create database if not exists company_info ; 
use company_info ; 

create table books (
Book_ID int primary key , 
Title varchar(100) ,
Author varchar(100) , 
Genre varchar(50) ,
Published_Year int ,
Price decimal (10,2) ,  
Stock int 
) ; 

create table customers (
Customer_ID int primary key , 
Name varchar(100) , 
Email varchar(100) , 
Phone varchar (100) , 
City varchar(150) , 
country varchar(150) 

) ; 

create table orders (
Order_ID int primary key , 
Customer_ID int references Customers(Customer_ID) , 
Book_ID int references Books(BOOK_ID) ,
Order_DATE date , 
Quantity int ,
Total_Amount decimal (10,2) 
) ; 

-- Question: How can a new Price column be added to the Books table?
ALTER TABLE books ADD Price DECIMAL(10,2);

-- Question: How can all records be removed from the Books table while keeping the table structure intact?
TRUNCATE TABLE books ;

-- Question: What are all the records available in the Orders table , customer table , order table ?
select * from orders ; 
select * from books ; 
select * from customers ; 

-- Question: Which books belong to the Fiction genre?
select * from books where Genre = "fiction" ; 

-- Question: Which books were published after 1950?
select * from books where Published_Year  > 1950 ; 

-- Question: Which customers are located in Canada?
select * from customers where country = "canada" ;

-- Question: Which orders were placed during November 2023?
select * from orders  where Order_DATE between '2023-11-01' and '2023-11-30'   ;

-- Question: Which orders were placed during November 2023?
select  sum(Stock) as total_stock from books ;  

-- Question: What is the highest-priced book available in the store?
select  MAX(Price) as expensive_book   from books ;

-- Question: Which book is the most expensive?
select * from books order by Price  desc limit 1 ;

-- Question: Which orders contain more than one book?
select *  from orders where Quantity > 1 order by Quantity asc ; 

-- Question: Which orders have a total amount greater than 20?
select * from orders where Total_amount > 20 ; 

-- Question: What genres are available in the books table?
select Genre from books ;

-- Question: What are the unique book genres available in the store?
select distinct Genre from books ; 

-- Question: Which customers placed orders with a quantity greater than 1?
select orders.Quantity , customers.Customer_ID , customers.Name 
from customers 
join orders 
on orders.Order_ID = customers.Customer_ID where Quantity > 1 ; 

-- Question: Which book has the lowest stock available?
select * from books  order by stock limit 1 ; 

-- Question: What is the total revenue generated from all orders?
select sum(Total_Amount) as Revenue  from orders ; 

-- Question: How many books are available in stock for each genre?
select  Genre , sum(Stock) as total_books  from books group by Genre ;

-- Question: What is the total quantity of books sold in each genre?
select books.Genre ,  sum(orders.Quantity ) as Total_Quantity 
from books 
join orders
on books.Book_ID = orders.Book_ID  
group by books.Genre ;

-- Question: What is the average price of Fantasy books?
select avg(Price) as avg_price from books where Genre = "Fantasy" ; 

-- Question: Which customers have placed at least two orders? 
select c.Customer_ID , count(o.Order_id )
from customers c
join orders o
on c.Customer_ID = o.Customer_ID 
group by c.Customer_ID , c.Name 
having count(Order_ID) >= 2 ; 

-- Question: Which book has received the highest number of orders?
select c.Book_ID , count(o.Order_ID ) as order_count
from books c
join orders o
on c.Book_ID = o.Book_ID 
group by c.Book_ID , c.Title 
order by count(Order_ID) desc limit 1  ; 

-- Question: What are the top 3 most expensive Fantasy books?
select * from books where Genre = "Fantasy" order by price desc limit 3 ; 

-- Question: How many books has each author sold?
select sum(o.Quantity) as Total_Quantity  , b.Author 
from books b 
join orders o
on b.Book_ID = o.Book_ID 
group by b.Author order by Author asc; 

-- Question: Which city placed the highest-value order above 100?
select o.Total_Amount  ,  c.City , o.Order_ID 
from orders o
join customers c 
on o.Customer_ID = c.Customer_ID 
where Total_Amount > 100 order by Total_Amount desc limit 1 ; 

-- Question: Which customer spent the most money on purchases?
select c.Name , o.Quantity , sum(o.Total_Amount)  as Total_spent 
from customers c
join orders o 
on c.Customer_ID = o.Customer_ID 
group by c.Name , o.Quantity 
order by Total_spent  desc limit 1 ; 

-- Question: What is the remaining stock for each book after fulfilling all orders?
select b.Book_ID , b.Title  , sum(o.Quantity) as Total_quantity , b.Stock - sum(o.Quantity) as Remaining_stock 
from books b
join orders o
on b.Book_ID = o.Book_ID 
group by b.Book_ID , b.Title 
order by b.Book_ID ; 


