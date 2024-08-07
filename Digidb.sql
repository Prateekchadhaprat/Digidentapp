USE [master]
GO
/****** Object:  Database [Digidentdb]    Script Date: 22-07-2024 09:22:51 PM ******/
CREATE DATABASE [Digidentdb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Digidentdb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Digidentdb.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Digidentdb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Digidentdb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Digidentdb] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Digidentdb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Digidentdb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Digidentdb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Digidentdb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Digidentdb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Digidentdb] SET ARITHABORT OFF 
GO
ALTER DATABASE [Digidentdb] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Digidentdb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Digidentdb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Digidentdb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Digidentdb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Digidentdb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Digidentdb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Digidentdb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Digidentdb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Digidentdb] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Digidentdb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Digidentdb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Digidentdb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Digidentdb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Digidentdb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Digidentdb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Digidentdb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Digidentdb] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Digidentdb] SET  MULTI_USER 
GO
ALTER DATABASE [Digidentdb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Digidentdb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Digidentdb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Digidentdb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Digidentdb] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Digidentdb] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Digidentdb] SET QUERY_STORE = OFF
GO
USE [Digidentdb]
GO
/****** Object:  Table [dbo].[CustomerRepresentatives]    Script Date: 22-07-2024 09:22:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerRepresentatives](
	[CustomerRepresentativeID] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](255) NOT NULL,
	[Password] [nvarchar](255) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[DateOfBirth] [date] NOT NULL,
	[Address] [nvarchar](255) NOT NULL,
	[PhoneNumber] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CustomerRepresentativeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dentists]    Script Date: 22-07-2024 09:22:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dentists](
	[DentistID] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](255) NOT NULL,
	[Password] [nvarchar](255) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[DateOfBirth] [date] NOT NULL,
	[Address] [nvarchar](255) NOT NULL,
	[PhoneNumber] [nvarchar](20) NOT NULL,
	[LicenseNumber] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DentistID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[LicenseNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Managers]    Script Date: 22-07-2024 09:22:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Managers](
	[ManagerID] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](255) NOT NULL,
	[Password] [nvarchar](255) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[DateOfBirth] [date] NOT NULL,
	[Address] [nvarchar](255) NOT NULL,
	[PhoneNumber] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ManagerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 22-07-2024 09:22:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](256) NOT NULL,
	[Password] [nvarchar](256) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[DateOfBirth] [date] NOT NULL,
	[Address] [nvarchar](100) NOT NULL,
	[PhoneNumber] [nvarchar](15) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[InsertCustomerRepresentative]    Script Date: 22-07-2024 09:22:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertCustomerRepresentative]
    @Email NVARCHAR(255),
    @Password NVARCHAR(255),
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @DateOfBirth DATE,
    @Address NVARCHAR(255),
    @PhoneNumber NVARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if the email already exists
    IF EXISTS (SELECT 1 FROM CustomerRepresentatives WHERE Email = @Email)
    BEGIN
        RAISERROR('A customer representative with this email already exists.', 16, 1);
        RETURN;
    END

    -- Insert the new customer representative record
    INSERT INTO CustomerRepresentatives (Email, Password, FirstName, LastName, DateOfBirth, Address, PhoneNumber)
    VALUES (@Email, @Password, @FirstName, @LastName, @DateOfBirth, @Address, @PhoneNumber);
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertDentist]    Script Date: 22-07-2024 09:22:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertDentist]
    @Email NVARCHAR(255),
    @Password NVARCHAR(255),
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @DateOfBirth DATE,
    @Address NVARCHAR(255),
    @PhoneNumber NVARCHAR(20),
    @LicenseNumber NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if the email already exists
    IF EXISTS (SELECT 1 FROM Dentists WHERE Email = @Email)
    BEGIN
        RAISERROR('A dentist with this email already exists.', 16, 1);
        RETURN;
    END

    -- Insert the new dentist record
    INSERT INTO Dentists (Email, Password, FirstName, LastName, DateOfBirth, Address, PhoneNumber, LicenseNumber)
    VALUES (@Email, @Password, @FirstName, @LastName, @DateOfBirth, @Address, @PhoneNumber, @LicenseNumber);
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertManager]    Script Date: 22-07-2024 09:22:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertManager]
    @Email NVARCHAR(255),
    @Password NVARCHAR(255),
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @DateOfBirth DATE,
    @Address NVARCHAR(255),
    @PhoneNumber NVARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if the email already exists
    IF EXISTS (SELECT 1 FROM Managers WHERE Email = @Email)
    BEGIN
        RAISERROR('A manager with this email already exists.', 16, 1);
        RETURN;
    END

    -- Insert the new manager record
    INSERT INTO Managers (Email, Password, FirstName, LastName, DateOfBirth, Address, PhoneNumber)
    VALUES (@Email, @Password, @FirstName, @LastName, @DateOfBirth, @Address, @PhoneNumber);
END;
GO
/****** Object:  StoredProcedure [dbo].[RegisterUser]    Script Date: 22-07-2024 09:22:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RegisterUser]
    @Email NVARCHAR(256),
    @Password NVARCHAR(256),
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @DateOfBirth DATE,
    @Address NVARCHAR(100),
    @PhoneNumber NVARCHAR(15)
AS
BEGIN
    INSERT INTO Users (Email, Password, FirstName, LastName, DateOfBirth, Address, PhoneNumber)
    VALUES (@Email, @Password, @FirstName, @LastName, @DateOfBirth, @Address, @PhoneNumber);
END
GO
USE [master]
GO
ALTER DATABASE [Digidentdb] SET  READ_WRITE 
GO
