﻿using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using BlogsApp.IDataAccess.Interfaces;
using BlogsApp.BusinessLogic.Logics;
using BlogsApp.Domain.Entities;
using BlogsApp.IBusinessLogic.Interfaces;
using BlogsApp.DataAccess.Repositories;

namespace BusinessLogic.Test
{
	[TestClass]
	public class CommentLogicTest
    {
        private Mock<ICommentRepository> commentRepository;
        private Mock<IReplyLogic> replyLogicMock;
        private CommentLogic commentLogic;
        private ICollection<Comment> comments;
        private Reply reply;
        private Comment comment;
        private Comment comment2;
        private User userBlogger;
        private User userAdmin;
        private Article article;

        [TestInitialize]
        public void TestInitialize()
        {
            commentRepository = new Mock<ICommentRepository>(MockBehavior.Strict);
            replyLogicMock = new Mock<IReplyLogic>(MockBehavior.Strict);
            commentLogic = new CommentLogic(commentRepository.Object, replyLogicMock.Object);
            reply = new Reply();
            userBlogger = new User() { Blogger = true, Id = 1 };
            userAdmin = new User() { Blogger = false, Id = 2 };
            article = new Article() { UserId = userBlogger.Id };
            comment = new Comment() { Reply = reply, User = userBlogger, Article = article, DateModified = DateTime.Today };
            comment2 = new Comment() { Reply = reply, User = userBlogger, Article = article, DateModified = DateTime.Parse("2022/04/03") };
            comments = new List<Comment>() { comment, comment2 };
        }

        [TestMethod]
        public void CreateComment()
        {
            commentRepository.Setup(x => x.Add(It.IsAny<Comment>())).Returns(comment);

            Comment result = commentLogic.CreateComment(comment, userBlogger);

            commentRepository.VerifyAll();
            Assert.AreEqual(result, comment);
        }

        [TestMethod]
        public void CreateCommentWithoutPermissions()
        {
            Assert.ThrowsException<UnauthorizedAccessException>(() => commentLogic.CreateComment(comment, userAdmin));
        }

        [TestMethod]
        public void DeleteComment()
        {
            commentRepository.Setup(r => r.Get(It.IsAny<Func<Comment, bool>>())).Returns(comment);
            replyLogicMock.Setup(r => r.DeleteReply(It.IsAny<int>(), It.IsAny<User>()));
            commentRepository.Setup(x => x.Update(It.IsAny<Comment>()));

            commentLogic.DeleteComment(comment.Id, userBlogger);

            commentRepository.VerifyAll();
            Assert.IsNotNull(comment.DateDeleted);
        }

        [TestMethod]
        [ExpectedException(typeof(UnauthorizedAccessException))]
        public void DeleteCommentWithoutPermissionsTest()
        {
            commentRepository.Setup(r => r.Get(It.IsAny<Func<Comment, bool>>())).Returns(comment);
            replyLogicMock.Setup(r => r.DeleteReply(It.IsAny<int>(), It.IsAny<User>()));
            commentRepository.Setup(x => x.Update(It.IsAny<Comment>()));

            commentLogic.DeleteComment(comment.Id, userAdmin);
        }


        [TestMethod]
        public void GetCommentsSinceLasLogout()
        {
            commentRepository.Setup(r => r.GetAll(It.IsAny<Func<Comment, bool>>())).Returns(comments);

            IEnumerable<Comment> result = commentLogic.GetCommentsSince(userBlogger, DateTime.Parse("2023/04/03"));

            commentRepository.VerifyAll();
            Assert.AreEqual(result.Count(), 1);
            Assert.AreEqual(result.ElementAt(0), comments.ElementAt(0));
        }

        [TestMethod]
        public void CreateReply()
        {
            replyLogicMock.Setup(r => r.CreateReply(It.IsAny<Reply>(), It.IsAny<User>())).Returns(reply);
            commentRepository.Setup(x => x.Update(It.IsAny<Comment>()));

            Reply result = commentLogic.AddReply(comment, reply, userBlogger);

            commentRepository.VerifyAll();
            Assert.AreEqual(result, reply);
        }

        [TestMethod]
        public void CreateReplyWithoutPermissions()
        {
            Assert.ThrowsException<UnauthorizedAccessException>(() => commentLogic.AddReply(comment, reply, userAdmin));
        }
    }
}

