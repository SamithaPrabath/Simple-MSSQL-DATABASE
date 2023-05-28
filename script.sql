USE [master]
GO
/****** Object:  Database [awasdb]    Script Date: 5/27/2023 10:10:39 PM ******/
CREATE DATABASE [awasdb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'awasdb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER2\MSSQL\DATA\awasdb.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'awasdb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER2\MSSQL\DATA\awasdb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [awasdb] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [awasdb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [awasdb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [awasdb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [awasdb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [awasdb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [awasdb] SET ARITHABORT OFF 
GO
ALTER DATABASE [awasdb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [awasdb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [awasdb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [awasdb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [awasdb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [awasdb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [awasdb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [awasdb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [awasdb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [awasdb] SET  DISABLE_BROKER 
GO
ALTER DATABASE [awasdb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [awasdb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [awasdb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [awasdb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [awasdb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [awasdb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [awasdb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [awasdb] SET RECOVERY FULL 
GO
ALTER DATABASE [awasdb] SET  MULTI_USER 
GO
ALTER DATABASE [awasdb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [awasdb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [awasdb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [awasdb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [awasdb] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [awasdb] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'awasdb', N'ON'
GO
ALTER DATABASE [awasdb] SET QUERY_STORE = OFF
GO
USE [awasdb]
GO
/****** Object:  Table [dbo].[Exporter_Request]    Script Date: 5/27/2023 10:10:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Exporter_Request](
	[Exporter_Request_ID] [int] NOT NULL,
	[Exporter_ID] [int] NOT NULL,
	[Exporter_Request_Desc] [varchar](100) NOT NULL,
	[Exporter_Request_Date_Time] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Exporter_Request_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Completed_Exporter_Request]    Script Date: 5/27/2023 10:10:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Completed_Exporter_Request](
	[Exporter_Request_ID] [int] NOT NULL,
	[Attendance_ID] [int] NOT NULL,
	[Completed_Date_Time] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Exporter_Request_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Task]    Script Date: 5/27/2023 10:10:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Task](
	[Exporter_Request_ID] [int] NOT NULL,
	[Attendance_ID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Exporter_Request_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Available_Exporter_Requests]    Script Date: 5/27/2023 10:10:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- *** Insert statements ***

-- Exporter Requests =>
-- insert into Exporter_Request values
-- (6, 1, 'COO', GETDATE());
-- (7, 1, 'COO', GETDATE());
-- (8, 3, 'COO', GETDATE());
-- (9, 4, 'COO', GETDATE());
-- (10, 2, 'COO', GETDATE());
-- (11, 2, 'COO', GETDATE());
-- (12, 5, 'COO', GETDATE());
-- (13, 5, 'COO', GETDATE());

-- Attendace =>
-- insert into Attendance values
-- (6, 1, GETDATE());

-- *** Delete statements ***
-- delete from Exporter_Request where Exporter_Request_ID >= 6;
-- delete from Attendance where Attendance_ID >= 6;

-- Returns Exporter_Requests that are not completed and have not yet been assigned (View)
create view [dbo].[Available_Exporter_Requests]
as
select * from Exporter_Request where
Exporter_Request.Exporter_Request_ID not in (select Exporter_Request_ID from Completed_Exporter_Request)
and Exporter_Request.Exporter_Request_ID not in (select Exporter_Request_ID from Task);

GO
/****** Object:  Table [dbo].[Attendance]    Script Date: 5/27/2023 10:10:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Attendance](
	[Attendance_ID] [int] NOT NULL,
	[Officer_ID] [int] NOT NULL,
	[Shift_Start_Date_Time] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Attendance_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Attendance_Sign_Off]    Script Date: 5/27/2023 10:10:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Attendance_Sign_Off](
	[Attendance_ID] [int] NOT NULL,
	[Shift_End_Date_Time] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Attendance_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Available_Attendances]    Script Date: 5/27/2023 10:10:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[Available_Attendances]
as
select * from Attendance where 
Attendance.Attendance_ID not in (select Attendance_ID from Attendance_Sign_Off);

GO
/****** Object:  View [dbo].[Assigned_Task_Number_Attendace]    Script Date: 5/27/2023 10:10:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[Assigned_Task_Number_Attendace] AS
select Available_Attendances.Attendance_ID, sum(case when Task.Exporter_Request_ID is not null then 1 else 0 end) as 'Task_Number' from Task
right join Available_Attendances on Task.Attendance_ID = Available_Attendances.Attendance_ID
group by Available_Attendances.Attendance_ID;

GO
/****** Object:  Table [dbo].[Exporter]    Script Date: 5/27/2023 10:10:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Exporter](
	[Exporter_ID] [int] NOT NULL,
	[Exporter_Name] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Exporter_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Officer]    Script Date: 5/27/2023 10:10:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Officer](
	[Officer_ID] [int] NOT NULL,
	[Exporter_Name] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Officer_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Attendance] ([Attendance_ID], [Officer_ID], [Shift_Start_Date_Time]) VALUES (1, 1, CAST(N'2023-05-03T08:00:00.000' AS DateTime))
INSERT [dbo].[Attendance] ([Attendance_ID], [Officer_ID], [Shift_Start_Date_Time]) VALUES (2, 3, CAST(N'2023-05-03T08:10:40.000' AS DateTime))
INSERT [dbo].[Attendance] ([Attendance_ID], [Officer_ID], [Shift_Start_Date_Time]) VALUES (3, 4, CAST(N'2023-05-03T08:55:34.000' AS DateTime))
INSERT [dbo].[Attendance] ([Attendance_ID], [Officer_ID], [Shift_Start_Date_Time]) VALUES (4, 2, CAST(N'2023-05-03T09:01:22.000' AS DateTime))
INSERT [dbo].[Attendance] ([Attendance_ID], [Officer_ID], [Shift_Start_Date_Time]) VALUES (5, 5, CAST(N'2023-05-03T09:30:23.000' AS DateTime))
INSERT [dbo].[Attendance] ([Attendance_ID], [Officer_ID], [Shift_Start_Date_Time]) VALUES (6, 1, CAST(N'2023-05-19T13:25:14.710' AS DateTime))
INSERT [dbo].[Attendance] ([Attendance_ID], [Officer_ID], [Shift_Start_Date_Time]) VALUES (7, 2, CAST(N'2023-05-19T13:26:39.910' AS DateTime))
INSERT [dbo].[Attendance] ([Attendance_ID], [Officer_ID], [Shift_Start_Date_Time]) VALUES (8, 3, CAST(N'2023-05-19T13:27:01.680' AS DateTime))
INSERT [dbo].[Attendance] ([Attendance_ID], [Officer_ID], [Shift_Start_Date_Time]) VALUES (9, 1, CAST(N'2023-05-19T17:35:52.177' AS DateTime))
GO
INSERT [dbo].[Attendance_Sign_Off] ([Attendance_ID], [Shift_End_Date_Time]) VALUES (1, CAST(N'2023-05-03T15:45:34.000' AS DateTime))
INSERT [dbo].[Attendance_Sign_Off] ([Attendance_ID], [Shift_End_Date_Time]) VALUES (2, CAST(N'2023-05-03T15:50:54.000' AS DateTime))
INSERT [dbo].[Attendance_Sign_Off] ([Attendance_ID], [Shift_End_Date_Time]) VALUES (3, CAST(N'2023-05-03T15:55:23.000' AS DateTime))
INSERT [dbo].[Attendance_Sign_Off] ([Attendance_ID], [Shift_End_Date_Time]) VALUES (4, CAST(N'2023-05-03T16:01:12.000' AS DateTime))
INSERT [dbo].[Attendance_Sign_Off] ([Attendance_ID], [Shift_End_Date_Time]) VALUES (5, CAST(N'2023-05-03T16:10:08.000' AS DateTime))
INSERT [dbo].[Attendance_Sign_Off] ([Attendance_ID], [Shift_End_Date_Time]) VALUES (6, CAST(N'2023-05-19T14:44:11.963' AS DateTime))
INSERT [dbo].[Attendance_Sign_Off] ([Attendance_ID], [Shift_End_Date_Time]) VALUES (7, CAST(N'2023-05-19T14:41:03.650' AS DateTime))
INSERT [dbo].[Attendance_Sign_Off] ([Attendance_ID], [Shift_End_Date_Time]) VALUES (8, CAST(N'2023-05-19T14:40:15.673' AS DateTime))
GO
INSERT [dbo].[Completed_Exporter_Request] ([Exporter_Request_ID], [Attendance_ID], [Completed_Date_Time]) VALUES (1, 1, CAST(N'2023-05-03T10:45:56.000' AS DateTime))
INSERT [dbo].[Completed_Exporter_Request] ([Exporter_Request_ID], [Attendance_ID], [Completed_Date_Time]) VALUES (2, 3, CAST(N'2023-05-03T10:50:33.000' AS DateTime))
INSERT [dbo].[Completed_Exporter_Request] ([Exporter_Request_ID], [Attendance_ID], [Completed_Date_Time]) VALUES (3, 2, CAST(N'2023-05-03T11:55:23.000' AS DateTime))
INSERT [dbo].[Completed_Exporter_Request] ([Exporter_Request_ID], [Attendance_ID], [Completed_Date_Time]) VALUES (4, 5, CAST(N'2023-05-03T13:05:22.000' AS DateTime))
INSERT [dbo].[Completed_Exporter_Request] ([Exporter_Request_ID], [Attendance_ID], [Completed_Date_Time]) VALUES (5, 2, CAST(N'2023-05-03T14:30:56.000' AS DateTime))
INSERT [dbo].[Completed_Exporter_Request] ([Exporter_Request_ID], [Attendance_ID], [Completed_Date_Time]) VALUES (6, 9, CAST(N'2023-05-19T17:38:54.980' AS DateTime))
INSERT [dbo].[Completed_Exporter_Request] ([Exporter_Request_ID], [Attendance_ID], [Completed_Date_Time]) VALUES (7, 9, CAST(N'2023-05-19T17:38:55.020' AS DateTime))
INSERT [dbo].[Completed_Exporter_Request] ([Exporter_Request_ID], [Attendance_ID], [Completed_Date_Time]) VALUES (8, 9, CAST(N'2023-05-19T17:38:55.020' AS DateTime))
INSERT [dbo].[Completed_Exporter_Request] ([Exporter_Request_ID], [Attendance_ID], [Completed_Date_Time]) VALUES (9, 9, CAST(N'2023-05-19T17:38:55.023' AS DateTime))
INSERT [dbo].[Completed_Exporter_Request] ([Exporter_Request_ID], [Attendance_ID], [Completed_Date_Time]) VALUES (10, 6, CAST(N'2023-05-19T14:43:20.143' AS DateTime))
INSERT [dbo].[Completed_Exporter_Request] ([Exporter_Request_ID], [Attendance_ID], [Completed_Date_Time]) VALUES (11, 9, CAST(N'2023-05-19T17:38:55.023' AS DateTime))
INSERT [dbo].[Completed_Exporter_Request] ([Exporter_Request_ID], [Attendance_ID], [Completed_Date_Time]) VALUES (12, 8, CAST(N'2023-05-19T14:34:04.310' AS DateTime))
GO
INSERT [dbo].[Exporter] ([Exporter_ID], [Exporter_Name]) VALUES (1, N'ABC Exporters')
INSERT [dbo].[Exporter] ([Exporter_ID], [Exporter_Name]) VALUES (2, N'Brandix Limited')
INSERT [dbo].[Exporter] ([Exporter_ID], [Exporter_Name]) VALUES (3, N'Abans PLC')
INSERT [dbo].[Exporter] ([Exporter_ID], [Exporter_Name]) VALUES (4, N'Ceylon Tea Exports')
INSERT [dbo].[Exporter] ([Exporter_ID], [Exporter_Name]) VALUES (5, N'JAAS Holdings')
GO
INSERT [dbo].[Exporter_Request] ([Exporter_Request_ID], [Exporter_ID], [Exporter_Request_Desc], [Exporter_Request_Date_Time]) VALUES (1, 1, N'COO', CAST(N'2023-05-03T10:10:10.000' AS DateTime))
INSERT [dbo].[Exporter_Request] ([Exporter_Request_ID], [Exporter_ID], [Exporter_Request_Desc], [Exporter_Request_Date_Time]) VALUES (2, 1, N'COO Spices', CAST(N'2023-05-03T10:30:10.000' AS DateTime))
INSERT [dbo].[Exporter_Request] ([Exporter_Request_ID], [Exporter_ID], [Exporter_Request_Desc], [Exporter_Request_Date_Time]) VALUES (3, 3, N'TRQC', CAST(N'2023-05-03T11:12:30.000' AS DateTime))
INSERT [dbo].[Exporter_Request] ([Exporter_Request_ID], [Exporter_ID], [Exporter_Request_Desc], [Exporter_Request_Date_Time]) VALUES (4, 4, N'COO', CAST(N'2023-05-03T12:15:35.000' AS DateTime))
INSERT [dbo].[Exporter_Request] ([Exporter_Request_ID], [Exporter_ID], [Exporter_Request_Desc], [Exporter_Request_Date_Time]) VALUES (5, 2, N'COO', CAST(N'2023-05-03T13:45:01.000' AS DateTime))
INSERT [dbo].[Exporter_Request] ([Exporter_Request_ID], [Exporter_ID], [Exporter_Request_Desc], [Exporter_Request_Date_Time]) VALUES (6, 1, N'COO', CAST(N'2023-05-18T20:57:44.653' AS DateTime))
INSERT [dbo].[Exporter_Request] ([Exporter_Request_ID], [Exporter_ID], [Exporter_Request_Desc], [Exporter_Request_Date_Time]) VALUES (7, 2, N'COO', CAST(N'2023-05-19T13:22:16.270' AS DateTime))
INSERT [dbo].[Exporter_Request] ([Exporter_Request_ID], [Exporter_ID], [Exporter_Request_Desc], [Exporter_Request_Date_Time]) VALUES (8, 2, N'COO', CAST(N'2023-05-19T13:22:31.890' AS DateTime))
INSERT [dbo].[Exporter_Request] ([Exporter_Request_ID], [Exporter_ID], [Exporter_Request_Desc], [Exporter_Request_Date_Time]) VALUES (9, 3, N'COO Spices', CAST(N'2023-05-19T13:22:47.333' AS DateTime))
INSERT [dbo].[Exporter_Request] ([Exporter_Request_ID], [Exporter_ID], [Exporter_Request_Desc], [Exporter_Request_Date_Time]) VALUES (10, 4, N'TRQC', CAST(N'2023-05-19T13:23:00.943' AS DateTime))
INSERT [dbo].[Exporter_Request] ([Exporter_Request_ID], [Exporter_ID], [Exporter_Request_Desc], [Exporter_Request_Date_Time]) VALUES (11, 4, N'COO', CAST(N'2023-05-19T13:23:18.340' AS DateTime))
INSERT [dbo].[Exporter_Request] ([Exporter_Request_ID], [Exporter_ID], [Exporter_Request_Desc], [Exporter_Request_Date_Time]) VALUES (12, 4, N'COO', CAST(N'2023-05-19T13:27:46.380' AS DateTime))
GO
INSERT [dbo].[Officer] ([Officer_ID], [Exporter_Name]) VALUES (1, N'Tishara Basnayaka')
INSERT [dbo].[Officer] ([Officer_ID], [Exporter_Name]) VALUES (2, N'Samadhi Vithana')
INSERT [dbo].[Officer] ([Officer_ID], [Exporter_Name]) VALUES (3, N'Nilmi Sewwandi')
INSERT [dbo].[Officer] ([Officer_ID], [Exporter_Name]) VALUES (4, N'Nithmini Wadu')
INSERT [dbo].[Officer] ([Officer_ID], [Exporter_Name]) VALUES (5, N'Maneesha Jeewanthi')
GO
ALTER TABLE [dbo].[Attendance]  WITH CHECK ADD FOREIGN KEY([Officer_ID])
REFERENCES [dbo].[Officer] ([Officer_ID])
GO
ALTER TABLE [dbo].[Attendance_Sign_Off]  WITH CHECK ADD FOREIGN KEY([Attendance_ID])
REFERENCES [dbo].[Attendance] ([Attendance_ID])
GO
ALTER TABLE [dbo].[Completed_Exporter_Request]  WITH CHECK ADD FOREIGN KEY([Attendance_ID])
REFERENCES [dbo].[Attendance] ([Attendance_ID])
GO
ALTER TABLE [dbo].[Completed_Exporter_Request]  WITH CHECK ADD FOREIGN KEY([Exporter_Request_ID])
REFERENCES [dbo].[Exporter_Request] ([Exporter_Request_ID])
GO
ALTER TABLE [dbo].[Exporter_Request]  WITH CHECK ADD FOREIGN KEY([Exporter_ID])
REFERENCES [dbo].[Exporter] ([Exporter_ID])
GO
ALTER TABLE [dbo].[Task]  WITH CHECK ADD FOREIGN KEY([Attendance_ID])
REFERENCES [dbo].[Attendance] ([Attendance_ID])
GO
ALTER TABLE [dbo].[Task]  WITH CHECK ADD FOREIGN KEY([Exporter_Request_ID])
REFERENCES [dbo].[Exporter_Request] ([Exporter_Request_ID])
GO
/****** Object:  StoredProcedure [dbo].[completeExporterRequest]    Script Date: 5/27/2023 10:10:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[completeExporterRequest]
	@ExporterRequestID int
AS
declare @AttendanceID int;
select @AttendanceID = Attendance_ID from Task where Exporter_Request_ID = @ExporterRequestID;
if @AttendanceID is not null
	begin
		insert into Completed_Exporter_Request values (@ExporterRequestID, @AttendanceID, GETDATE());
	end;

GO
/****** Object:  StoredProcedure [dbo].[makeExporterRequest]    Script Date: 5/27/2023 10:10:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[makeExporterRequest]
	@ExporterRequestID int,
	@ExporterID int,
	@Exporter_Request_Desc varchar(100)
AS
insert into Exporter_Request values (@ExporterRequestID, @ExporterID, @Exporter_Request_Desc, GETDATE());
GO
/****** Object:  StoredProcedure [dbo].[markAttendance]    Script Date: 5/27/2023 10:10:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[markAttendance]
	@AttendanceID int,
	@OfficerID int
AS
insert into Attendance values (@AttendanceID, @OfficerID, GETDATE());

GO
/****** Object:  StoredProcedure [dbo].[signOffAttendance]    Script Date: 5/27/2023 10:10:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[signOffAttendance]
	@AttendanceID int
AS
insert into Attendance_Sign_Off values (@AttendanceID, GETDATE());

GO
USE [master]
GO
ALTER DATABASE [awasdb] SET  READ_WRITE 
GO
