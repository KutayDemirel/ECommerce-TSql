USE [master]
GO
/****** Object:  Database [LCWaikikiDb]    Script Date: 5.05.2022 16:57:10 ******/
CREATE DATABASE [LCWaikikiDb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'LCWaikikiDb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\LCWaikikiDb.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'LCWaikikiDb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\LCWaikikiDb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [LCWaikikiDb] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [LCWaikikiDb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [LCWaikikiDb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [LCWaikikiDb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [LCWaikikiDb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [LCWaikikiDb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [LCWaikikiDb] SET ARITHABORT OFF 
GO
ALTER DATABASE [LCWaikikiDb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [LCWaikikiDb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [LCWaikikiDb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [LCWaikikiDb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [LCWaikikiDb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [LCWaikikiDb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [LCWaikikiDb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [LCWaikikiDb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [LCWaikikiDb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [LCWaikikiDb] SET  DISABLE_BROKER 
GO
ALTER DATABASE [LCWaikikiDb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [LCWaikikiDb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [LCWaikikiDb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [LCWaikikiDb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [LCWaikikiDb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [LCWaikikiDb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [LCWaikikiDb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [LCWaikikiDb] SET RECOVERY FULL 
GO
ALTER DATABASE [LCWaikikiDb] SET  MULTI_USER 
GO
ALTER DATABASE [LCWaikikiDb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [LCWaikikiDb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [LCWaikikiDb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [LCWaikikiDb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [LCWaikikiDb] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [LCWaikikiDb] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'LCWaikikiDb', N'ON'
GO
ALTER DATABASE [LCWaikikiDb] SET QUERY_STORE = OFF
GO
USE [LCWaikikiDb]
GO
/****** Object:  Table [dbo].[Order_ProductLog]    Script Date: 5.05.2022 16:57:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order_ProductLog](
	[Id] [int] NOT NULL,
	[OrderId] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[Barcode] [varchar](7) NOT NULL,
	[CreationDate] [datetime2](7) NOT NULL,
	[ModificationDate] [datetime2](7) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Index [ix_Order_ProductLog]    Script Date: 5.05.2022 16:57:10 ******/
CREATE CLUSTERED INDEX [ix_Order_ProductLog] ON [dbo].[Order_ProductLog]
(
	[ModificationDate] ASC,
	[CreationDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order_Product]    Script Date: 5.05.2022 16:57:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order_Product](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[Barcode] [varchar](7) NOT NULL,
	[CreationDate] [datetime2](7) GENERATED ALWAYS AS ROW START NOT NULL
	DEFAULT CAST('2022-05-04 00:00:00.0000000' AS DATETIME2),
	[ModificationDate] [datetime2](7) GENERATED ALWAYS AS ROW END NOT NULL
	DEFAULT CAST('9999-12-31 23:59:59.9999999' AS DATETIME2),
 CONSTRAINT [PK_Order_Product] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([CreationDate], [ModificationDate])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [dbo].[Order_ProductLog] )
)
GO
/****** Object:  Table [dbo].[ProductLog]    Script Date: 5.05.2022 16:57:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductLog](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[ParentId] [int] NOT NULL,
	[Price] [money] NULL,
	[CreationDate] [datetime2](7) NOT NULL,
	[ModificationDate] [datetime2](7) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Index [ix_ProductLog]    Script Date: 5.05.2022 16:57:10 ******/
CREATE CLUSTERED INDEX [ix_ProductLog] ON [dbo].[ProductLog]
(
	[ModificationDate] ASC,
	[CreationDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 5.05.2022 16:57:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[ParentId] [int] NOT NULL,
	[Price] [money] NULL,
	[CreationDate] [datetime2](7) GENERATED ALWAYS AS ROW START NOT NULL
	DEFAULT CAST('2022-05-04 00:00:00.0000000' AS DATETIME2),
	[ModificationDate] [datetime2](7) GENERATED ALWAYS AS ROW END NOT NULL
	DEFAULT CAST('9999-12-31 23:59:59.9999999' AS DATETIME2),
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([CreationDate], [ModificationDate])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [dbo].[ProductLog] )
)
GO
/****** Object:  View [dbo].[TotalAmount]    Script Date: 5.05.2022 16:57:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[TotalAmount] 
As 
select op.OrderId, Sum(p.Price * op.Quantity) OrderPrice
from Order_Product op
inner join product p on p.Id = op.ProductId
GROUP BY OrderId
GO
/****** Object:  Table [dbo].[Order_DetailLog]    Script Date: 5.05.2022 16:57:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order_DetailLog](
	[Id] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[Total] [money] NULL,
	[CreationDate] [datetime2](7) NOT NULL,
	[ModificationDate] [datetime2](7) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Index [ix_Order_DetailLog]    Script Date: 5.05.2022 16:57:10 ******/
CREATE CLUSTERED INDEX [ix_Order_DetailLog] ON [dbo].[Order_DetailLog]
(
	[ModificationDate] ASC,
	[CreationDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order_Detail]    Script Date: 5.05.2022 16:57:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order_Detail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[Total] [money] NULL,
	[CreationDate] [datetime2](7) GENERATED ALWAYS AS ROW START NOT NULL
	DEFAULT CAST('2022-05-04 00:00:00.0000000' AS DATETIME2),
	[ModificationDate] [datetime2](7) GENERATED ALWAYS AS ROW END NOT NULL
	DEFAULT CAST('9999-12-31 23:59:59.9999999' AS DATETIME2),
 CONSTRAINT [PK_Order_Detail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([CreationDate], [ModificationDate])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [dbo].[Order_DetailLog] )
)
GO
/****** Object:  Table [dbo].[Payment_DetailsLog]    Script Date: 5.05.2022 16:57:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payment_DetailsLog](
	[Id] [int] NOT NULL,
	[OrderId] [int] NOT NULL,
	[Provider] [nvarchar](max) NOT NULL,
	[Status] [nvarchar](max) NOT NULL,
	[Amount] [int] NULL,
	[CreationDate] [datetime2](7) NOT NULL,
	[ModificationDate] [datetime2](7) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Index [ix_Payment_DetailsLog]    Script Date: 5.05.2022 16:57:10 ******/
CREATE CLUSTERED INDEX [ix_Payment_DetailsLog] ON [dbo].[Payment_DetailsLog]
(
	[ModificationDate] ASC,
	[CreationDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payment_Details]    Script Date: 5.05.2022 16:57:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payment_Details](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NOT NULL,
	[Provider] [nvarchar](max) NOT NULL,
	[Status] [nvarchar](max) NOT NULL,
	[Amount] [int] NULL,
	[CreationDate] [datetime2](7) GENERATED ALWAYS AS ROW START NOT NULL
	DEFAULT CAST('2022-05-04 00:00:00.0000000' AS DATETIME2),
	[ModificationDate] [datetime2](7) GENERATED ALWAYS AS ROW END NOT NULL
	DEFAULT CAST('9999-12-31 23:59:59.9999999' AS DATETIME2),
 CONSTRAINT [PK_Payment_Details] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([CreationDate], [ModificationDate])
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [dbo].[Payment_DetailsLog] )
)
GO
/****** Object:  Table [dbo].[Product_DetailLog]    Script Date: 5.05.2022 16:57:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product_DetailLog](
	[Barcode] [varchar](7) NOT NULL,
	[Id] [int] NOT NULL,
	[Color] [nvarchar](40) NULL,
	[Material] [nvarchar](40) NULL,
	[Size] [nvarchar](40) NULL,
	[Pattern] [varchar](40) NULL,
	[AgeGroup] [varchar](40) NULL,
	[ProductId] [int] NULL,
	[CreationDate] [datetime2](7) NOT NULL,
	[ModificationDate] [datetime2](7) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Index [ix_Product_DetailLog]    Script Date: 5.05.2022 16:57:10 ******/
CREATE CLUSTERED INDEX [ix_Product_DetailLog] ON [dbo].[Product_DetailLog]
(
	[ModificationDate] ASC,
	[CreationDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product_Detail]    Script Date: 5.05.2022 16:57:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product_Detail](
	[Barcode]  AS ('BCD'+right('0000'+CONVERT([varchar](4),[Id]),(4))) PERSISTED NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Color] [nvarchar](40) NULL,
	[Material] [nvarchar](40) NULL,
	[Size] [nvarchar](40) NULL,
	[Pattern] [varchar](40) NULL,
	[AgeGroup] [varchar](40) NULL,
	[ProductId] [int] NULL,
	[CreationDate] [datetime2](7) GENERATED ALWAYS AS ROW START NOT NULL
	DEFAULT CAST('2022-05-04 00:00:00.0000000' AS DATETIME2),
	[ModificationDate] [datetime2](7) GENERATED ALWAYS AS ROW END NOT NULL
	DEFAULT CAST('9999-12-31 23:59:59.9999999' AS DATETIME2),
 CONSTRAINT [PK_Product_Detail] PRIMARY KEY CLUSTERED 
(
	[Barcode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([CreationDate], [ModificationDate])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [dbo].[Product_DetailLog] )
)
GO
/****** Object:  Table [dbo].[Product_StockLog]    Script Date: 5.05.2022 16:57:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product_StockLog](
	[Id] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[CreationDate] [datetime2](7) NOT NULL,
	[ModificationDate] [datetime2](7) NOT NULL,
	[Barcode] [varchar](7) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Index [ix_Product_StockLog]    Script Date: 5.05.2022 16:57:10 ******/
CREATE CLUSTERED INDEX [ix_Product_StockLog] ON [dbo].[Product_StockLog]
(
	[ModificationDate] ASC,
	[CreationDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product_Stock]    Script Date: 5.05.2022 16:57:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product_Stock](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Quantity] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[CreationDate] [datetime2](7) GENERATED ALWAYS AS ROW START NOT NULL
	DEFAULT CAST('2022-05-04 00:00:00.0000000' AS DATETIME2),
	[ModificationDate] [datetime2](7) GENERATED ALWAYS AS ROW END NOT NULL
	DEFAULT CAST('9999-12-31 23:59:59.9999999' AS DATETIME2),
	[Barcode] [varchar](7) NOT NULL,
 CONSTRAINT [PK_Product_Stock] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([CreationDate], [ModificationDate])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [dbo].[Product_StockLog] )
)
GO
/****** Object:  Table [dbo].[User_PaymentLog]    Script Date: 5.05.2022 16:57:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User_PaymentLog](
	[Id] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[Payment_Type] [nvarchar](50) NOT NULL,
	[Account_No] [int] NOT NULL,
	[Expiry] [date] NOT NULL,
	[CreationDate] [datetime2](7) NOT NULL,
	[ModificationDate] [datetime2](7) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Index [ix_User_PaymentLog]    Script Date: 5.05.2022 16:57:10 ******/
CREATE CLUSTERED INDEX [ix_User_PaymentLog] ON [dbo].[User_PaymentLog]
(
	[ModificationDate] ASC,
	[CreationDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User_Payment]    Script Date: 5.05.2022 16:57:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User_Payment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[Payment_Type] [nvarchar](50) NOT NULL,
	[Account_No] [int] NOT NULL,
	[Expiry] [date] NOT NULL,
	[CreationDate] [datetime2](7) GENERATED ALWAYS AS ROW START NOT NULL
	DEFAULT CAST('2022-05-04 00:00:00.0000000' AS DATETIME2),
	[ModificationDate] [datetime2](7) GENERATED ALWAYS AS ROW END NOT NULL
	DEFAULT CAST('9999-12-31 23:59:59.9999999' AS DATETIME2),
 CONSTRAINT [PK_User_Payment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([CreationDate], [ModificationDate])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [dbo].[User_PaymentLog] )
)
GO
/****** Object:  Table [dbo].[UserLog]    Script Date: 5.05.2022 16:57:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserLog](
	[Id] [int] NOT NULL,
	[Username] [nvarchar](15) NOT NULL,
	[Password] [text] NOT NULL,
	[First_Name] [nvarchar](50) NOT NULL,
	[Last_Name] [nvarchar](50) NOT NULL,
	[Adress] [nvarchar](max) NOT NULL,
	[Telephone] [char](11) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[City] [nvarchar](15) NOT NULL,
	[CreationDate] [datetime2](7) NOT NULL,
	[ModificationDate] [datetime2](7) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Index [ix_UserLog]    Script Date: 5.05.2022 16:57:10 ******/
CREATE CLUSTERED INDEX [ix_UserLog] ON [dbo].[UserLog]
(
	[ModificationDate] ASC,
	[CreationDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 5.05.2022 16:57:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](15) NOT NULL,
	[Password] [text] NOT NULL,
	[First_Name] [nvarchar](50) NOT NULL,
	[Last_Name] [nvarchar](50) NOT NULL,
	[Adress] [nvarchar](max) NOT NULL,
	[Telephone] [char](11) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[City] [nvarchar](15) NOT NULL,
	[CreationDate] [datetime2](7) GENERATED ALWAYS AS ROW START NOT NULL
	DEFAULT CAST('2022-05-04 00:00:00.0000000' AS DATETIME2),
	[ModificationDate] [datetime2](7) GENERATED ALWAYS AS ROW END NOT NULL
	DEFAULT CAST('9999-12-31 23:59:59.9999999' AS DATETIME2),
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([CreationDate], [ModificationDate])
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [dbo].[UserLog] )
)
GO
/****** Object:  View [dbo].[ProductTotalInfo]    Script Date: 5.05.2022 16:57:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ProductTotalInfo]
AS
SELECT [Name],ParentId,Price,pd.Barcode,Color,Material, 
Size,Pattern,AgeGroup,Quantity
FROM Product p
Left JOIN Product_Detail pd ON p.Id = pd.ProductId
Left JOIN Product_Stock ps ON pd.Barcode = ps.Barcode
GO
/****** Object:  View [dbo].[CustomerTotalPaymentInfo]    Script Date: 5.05.2022 16:57:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[CustomerTotalPaymentInfo]
AS
SELECT  CONCAT(First_Name,' ' , Last_Name) FullName,City,Payment_Type,Total
FROM [User] u
Inner JOIN (SELECT UserId,SUM(TOTAL) Total
FROM Order_Detail
GROUP BY UserId) od ON od.UserId = u.Id
Left JOIN User_Payment up ON u.Id = up.UserId
GO
/****** Object:  Table [dbo].[CategoryLog]    Script Date: 5.05.2022 16:57:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoryLog](
	[Id] [int] NOT NULL,
	[Title] [nvarchar](45) NOT NULL,
	[ParentId] [int] NULL,
	[CreationDate] [datetime2](7) NOT NULL,
	[ModificationDate] [datetime2](7) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Index [ix_CategoryLog]    Script Date: 5.05.2022 16:57:10 ******/
CREATE CLUSTERED INDEX [ix_CategoryLog] ON [dbo].[CategoryLog]
(
	[ModificationDate] ASC,
	[CreationDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 5.05.2022 16:57:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](45) NOT NULL,
	[ParentId] [int] NULL,
	[CreationDate] [datetime2](7) GENERATED ALWAYS AS ROW START NOT NULL
	DEFAULT CAST('2022-05-04 00:00:00.0000000' AS DATETIME2),
	[ModificationDate] [datetime2](7) GENERATED ALWAYS AS ROW END NOT NULL
	DEFAULT CAST('9999-12-31 23:59:59.9999999' AS DATETIME2),
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([CreationDate], [ModificationDate])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [dbo].[CategoryLog] )
)
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([Id], [Title], [ParentId], [CreationDate], [ModificationDate]) VALUES (1, N'Giyim', NULL, DEFAULT, DEFAULT)
INSERT [dbo].[Category] ([Id], [Title], [ParentId], [CreationDate], [ModificationDate]) VALUES (2, N'Aksesuar', NULL, DEFAULT,DEFAULT)
INSERT [dbo].[Category] ([Id], [Title], [ParentId], [CreationDate], [ModificationDate]) VALUES (3, N'Ayakkabı', NULL, DEFAULT,DEFAULT)
INSERT [dbo].[Category] ([Id], [Title], [ParentId], [CreationDate], [ModificationDate]) VALUES (4, N'Ev & Yaşam', NULL, DEFAULT,DEFAULT)
INSERT [dbo].[Category] ([Id], [Title], [ParentId], [CreationDate], [ModificationDate]) VALUES (5, N'Kozmetik', NULL, DEFAULT,DEFAULT)
INSERT [dbo].[Category] ([Id], [Title], [ParentId], [CreationDate], [ModificationDate]) VALUES (6, N'Elektronik', NULL, DEFAULT,DEFAULT)
INSERT [dbo].[Category] ([Id], [Title], [ParentId], [CreationDate], [ModificationDate]) VALUES (7, N'SüperMarket', NULL, DEFAULT,DEFAULT)
INSERT [dbo].[Category] ([Id], [Title], [ParentId], [CreationDate], [ModificationDate]) VALUES (8, N'Mobilya', NULL,DEFAULT,DEFAULT)
INSERT [dbo].[Category] ([Id], [Title], [ParentId], [CreationDate], [ModificationDate]) VALUES (9, N'Spor & Outdoor', NULL, DEFAULT,DEFAULT)
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[Order_Detail] ON 

INSERT [dbo].[Order_Detail] ([Id], [UserId], [Total], [CreationDate], [ModificationDate]) VALUES (10, 1, 1590.0000,DEFAULT,DEFAULT)
INSERT [dbo].[Order_Detail] ([Id], [UserId], [Total], [CreationDate], [ModificationDate]) VALUES (11, 2, 800.0000, DEFAULT,DEFAULT)
INSERT [dbo].[Order_Detail] ([Id], [UserId], [Total], [CreationDate], [ModificationDate]) VALUES (13, 4, 750.0000, DEFAULT,DEFAULT)
INSERT [dbo].[Order_Detail] ([Id], [UserId], [Total], [CreationDate], [ModificationDate]) VALUES (14, 1, 800.0000, DEFAULT,DEFAULT)
INSERT [dbo].[Order_Detail] ([Id], [UserId], [Total], [CreationDate], [ModificationDate]) VALUES (15, 2, 1050.0000,DEFAULT,DEFAULT)
SET IDENTITY_INSERT [dbo].[Order_Detail] OFF
GO
SET IDENTITY_INSERT [dbo].[Order_Product] ON 

INSERT [dbo].[Order_Product] ([Id], [OrderId], [Quantity], [ProductId], [Barcode], [CreationDate], [ModificationDate]) VALUES (9, 10, 2, 2, N'BCD0008', DEFAULT,DEFAULT)
INSERT [dbo].[Order_Product] ([Id], [OrderId], [Quantity], [ProductId], [Barcode], [CreationDate], [ModificationDate]) VALUES (10, 10, 2, 4, N'BCD0009',DEFAULT,DEFAULT)
INSERT [dbo].[Order_Product] ([Id], [OrderId], [Quantity], [ProductId], [Barcode], [CreationDate], [ModificationDate]) VALUES (11, 10, 15, 10, N'BCD0011',DEFAULT,DEFAULT)
INSERT [dbo].[Order_Product] ([Id], [OrderId], [Quantity], [ProductId], [Barcode], [CreationDate], [ModificationDate]) VALUES (12, 11, 1, 1, N'BCD0005',DEFAULT,DEFAULT)
INSERT [dbo].[Order_Product] ([Id], [OrderId], [Quantity], [ProductId], [Barcode], [CreationDate], [ModificationDate]) VALUES (13, 11, 1, 6, N'BCD0010',DEFAULT,DEFAULT)
INSERT [dbo].[Order_Product] ([Id], [OrderId], [Quantity], [ProductId], [Barcode], [CreationDate], [ModificationDate]) VALUES (14, 13, 3, 4, N'BCD0009',DEFAULT,DEFAULT)
INSERT [dbo].[Order_Product] ([Id], [OrderId], [Quantity], [ProductId], [Barcode], [CreationDate], [ModificationDate]) VALUES (15, 14, 2, 1, N'BCD0007',DEFAULT,DEFAULT)
INSERT [dbo].[Order_Product] ([Id], [OrderId], [Quantity], [ProductId], [Barcode], [CreationDate], [ModificationDate]) VALUES (16, 14, 2, 1, N'BCD0006',DEFAULT,DEFAULT)
INSERT [dbo].[Order_Product] ([Id], [OrderId], [Quantity], [ProductId], [Barcode], [CreationDate], [ModificationDate]) VALUES (17, 15, 35, 10, N'BCD0011', DEFAULT,DEFAULT)
SET IDENTITY_INSERT [dbo].[Order_Product] OFF
GO
SET IDENTITY_INSERT [dbo].[Payment_Details] ON 

INSERT [dbo].[Payment_Details] ([Id], [OrderId], [Provider], [Status], [Amount], [CreationDate], [ModificationDate]) VALUES (4, 10, N'LCW', N'Gerçekleşmedi', 1590, DEFAULT,DEFAULT)
INSERT [dbo].[Payment_Details] ([Id], [OrderId], [Provider], [Status], [Amount], [CreationDate], [ModificationDate]) VALUES (6, 11, N'LCW', N'Tamamlandı', 800, DEFAULT,DEFAULT)
INSERT [dbo].[Payment_Details] ([Id], [OrderId], [Provider], [Status], [Amount], [CreationDate], [ModificationDate]) VALUES (7, 13, N'LCW', N'Beklemede', 750, DEFAULT,DEFAULT)
INSERT [dbo].[Payment_Details] ([Id], [OrderId], [Provider], [Status], [Amount], [CreationDate], [ModificationDate]) VALUES (8, 14, N'LCW', N'Tamamlandı', 800, DEFAULT,DEFAULT)
INSERT [dbo].[Payment_Details] ([Id], [OrderId], [Provider], [Status], [Amount], [CreationDate], [ModificationDate]) VALUES (9, 15, N'LCW', N'Tamamlandı', 1050,DEFAULT,DEFAULT)
SET IDENTITY_INSERT [dbo].[Payment_Details] OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([Id], [Name], [ParentId], [Price], [CreationDate], [ModificationDate]) VALUES (1, N'Pantolon', 1, 200.0000,DEFAULT,DEFAULT)
INSERT [dbo].[Product] ([Id], [Name], [ParentId], [Price], [CreationDate], [ModificationDate]) VALUES (2, N'Etek', 1, 320.0000,  DEFAULT,DEFAULT)
INSERT [dbo].[Product] ([Id], [Name], [ParentId], [Price], [CreationDate], [ModificationDate]) VALUES (3, N'Şapka', 2, 120.0000, DEFAULT,DEFAULT)
INSERT [dbo].[Product] ([Id], [Name], [ParentId], [Price], [CreationDate], [ModificationDate]) VALUES (4, N'Cüzdan', 2, 250.0000,DEFAULT,DEFAULT)
INSERT [dbo].[Product] ([Id], [Name], [ParentId], [Price], [CreationDate], [ModificationDate]) VALUES (5, N'Kemer', 2, 180.0000, DEFAULT,DEFAULT)
INSERT [dbo].[Product] ([Id], [Name], [ParentId], [Price], [CreationDate], [ModificationDate]) VALUES (6, N'Bot', 3, 600.0000,   DEFAULT,DEFAULT)
INSERT [dbo].[Product] ([Id], [Name], [ParentId], [Price], [CreationDate], [ModificationDate]) VALUES (7, N'Terlik', 3, 250.0000,DEFAULT,DEFAULT)
INSERT [dbo].[Product] ([Id], [Name], [ParentId], [Price], [CreationDate], [ModificationDate]) VALUES (8, N'Kupa', 4, 50.0000,  DEFAULT,DEFAULT)
INSERT [dbo].[Product] ([Id], [Name], [ParentId], [Price], [CreationDate], [ModificationDate]) VALUES (9, N'Battaniye', 4, 130.0000,DEFAULT,DEFAULT)
INSERT [dbo].[Product] ([Id], [Name], [ParentId], [Price], [CreationDate], [ModificationDate]) VALUES (10, N'Tabak', 4, 30.0000,DEFAULT,DEFAULT)
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
SET IDENTITY_INSERT [dbo].[Product_Detail] ON 

INSERT [dbo].[Product_Detail] ([Id], [Color], [Material], [Size], [Pattern], [AgeGroup], [ProductId], [CreationDate], [ModificationDate]) VALUES (5, N'Mavi', N'Kumaş', N'S', N'Bol', N'Genç', 1, DEFAULT,DEFAULT)
INSERT [dbo].[Product_Detail] ([Id], [Color], [Material], [Size], [Pattern], [AgeGroup], [ProductId], [CreationDate], [ModificationDate]) VALUES (6, N'Siyah', N'Pamuklu', N'L', N'Dar', N'Yetişkin', 1,DEFAULT,DEFAULT)
INSERT [dbo].[Product_Detail] ([Id], [Color], [Material], [Size], [Pattern], [AgeGroup], [ProductId], [CreationDate], [ModificationDate]) VALUES (7, N'Sarı', N'Saten', N'XL', N'Regular', N'Çocuk', 1, DEFAULT,DEFAULT)
INSERT [dbo].[Product_Detail] ([Id], [Color], [Material], [Size], [Pattern], [AgeGroup], [ProductId], [CreationDate], [ModificationDate]) VALUES (8, N'Kırmızı', N'Pamuklu', N'M', N'Standart', N'Yetişkin', 2,DEFAULT,DEFAULT)
INSERT [dbo].[Product_Detail] ([Id], [Color], [Material], [Size], [Pattern], [AgeGroup], [ProductId], [CreationDate], [ModificationDate]) VALUES (9, N'Siyah', N'Deri', NULL, NULL, N'Yetişkin', 4, DEFAULT,DEFAULT)
INSERT [dbo].[Product_Detail] ([Id], [Color], [Material], [Size], [Pattern], [AgeGroup], [ProductId], [CreationDate], [ModificationDate]) VALUES (10, N'Kahverengi', N'Polyester', NULL, NULL, N'Genç', 6, DEFAULT,DEFAULT)
INSERT [dbo].[Product_Detail] ([Id], [Color], [Material], [Size], [Pattern], [AgeGroup], [ProductId], [CreationDate], [ModificationDate]) VALUES (11, N'Beyaz', N'Seramik', N'M', NULL, NULL, 10, DEFAULT,DEFAULT)
SET IDENTITY_INSERT [dbo].[Product_Detail] OFF
GO
SET IDENTITY_INSERT [dbo].[Product_Stock] ON 

INSERT [dbo].[Product_Stock] ([Id], [Quantity], [ProductId], [CreationDate], [ModificationDate], [Barcode]) VALUES (3, 499, 1, DEFAULT,DEFAULT, N'BCD0005')
INSERT [dbo].[Product_Stock] ([Id], [Quantity], [ProductId], [CreationDate], [ModificationDate], [Barcode]) VALUES (7, 998, 1, DEFAULT,DEFAULT, N'BCD0006')
INSERT [dbo].[Product_Stock] ([Id], [Quantity], [ProductId], [CreationDate], [ModificationDate], [Barcode]) VALUES (11, 998, 1,DEFAULT,DEFAULT, N'BCD0007')
INSERT [dbo].[Product_Stock] ([Id], [Quantity], [ProductId], [CreationDate], [ModificationDate], [Barcode]) VALUES (12, 970, 2,DEFAULT,DEFAULT, N'BCD0008')
INSERT [dbo].[Product_Stock] ([Id], [Quantity], [ProductId], [CreationDate], [ModificationDate], [Barcode]) VALUES (13, 497, 4,DEFAULT,DEFAULT, N'BCD0009')
INSERT [dbo].[Product_Stock] ([Id], [Quantity], [ProductId], [CreationDate], [ModificationDate], [Barcode]) VALUES (14, 99, 6, DEFAULT,DEFAULT, N'BCD0010')
INSERT [dbo].[Product_Stock] ([Id], [Quantity], [ProductId], [CreationDate], [ModificationDate], [Barcode]) VALUES (15, 4965, 10, DEFAULT,DEFAULT, N'BCD0011')
SET IDENTITY_INSERT [dbo].[Product_Stock] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([Id], [Username], [Password], [First_Name], [Last_Name], [Adress], [Telephone], [Email], [City], [CreationDate], [ModificationDate]) VALUES (1, N'Deneme', N'12345', N'Kutay', N'Demirel', N'Bostanlı', N'5551234455 ', N'asd@gmail.com', N'İzmir', DEFAULT,DEFAULT)
INSERT [dbo].[User] ([Id], [Username], [Password], [First_Name], [Last_Name], [Adress], [Telephone], [Email], [City], [CreationDate], [ModificationDate]) VALUES (2, N'Deneme1', N'asdkj', N'Ahmet', N'Mehmet', N'Girne', N'5551234456 ', N'ds@gmail.com', N'İzmir', DEFAULT,DEFAULT)
INSERT [dbo].[User] ([Id], [Username], [Password], [First_Name], [Last_Name], [Adress], [Telephone], [Email], [City], [CreationDate], [ModificationDate]) VALUES (4, N'Nickname', N'12345', N'İsimsiz', N'Soyadsız', N'Bayraklı', N'5551234457 ', N'mail@gmail.com', N'Ankara', DEFAULT,DEFAULT)
SET IDENTITY_INSERT [dbo].[User] OFF
GO
SET IDENTITY_INSERT [dbo].[User_Payment] ON 

INSERT [dbo].[User_Payment] ([Id], [UserId], [Payment_Type], [Account_No], [Expiry], [CreationDate], [ModificationDate]) VALUES (1, 1, N'Debit', 15121546, CAST(N'2023-05-24' AS Date), DEFAULT,DEFAULT)
INSERT [dbo].[User_Payment] ([Id], [UserId], [Payment_Type], [Account_No], [Expiry], [CreationDate], [ModificationDate]) VALUES (2, 2, N'CreditCard', 78945612, CAST(N'2028-12-01' AS Date), DEFAULT,DEFAULT)
INSERT [dbo].[User_Payment] ([Id], [UserId], [Payment_Type], [Account_No], [Expiry], [CreationDate], [ModificationDate]) VALUES (4, 4, N'CreditCard', 99444126, CAST(N'2031-01-08' AS Date), DEFAULT,DEFAULT)
SET IDENTITY_INSERT [dbo].[User_Payment] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UniqueName]    Script Date: 5.05.2022 16:57:10 ******/
ALTER TABLE [dbo].[Category] ADD  CONSTRAINT [UniqueName] UNIQUE NONCLUSTERED 
(
	[Title] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Order]    Script Date: 5.05.2022 16:57:10 ******/
ALTER TABLE [dbo].[Order_Detail] ADD  CONSTRAINT [UQ_Order] UNIQUE NONCLUSTERED 
(
	[Id] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UK_Payment_Details]    Script Date: 5.05.2022 16:57:10 ******/
ALTER TABLE [dbo].[Payment_Details] ADD  CONSTRAINT [UK_Payment_Details] UNIQUE NONCLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_ProductName]    Script Date: 5.05.2022 16:57:10 ******/
CREATE NONCLUSTERED INDEX [IX_ProductName] ON [dbo].[Product]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UIX_Name_Parent]    Script Date: 5.05.2022 16:57:10 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UIX_Name_Parent] ON [dbo].[Product]
(
	[Name] ASC,
	[ParentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AgeGroup]    Script Date: 5.05.2022 16:57:10 ******/
CREATE NONCLUSTERED INDEX [IX_AgeGroup] ON [dbo].[Product_Detail]
(
	[AgeGroup] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Color]    Script Date: 5.05.2022 16:57:10 ******/
CREATE NONCLUSTERED INDEX [IX_Color] ON [dbo].[Product_Detail]
(
	[Color] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Material]    Script Date: 5.05.2022 16:57:10 ******/
CREATE NONCLUSTERED INDEX [IX_Material] ON [dbo].[Product_Detail]
(
	[Material] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Pattern]    Script Date: 5.05.2022 16:57:10 ******/
CREATE NONCLUSTERED INDEX [IX_Pattern] ON [dbo].[Product_Detail]
(
	[Pattern] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Size]    Script Date: 5.05.2022 16:57:10 ******/
CREATE NONCLUSTERED INDEX [IX_Size] ON [dbo].[Product_Detail]
(
	[Size] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UIX_ID_Barcode]    Script Date: 5.05.2022 16:57:10 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UIX_ID_Barcode] ON [dbo].[Product_Stock]
(
	[ProductId] ASC,
	[Barcode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Sehir]    Script Date: 5.05.2022 16:57:10 ******/
CREATE NONCLUSTERED INDEX [Sehir] ON [dbo].[User]
(
	[City] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UIX_Email]    Script Date: 5.05.2022 16:57:10 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UIX_Email] ON [dbo].[User]
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UIX_Telephone]    Script Date: 5.05.2022 16:57:10 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UIX_Telephone] ON [dbo].[User]
(
	[Telephone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UIX_Username]    Script Date: 5.05.2022 16:57:10 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UIX_Username] ON [dbo].[User]
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Payment_Type]    Script Date: 5.05.2022 16:57:10 ******/
CREATE NONCLUSTERED INDEX [IX_Payment_Type] ON [dbo].[User_Payment]
(
	[Payment_Type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Order_Detail]  WITH CHECK ADD  CONSTRAINT [FK_Order_Detail_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[Order_Detail] CHECK CONSTRAINT [FK_Order_Detail_User]
GO
ALTER TABLE [dbo].[Order_Product]  WITH CHECK ADD  CONSTRAINT [FK_Order_Product_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
GO
ALTER TABLE [dbo].[Order_Product] CHECK CONSTRAINT [FK_Order_Product_Product]
GO
ALTER TABLE [dbo].[Order_Product]  WITH CHECK ADD  CONSTRAINT [FK_Order_Product_Product_Detail] FOREIGN KEY([Barcode])
REFERENCES [dbo].[Product_Detail] ([Barcode])
GO
ALTER TABLE [dbo].[Order_Product] CHECK CONSTRAINT [FK_Order_Product_Product_Detail]
GO
ALTER TABLE [dbo].[Order_Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Order_Detail] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Order_Detail] ([Id])
GO
ALTER TABLE [dbo].[Order_Product] CHECK CONSTRAINT [FK_Product_Order_Detail]
GO
ALTER TABLE [dbo].[Payment_Details]  WITH CHECK ADD  CONSTRAINT [FK_Payment_Details_Order_Detail] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Order_Detail] ([Id])
GO
ALTER TABLE [dbo].[Payment_Details] CHECK CONSTRAINT [FK_Payment_Details_Order_Detail]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Category] FOREIGN KEY([ParentId])
REFERENCES [dbo].[Category] ([Id])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Category]
GO
ALTER TABLE [dbo].[Product_Detail]  WITH CHECK ADD  CONSTRAINT [FK_Product_Detail_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
GO
ALTER TABLE [dbo].[Product_Detail] CHECK CONSTRAINT [FK_Product_Detail_Product]
GO
ALTER TABLE [dbo].[Product_Stock]  WITH CHECK ADD  CONSTRAINT [FK_Product_Stock_Product_Detail] FOREIGN KEY([Barcode])
REFERENCES [dbo].[Product_Detail] ([Barcode])
GO
ALTER TABLE [dbo].[Product_Stock] CHECK CONSTRAINT [FK_Product_Stock_Product_Detail]
GO
ALTER TABLE [dbo].[User_Payment]  WITH CHECK ADD  CONSTRAINT [FK_User_Payment_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[User_Payment] CHECK CONSTRAINT [FK_User_Payment_User]
GO
ALTER TABLE [dbo].[Payment_Details]  WITH CHECK ADD  CONSTRAINT [CheckStatus] CHECK  (([Status]='Gerçekleşmedi' OR [Status]='Beklemede' OR [Status]='Tamamlandı'))
GO
ALTER TABLE [dbo].[Payment_Details] CHECK CONSTRAINT [CheckStatus]
GO
ALTER TABLE [dbo].[Product_Detail]  WITH CHECK ADD  CONSTRAINT [CheckAge] CHECK  (([AgeGroup]='Bebek' OR [AgeGroup]='Çocuk' OR [AgeGroup]='Genç' OR [AgeGroup]='Yetişkin'))
GO
ALTER TABLE [dbo].[Product_Detail] CHECK CONSTRAINT [CheckAge]
GO
ALTER TABLE [dbo].[Product_Detail]  WITH CHECK ADD  CONSTRAINT [CheckSize] CHECK  (([Size]='S' OR [Size]='M' OR [Size]='L' OR [Size]='XL'))
GO
ALTER TABLE [dbo].[Product_Detail] CHECK CONSTRAINT [CheckSize]
GO
/****** Object:  StoredProcedure [dbo].[GetBySearch]    Script Date: 5.05.2022 16:57:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetBySearch]
(
	@search nvarchar(MAX) = NULL
)AS
BEGIN
	SELECT [Name],[Price],[Title] FROM [dbo].[Product] p
	LEFT JOIN [dbo].[Category] c 
	ON p.ParentId = c.Id
	WHERE p.[Name] LIKE 
		CASE WHEN @search is not null then '%'+@search+'%' else p.[Name] END
	OR c.[Title] LIKE
		CASE WHEN @search is not null then '%'+@search+'%' else c.[Title] END
END
GO
/****** Object:  Trigger [dbo].[PaymentPrice]    Script Date: 5.05.2022 16:57:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Trigger [dbo].[PaymentPrice]
on [dbo].[Order_Detail]
after update, insert
AS  
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;
	-- Insert statements for trigger here
	UPDATE Payment_Details
	SET    Payment_Details.Amount = inserted.Total
	FROM   Payment_Details
    JOIN   inserted ON Payment_Details.OrderId = inserted.Id 
	WHERE  inserted.Id = Payment_Details.OrderId 
END
GO
ALTER TABLE [dbo].[Order_Detail] ENABLE TRIGGER [PaymentPrice]
GO
/****** Object:  Trigger [dbo].[Insert_Update]    Script Date: 5.05.2022 16:57:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[Insert_Update] 
ON [dbo].[Order_Product]
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF 
        UPDATE (Quantity)

    BEGIN
        UPDATE dbo.Order_Detail
        SET Total = p.OrderPrice
        FROM inserted i
        INNER JOIN dbo.TotalAmount p ON p.OrderId = i.OrderId
		WHERE Order_Detail.Id = p.OrderId 
        --LEFT JOIN deleted d ON i.MyID = d.MyID
	
        --WHERE d.MyID IS NULL AND i.ColumnB IS NOT NULL -- Row was inserted
        --    OR d.MyID IS NOT NULL -- Row was updated
    END
END
GO
ALTER TABLE [dbo].[Order_Product] ENABLE TRIGGER [Insert_Update]
GO
/****** Object:  Trigger [dbo].[StockOperation]    Script Date: 5.05.2022 16:57:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE trigger [dbo].[StockOperation]
on [dbo].[Order_Product]
for insert, update, delete
	as
	begin
		update	s
		set		s.Quantity = s.Quantity - isnull(i.Quantity,0) + isnull(d.Quantity,0)
		from	Product_Stock s
		left join inserted i on s.Barcode = i.Barcode
		left join deleted d on d.Barcode = s.Barcode
		WHERE i.Barcode = s.Barcode
	end
GO
ALTER TABLE [dbo].[Order_Product] ENABLE TRIGGER [StockOperation]
GO
USE [master]
GO
ALTER DATABASE [LCWaikikiDb] SET  READ_WRITE 
GO
