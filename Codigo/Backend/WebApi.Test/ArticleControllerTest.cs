﻿using System;
using Microsoft.AspNetCore.Mvc;
using System.ComponentModel;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using BlogsApp.IBusinessLogic.Interfaces;
using BlogsApp.Domain.Entities;
using System.Data;
using Microsoft.AspNetCore.Http;
using BlogsApp.WebAPI.Controllers;

namespace WebApi.Test
{
	[TestClass]
	public class ArticleControllerTest
    {
        private Mock<IArticleLogic> articleLogicMock;
        private ArticleController controller;

        private static readonly Article article = new Article() { };

        [TestInitialize]
		public void InitTest()
        {
            articleLogicMock = new Mock<IArticleLogic>(MockBehavior.Strict);
            controller = new ArticleController(articleLogicMock.Object);
        }
        [TestMethod]
        public void GetArticlesById()
        {
            articleLogicMock.Setup(m => m.GetArticleById(It.IsAny<int>())).Returns(article);

            IActionResult result = controller!.GetArticleById(article.Id);
            articleLogicMock.VerifyAll();
            OkObjectResult objectResult = result as OkObjectResult;

            Assert.IsNotNull(result);
            articleLogicMock.VerifyAll();

            Assert.IsTrue(objectResult.Value.Equals(article));
        }
	}
}

