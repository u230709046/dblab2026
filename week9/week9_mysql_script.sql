use company;
DELIMITER $$
CREATE PROCEDURE SelectionCustomerByCountry(IN c varchar(45))
begin
	select * from Costumers
	where COUNTRY = c;
end $$
DELIMITER ;

set @country= "France";
select @country;
call SelectionCostumerByCountry(@country);
select @country;


DELIMITER $$

CREATE PROCEDURE GetOrderCountByShipper(IN shipper varchar(45), out count INT)
begin
	select count(OrderID) into count
    from orders 
    join shippers on orders.ShipperID = shippers.ShipperID
    where ShipperName = shipper;
end $$

DELIMITER ;    

select ShipperName from shippers;
set @order_cnt = 0;
select @order_cnt;
call GetOrderCountByShipper("United Package", @order_cnt);
select @order_cnt;

DELIMITER $$
CREATE procedure GetCustomerSalesOut(
IN inCustomerID INT,
out outName varchar(255),
out outSales float)

begin
	select CustomerName into outName
    from customers
    where CustomerID = inCustomerID;
    
    SELECT ifnull(SUM(p.Price * od.Quantity),0) into outSales
    from orders o
    join orderdetails od on o.OrderID = od.OrderID
    join Products p on p.ProductID = od.ProductID
    where o.CustomerID = inCustomerID;
 END $$
 DELIMITER ;
 
 CALL GetCustomerSalesOut(5 , @name , @sales); select @name , @sales;
 
 CALL GetCustomerSalesOut(2 , @name , @sales); select @name , @sales;
    
    
