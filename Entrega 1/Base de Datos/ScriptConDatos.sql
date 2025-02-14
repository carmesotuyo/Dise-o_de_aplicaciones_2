USE [master]
GO
/****** Object:  Database [BlogsApp]    Script Date: 5/4/2023 1:16:00 ******/
CREATE DATABASE [BlogsApp]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BlogsApp', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\BlogsApp.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BlogsApp_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\BlogsApp_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [BlogsApp] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BlogsApp].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BlogsApp] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BlogsApp] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BlogsApp] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BlogsApp] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BlogsApp] SET ARITHABORT OFF 
GO
ALTER DATABASE [BlogsApp] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BlogsApp] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BlogsApp] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BlogsApp] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BlogsApp] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BlogsApp] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BlogsApp] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BlogsApp] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BlogsApp] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BlogsApp] SET  ENABLE_BROKER 
GO
ALTER DATABASE [BlogsApp] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BlogsApp] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BlogsApp] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BlogsApp] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BlogsApp] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BlogsApp] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [BlogsApp] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BlogsApp] SET RECOVERY FULL 
GO
ALTER DATABASE [BlogsApp] SET  MULTI_USER 
GO
ALTER DATABASE [BlogsApp] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BlogsApp] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BlogsApp] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BlogsApp] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [BlogsApp] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [BlogsApp] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'BlogsApp', N'ON'
GO
ALTER DATABASE [BlogsApp] SET QUERY_STORE = ON
GO
ALTER DATABASE [BlogsApp] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [BlogsApp]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 5/4/2023 1:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Articles]    Script Date: 5/4/2023 1:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Articles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Body] [nvarchar](max) NOT NULL,
	[Private] [bit] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[DateDeleted] [datetime2](7) NULL,
	[Image] [nvarchar](max) NULL,
	[Template] [int] NOT NULL,
	[UserId] [int] NOT NULL,
 CONSTRAINT [PK_Articles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comments]    Script Date: 5/4/2023 1:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[Body] [nvarchar](max) NOT NULL,
	[ReplyId] [int] NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[DateDeleted] [datetime2](7) NULL,
	[ArticleId] [int] NOT NULL,
 CONSTRAINT [PK_Comments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LogEntries]    Script Date: 5/4/2023 1:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LogEntries](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[ActionType] [nvarchar](max) NOT NULL,
	[SearchQuery] [nvarchar](max) NULL,
	[Timestamp] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_LogEntries] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Replies]    Script Date: 5/4/2023 1:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Replies](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[Body] [nvarchar](max) NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[DateDeleted] [datetime2](7) NULL,
 CONSTRAINT [PK_Replies] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sessions]    Script Date: 5/4/2023 1:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sessions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[Token] [uniqueidentifier] NOT NULL,
	[DateTimeLogin] [datetime2](7) NOT NULL,
	[DateTimeLogout] [datetime2](7) NULL,
 CONSTRAINT [PK_Sessions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 5/4/2023 1:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](max) NOT NULL,
	[Password] [nvarchar](max) NOT NULL,
	[Email] [nvarchar](max) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[LastName] [nvarchar](max) NOT NULL,
	[Blogger] [bit] NOT NULL,
	[Admin] [bit] NOT NULL,
	[DateDeleted] [datetime2](7) NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230406210243_InitialCreate', N'7.0.5')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230422155806_AddArticles', N'7.0.5')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230422233722_AddEntities', N'7.0.5')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230430023506_ArticlesEntity', N'7.0.5')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230502215250_LatestChanges', N'7.0.5')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230503105442_CommentsAndRepliesFixes', N'7.0.5')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230503180852_LastChangesWithLogger', N'7.0.5')
GO
SET IDENTITY_INSERT [dbo].[Articles] ON 

INSERT [dbo].[Articles] ([Id], [Name], [Body], [Private], [DateCreated], [DateModified], [DateDeleted], [Image], [Template], [UserId]) VALUES (1, N'Modificadoo', N'string', 0, CAST(N'2023-05-03T16:35:23.8556912' AS DateTime2), CAST(N'2023-05-03T19:40:31.7708543' AS DateTime2), NULL, N'string', 1, 1)
INSERT [dbo].[Articles] ([Id], [Name], [Body], [Private], [DateCreated], [DateModified], [DateDeleted], [Image], [Template], [UserId]) VALUES (2, N'article', N'string', 0, CAST(N'2023-05-03T17:14:57.0655073' AS DateTime2), CAST(N'2023-05-03T17:14:57.0657399' AS DateTime2), NULL, N'string', 1, 1)
INSERT [dbo].[Articles] ([Id], [Name], [Body], [Private], [DateCreated], [DateModified], [DateDeleted], [Image], [Template], [UserId]) VALUES (3, N'article', N'string', 0, CAST(N'2023-05-03T17:22:20.5116892' AS DateTime2), CAST(N'2023-05-03T17:22:20.5120404' AS DateTime2), NULL, N'string', 1, 1)
INSERT [dbo].[Articles] ([Id], [Name], [Body], [Private], [DateCreated], [DateModified], [DateDeleted], [Image], [Template], [UserId]) VALUES (4, N'Articulo Cool', N'Lo mas cool que vas a leer en tu vida', 0, CAST(N'2023-05-03T17:28:09.2054894' AS DateTime2), CAST(N'2023-05-03T17:28:09.2056771' AS DateTime2), NULL, N'string', 1, 1)
INSERT [dbo].[Articles] ([Id], [Name], [Body], [Private], [DateCreated], [DateModified], [DateDeleted], [Image], [Template], [UserId]) VALUES (5, N'Articulo Cool definitivo', N'Lo mas cool que vas a leer en tu vida posta mal', 0, CAST(N'2023-05-03T17:29:54.9869267' AS DateTime2), CAST(N'2023-05-03T17:29:54.9872187' AS DateTime2), NULL, N'string', 1, 1)
INSERT [dbo].[Articles] ([Id], [Name], [Body], [Private], [DateCreated], [DateModified], [DateDeleted], [Image], [Template], [UserId]) VALUES (6, N'string', N'string', 1, CAST(N'2023-05-03T22:20:47.9458315' AS DateTime2), CAST(N'2023-05-03T22:20:47.9460351' AS DateTime2), NULL, N'string', 2, 1)
SET IDENTITY_INSERT [dbo].[Articles] OFF
GO
SET IDENTITY_INSERT [dbo].[Comments] ON 

INSERT [dbo].[Comments] ([Id], [UserId], [Body], [ReplyId], [DateCreated], [DateModified], [DateDeleted], [ArticleId]) VALUES (1, 1, N'Hola', NULL, CAST(N'2023-05-03T22:41:32.0884038' AS DateTime2), CAST(N'2023-05-03T22:41:32.0885775' AS DateTime2), NULL, 1)
INSERT [dbo].[Comments] ([Id], [UserId], [Body], [ReplyId], [DateCreated], [DateModified], [DateDeleted], [ArticleId]) VALUES (2, 1, N'Hola', NULL, CAST(N'2023-05-03T22:48:20.8611471' AS DateTime2), CAST(N'2023-05-03T22:48:20.8612956' AS DateTime2), NULL, 1)
INSERT [dbo].[Comments] ([Id], [UserId], [Body], [ReplyId], [DateCreated], [DateModified], [DateDeleted], [ArticleId]) VALUES (3, 1, N'Hola', NULL, CAST(N'2023-05-03T22:57:02.2200156' AS DateTime2), CAST(N'2023-05-03T22:57:02.2201604' AS DateTime2), NULL, 1)
INSERT [dbo].[Comments] ([Id], [UserId], [Body], [ReplyId], [DateCreated], [DateModified], [DateDeleted], [ArticleId]) VALUES (4, 1, N'Hola', NULL, CAST(N'2023-05-03T22:57:05.8965503' AS DateTime2), CAST(N'2023-05-03T22:57:05.8965515' AS DateTime2), NULL, 1)
INSERT [dbo].[Comments] ([Id], [UserId], [Body], [ReplyId], [DateCreated], [DateModified], [DateDeleted], [ArticleId]) VALUES (5, 1, N'Hola', NULL, CAST(N'2023-05-03T22:57:09.1825511' AS DateTime2), CAST(N'2023-05-03T22:57:09.1825524' AS DateTime2), NULL, 1)
INSERT [dbo].[Comments] ([Id], [UserId], [Body], [ReplyId], [DateCreated], [DateModified], [DateDeleted], [ArticleId]) VALUES (6, 1, N'Hola', NULL, CAST(N'2023-05-03T22:57:10.2310740' AS DateTime2), CAST(N'2023-05-03T22:57:10.2310748' AS DateTime2), NULL, 1)
INSERT [dbo].[Comments] ([Id], [UserId], [Body], [ReplyId], [DateCreated], [DateModified], [DateDeleted], [ArticleId]) VALUES (7, 1, N'Hola', NULL, CAST(N'2023-05-03T22:57:11.1949821' AS DateTime2), CAST(N'2023-05-03T22:57:11.1949831' AS DateTime2), NULL, 1)
INSERT [dbo].[Comments] ([Id], [UserId], [Body], [ReplyId], [DateCreated], [DateModified], [DateDeleted], [ArticleId]) VALUES (8, 1, N'Comentario Test', NULL, CAST(N'2023-05-04T00:19:29.2044126' AS DateTime2), CAST(N'2023-05-04T00:19:29.2044137' AS DateTime2), NULL, 1)
SET IDENTITY_INSERT [dbo].[Comments] OFF
GO
SET IDENTITY_INSERT [dbo].[LogEntries] ON 

INSERT [dbo].[LogEntries] ([Id], [UserId], [ActionType], [SearchQuery], [Timestamp]) VALUES (1, 1, N'Login', NULL, CAST(N'2023-05-03T18:50:01.7501607' AS DateTime2))
INSERT [dbo].[LogEntries] ([Id], [UserId], [ActionType], [SearchQuery], [Timestamp]) VALUES (2, 1, N'Search', N'cool', CAST(N'2023-05-03T22:36:21.6174283' AS DateTime2))
INSERT [dbo].[LogEntries] ([Id], [UserId], [ActionType], [SearchQuery], [Timestamp]) VALUES (3, 1, N'Search', N'Carmela tonta', CAST(N'2023-05-03T22:36:44.5741472' AS DateTime2))
INSERT [dbo].[LogEntries] ([Id], [UserId], [ActionType], [SearchQuery], [Timestamp]) VALUES (4, 1, N'Search', N'articulo', CAST(N'2023-05-03T22:36:57.1524420' AS DateTime2))
INSERT [dbo].[LogEntries] ([Id], [UserId], [ActionType], [SearchQuery], [Timestamp]) VALUES (5, 1, N'Search', N'cool definitivo', CAST(N'2023-05-03T22:37:27.4639447' AS DateTime2))
INSERT [dbo].[LogEntries] ([Id], [UserId], [ActionType], [SearchQuery], [Timestamp]) VALUES (6, 1, N'Search', N'Cool definitivo', CAST(N'2023-05-03T22:37:46.3346394' AS DateTime2))
INSERT [dbo].[LogEntries] ([Id], [UserId], [ActionType], [SearchQuery], [Timestamp]) VALUES (7, 1, N'Search', N'definitivo', CAST(N'2023-05-03T22:38:33.3009430' AS DateTime2))
INSERT [dbo].[LogEntries] ([Id], [UserId], [ActionType], [SearchQuery], [Timestamp]) VALUES (8, 1, N'Search', N'mas', CAST(N'2023-05-03T22:38:58.4401275' AS DateTime2))
INSERT [dbo].[LogEntries] ([Id], [UserId], [ActionType], [SearchQuery], [Timestamp]) VALUES (9, 2, N'Login', NULL, CAST(N'2023-05-03T22:46:22.9682819' AS DateTime2))
INSERT [dbo].[LogEntries] ([Id], [UserId], [ActionType], [SearchQuery], [Timestamp]) VALUES (10, 1, N'Login', NULL, CAST(N'2023-05-03T23:01:48.1193852' AS DateTime2))
INSERT [dbo].[LogEntries] ([Id], [UserId], [ActionType], [SearchQuery], [Timestamp]) VALUES (11, 1, N'Login', NULL, CAST(N'2023-05-03T23:05:23.3480365' AS DateTime2))
INSERT [dbo].[LogEntries] ([Id], [UserId], [ActionType], [SearchQuery], [Timestamp]) VALUES (12, 3, N'Login', NULL, CAST(N'2023-05-04T03:17:58.4631660' AS DateTime2))
INSERT [dbo].[LogEntries] ([Id], [UserId], [ActionType], [SearchQuery], [Timestamp]) VALUES (13, 1, N'Search', N'Cool', CAST(N'2023-05-04T03:38:45.3786640' AS DateTime2))
SET IDENTITY_INSERT [dbo].[LogEntries] OFF
GO
SET IDENTITY_INSERT [dbo].[Replies] ON 

INSERT [dbo].[Replies] ([Id], [UserId], [Body], [DateCreated], [DateModified], [DateDeleted]) VALUES (1, 1, N'Comentario', CAST(N'2023-05-04T00:37:59.3954060' AS DateTime2), CAST(N'2023-05-04T00:37:59.3956257' AS DateTime2), NULL)
SET IDENTITY_INSERT [dbo].[Replies] OFF
GO
SET IDENTITY_INSERT [dbo].[Sessions] ON 

INSERT [dbo].[Sessions] ([Id], [UserId], [Token], [DateTimeLogin], [DateTimeLogout]) VALUES (1, 1, N'9a3bfa56-fa49-4038-b67c-fe86d1c7edf0', CAST(N'2023-05-03T15:50:01.5992183' AS DateTime2), CAST(N'2023-05-03T19:59:47.2502778' AS DateTime2))
INSERT [dbo].[Sessions] ([Id], [UserId], [Token], [DateTimeLogin], [DateTimeLogout]) VALUES (2, 2, N'3f5b9ad5-14ff-4316-b911-375eb5392319', CAST(N'2023-05-03T19:46:22.9191681' AS DateTime2), NULL)
INSERT [dbo].[Sessions] ([Id], [UserId], [Token], [DateTimeLogin], [DateTimeLogout]) VALUES (3, 1, N'940480b9-ea20-4635-96fb-c2785d4e01cd', CAST(N'2023-05-03T20:01:48.1054395' AS DateTime2), CAST(N'2023-05-03T20:05:15.9468121' AS DateTime2))
INSERT [dbo].[Sessions] ([Id], [UserId], [Token], [DateTimeLogin], [DateTimeLogout]) VALUES (4, 1, N'5a7a6ead-5a30-4b0c-b6b1-e31a53fc34ba', CAST(N'2023-05-03T20:05:23.2629402' AS DateTime2), NULL)
INSERT [dbo].[Sessions] ([Id], [UserId], [Token], [DateTimeLogin], [DateTimeLogout]) VALUES (5, 3, N'9b29b2e2-b028-4ce4-96c1-6cffdce926d4', CAST(N'2023-05-04T00:17:58.4189503' AS DateTime2), CAST(N'2023-05-04T00:18:56.0154429' AS DateTime2))
SET IDENTITY_INSERT [dbo].[Sessions] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([Id], [Username], [Password], [Email], [Name], [LastName], [Blogger], [Admin], [DateDeleted]) VALUES (1, N'FerSpi', N'12345', N'FerFer@nando.com', N'Fernando', N'Pro', 1, 1, NULL)
INSERT [dbo].[Users] ([Id], [Username], [Password], [Email], [Name], [LastName], [Blogger], [Admin], [DateDeleted]) VALUES (2, N'Admin', N'12345', N'fer@nando.com', N'Fernando', N'Pro', 0, 1, NULL)
INSERT [dbo].[Users] ([Id], [Username], [Password], [Email], [Name], [LastName], [Blogger], [Admin], [DateDeleted]) VALUES (3, N'UserTest', N'12345', N'fer@nando.com', N'Fernando', N'Pro', 0, 1, NULL)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
/****** Object:  Index [IX_Articles_UserId]    Script Date: 5/4/2023 1:16:00 ******/
CREATE NONCLUSTERED INDEX [IX_Articles_UserId] ON [dbo].[Articles]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Comments_ArticleId]    Script Date: 5/4/2023 1:16:00 ******/
CREATE NONCLUSTERED INDEX [IX_Comments_ArticleId] ON [dbo].[Comments]
(
	[ArticleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Comments_ReplyId]    Script Date: 5/4/2023 1:16:00 ******/
CREATE NONCLUSTERED INDEX [IX_Comments_ReplyId] ON [dbo].[Comments]
(
	[ReplyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Comments_UserId]    Script Date: 5/4/2023 1:16:00 ******/
CREATE NONCLUSTERED INDEX [IX_Comments_UserId] ON [dbo].[Comments]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Replies_UserId]    Script Date: 5/4/2023 1:16:00 ******/
CREATE NONCLUSTERED INDEX [IX_Replies_UserId] ON [dbo].[Replies]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Sessions_UserId]    Script Date: 5/4/2023 1:16:00 ******/
CREATE NONCLUSTERED INDEX [IX_Sessions_UserId] ON [dbo].[Sessions]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Articles] ADD  DEFAULT ((0)) FOR [Template]
GO
ALTER TABLE [dbo].[Articles] ADD  DEFAULT ((0)) FOR [UserId]
GO
ALTER TABLE [dbo].[Comments] ADD  DEFAULT ((0)) FOR [ArticleId]
GO
ALTER TABLE [dbo].[Articles]  WITH CHECK ADD  CONSTRAINT [FK_Articles_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Articles] CHECK CONSTRAINT [FK_Articles_Users_UserId]
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD  CONSTRAINT [FK_Comments_Articles_ArticleId] FOREIGN KEY([ArticleId])
REFERENCES [dbo].[Articles] ([Id])
GO
ALTER TABLE [dbo].[Comments] CHECK CONSTRAINT [FK_Comments_Articles_ArticleId]
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD  CONSTRAINT [FK_Comments_Replies_ReplyId] FOREIGN KEY([ReplyId])
REFERENCES [dbo].[Replies] ([Id])
GO
ALTER TABLE [dbo].[Comments] CHECK CONSTRAINT [FK_Comments_Replies_ReplyId]
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD  CONSTRAINT [FK_Comments_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Comments] CHECK CONSTRAINT [FK_Comments_Users_UserId]
GO
ALTER TABLE [dbo].[Replies]  WITH CHECK ADD  CONSTRAINT [FK_Replies_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Replies] CHECK CONSTRAINT [FK_Replies_Users_UserId]
GO
ALTER TABLE [dbo].[Sessions]  WITH CHECK ADD  CONSTRAINT [FK_Sessions_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Sessions] CHECK CONSTRAINT [FK_Sessions_Users_UserId]
GO
USE [master]
GO
ALTER DATABASE [BlogsApp] SET  READ_WRITE 
GO
