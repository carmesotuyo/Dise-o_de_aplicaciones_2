﻿using BlogsApp.Domain.Entities;
using BlogsApp.IBusinessLogic.Interfaces;
using BlogsApp.IDataAccess.Interfaces;
using System.Linq.Expressions;

namespace BlogsApp.BusinessLogic.Logics
{
    public class ArticleLogic : IArticleLogic
    {
        private readonly IArticleRepository _articleRepository;

        public ArticleLogic(IArticleRepository articleRepository)
        {
            _articleRepository = articleRepository;
        }

        public Article GetArticleById(int id)
        {
            return _articleRepository.Get(ArticleById(id));
        }

        public IEnumerable<Article> GetArticles(string? searchText)
        {
            if (searchText == null)
            {
                return _articleRepository.GetAll(m => m.DateDeleted == null)
                                 .OrderByDescending(m => m.DateModified)
                                 .Take(10);
            }
            else
            {
                return _articleRepository.GetAll(m => m.DateDeleted == null &&
                                              (m.Name.Contains(searchText) || m.Body.Contains(searchText)));
            }
        }

        public IEnumerable<Article> GetArticlesByUser(int userId)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<int> GetStatsByYear(int year)
        {
            throw new NotImplementedException();
        }

        private Func<Article, bool> ArticleById(int id)
        {
            return a => a.Id == id && a.DateDeleted != null;
        }



    }
}

