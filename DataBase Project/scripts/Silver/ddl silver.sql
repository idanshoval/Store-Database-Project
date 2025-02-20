USE Shop
GO

if OBJECT_ID('SILVER.Store_Products', 'U') IS NOT NULL
    DROP TABLE SILVER.Store_Products;
GO

CREATE TABLE SILVER.Store_Products (
    id                 int primary key,
    title              NVARCHAR(70),
    category           NVARCHAR(60),
    description        NVARCHAR(max),
    price              FLOAT CHECK(price>0),
	inserted_date       DATE DEFAULT GETDATE() 
);
GO

-- User Table:

if OBJECT_ID('SILVER.Store_Users', 'U') IS NOT NULL
    DROP TABLE SILVER.Store_Users;
GO
  

CREATE TABLE SILVER.Store_Users (
    userid                 int primary key,
    firstname              NVARCHAR(40),
    lastname               NVARCHAR(40),
    email                  NVARCHAR(255) UNIQUE,
    price                  FLOAT CHECK(price>0),
	city                   NVARCHAR(50),
	continent              NVARCHAR(50),
	country                NVARCHAR(50),
	inserted_date          DATE DEFAULT GETDATE() 
);
GO


-- Cart Table:

if OBJECT_ID('SILVER.Store_Cart_Sales', 'U') IS NOT NULL
    DROP TABLE SILVER.Store_Cart_Sales;
GO
  

CREATE TABLE SILVER.Store_Cart_Sales (
    cart_id                 int ,
	userid                  int,
	purchase_date           date,
    item                    int,
	quantity                int CHECK(quantity>=0),
    inserted_date           DATE DEFAULT GETDATE(),

	CONSTRAINT PK_Store_Cart_Sales PRIMARY KEY (cart_id, userid,item),

	CONSTRAINT FK_Sales_Customer FOREIGN KEY (userid) REFERENCES SILVER.Store_Users(userid),

	CONSTRAINT FK_Sales_Product FOREIGN KEY (item) REFERENCES SILVER.Store_Products(id),
);
GO



