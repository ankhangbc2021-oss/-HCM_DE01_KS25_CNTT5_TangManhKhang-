CREATE DATABASE SalesManagement;

USE SalesManagement;

CREATE TABLE Product (
	ProductID CHAR(10) PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Manufacturer VARCHAR(50) NOT NULL,
    Price DECIMAL(18 ,2) NOT NULL,
    quantity INT NOT NULL 
);

CREATE TABLE Customer ( 
	CustomerID CHAR(10) PRIMARY KEY,
    Fullname VARCHAR(155) NOT NULL,
    Email VARCHAR(150) NOT NULL,
    Phone CHAR(15),
    Address VARCHAR(100) NOT NULL 
);

CREATE TABLE OrderP (
	OrderP_ID CHAR(10) PRIMARY KEY,
    Order_date DATE DEFAULT (CURRENT_DATE),
    Total DECIMAL(18, 2) NOT NULL, 
    CustomerID CHAR(10) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE Order_Detail (
	OrderID CHAR(10),
    ProductID CHAR(10),
    Quantity INT NOT NULL,
    SalePrice DECIMAL(15,2) NOT NULL,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES OrderP(OrderP_ID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Thêm cột Ghi chú (kiểu văn bản) vào bảng Order.
ALTER TABLE OrderP ADD COLUMN Note TEXT;

-- Đổi tên cột Hãng sản xuất thành Nha San Xuat.
ALTER TABLE PRODUCT CHANGE  Manufacturer SupplierName VARCHAR(50);

--  Viết câu lệnh xóa bảng Order_Detail và bảng Order.
DROP TABLE Order_Detail;
DROP TABLE OrderP;

-- Thêm ít nhất 5 bản ghi cho mỗi bảng 
INSERT INTO Product VALUES
	('P001','MacBook Air M2','Apple',20000000,10),
	('P002','MacBook Pro M3','Apple',35000000,5),
	('P003','ThinkPad X1 Carbon','Lenovo',25000000,8),
	('P004','Inspiron 15','Dell',15000000,12),
	('P005','VivoBook 14','Asus',12000000,15);

INSERT INTO Customer VALUES
	('C001','Nguyen Van A','a@gmail.com','0909123456','Ho Chi Minh City'),
	('C002','Tran Thi B','b@gmail.com',NULL,'Hanoi'),
	('C003','Le Van C','c@gmail.com','0912345678','Da Nang'),
	('C004','Pham Thi D','d@gmail.com','0987654321','Hue'),
	('C005','Hoang Van E','e@gmail.com','0909988776','Ho Chi Minh City');

INSERT INTO OrderP VALUES
	('DH001','2026-04-20',40000000,'C001'),
	('DH002','2026-04-21',15000000,'C003'),
	('DH003','2026-04-22',35000000,'C004'),
	('DH004','2026-04-23',20000000,'C005'),
	('DH005','2026-04-24',12000000,'C001');

INSERT INTO Order_Detail VALUES
	('DH001','P001',1,20000000),
	('DH001','P004',1,15000000),
	('DH001','P005',1,5000000),
	('DH002','P003',1,15000000),
	('DH003','P002',1,35000000);
    
-- Tăng giá bán thêm 10% cho tất cả sản phẩm của hãng 'Apple'
UPDATE Product 
SET Price = Price * 1.1 
WHERE Manufacturer = 'Apple';

-- Xóa thông tin những khách hàng chưa để lại số điện thoại (SĐT là NULL).
DELETE FROM Customer 
WHERE Phone IS NULL;

-- Tìm tất cả sản phẩm có đơn giá nằm trong khoảng từ 10 triệu đến 20 triệu.
SELECT * 
FROM Product 
WHERE Price BETWEEN 10000000 AND 20000000;

-- Liệt kê danh sách Tên sản phẩm đã được bán trong đơn hàng có mã là 'DH001'
SELECT ProductName
FROM Product 
JOIN Order_Detail ON Product.ProductID = Order_Detail.ProductID
WHERE Order_Detail.OrderID = 'DH001';

-- Tìm thông tin những khách hàng đã mua sản phẩm có tên là 'MacBook Air M2'.
SELECT Customer.*
FROM Customer  
JOIN OrderP ON Customer.CustomerID = OrderP.CustomerID
JOIN Order_Detail ON OrderP.OrderP_ID = Order_Detail.OrderID
JOIN Product ON Product.ProductID = Order_Detail.ProductID
WHERE Product.ProductName = 'MacBook Air M2';