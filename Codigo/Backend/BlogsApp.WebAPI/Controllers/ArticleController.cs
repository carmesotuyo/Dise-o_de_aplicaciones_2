using BlogsApp.IBusinessLogic.Interfaces;
using Microsoft.AspNetCore.Mvc;
using BlogsApp.WebAPI.Filters;
using BlogsApp.Domain.Entities;
using BlogsApp.WebAPI.DTOs;
using BlogsApp.Logging.Logic.Services;

namespace BlogsApp.WebAPI.Controllers
{
    [Route("api/articles")]
    [ServiceFilter(typeof(AuthorizationFilter))]
    public class ArticleController : BlogsAppControllerBase
    {
        private readonly IArticleLogic articleLogic;
        private readonly ISessionLogic sessionLogic;
        private readonly ILoggerService loggerService;

        public ArticleController(IArticleLogic articleLogic, ISessionLogic sessionLogic, ILoggerService loggerService)
        {
            this.articleLogic = articleLogic;
            this.sessionLogic = sessionLogic;
            this.loggerService = loggerService;
        }

        [HttpGet]
        public IActionResult Get([FromQuery] string? search, [FromHeader] string token)
        {
            Guid tokenGuid = Guid.Parse(token);
            User loggedUser = sessionLogic.GetUserFromToken(tokenGuid);
            if (search != null) {
                loggerService.LogSearch(loggedUser.Id, search);
            };
            return new OkObjectResult(articleLogic.GetArticles(loggedUser, search));
        }

        [HttpGet("{id}")]
        public IActionResult GetArticleById([FromRoute] int id, [FromHeader] string token)
        {
            Guid tokenGuid = Guid.Parse(token);
            User loggedUser = sessionLogic.GetUserFromToken(tokenGuid);
            return new OkObjectResult(articleLogic.GetArticleById(id, loggedUser));
        }

        [HttpGet("stats")]
        public IActionResult GetStatsByYear([FromQuery] int year, [FromHeader] string token)
        {
            Guid tokenGuid = Guid.Parse(token);
            User loggedUser = sessionLogic.GetUserFromToken(tokenGuid);
            return new OkObjectResult(articleLogic.GetStatsByYear(year, loggedUser));
        }

        [HttpDelete("{id}")]
        public IActionResult DeleteArticle([FromRoute] int id, [FromHeader] string token)
        {
            Guid tokenGuid = Guid.Parse(token);
            User loggedUser = sessionLogic.GetUserFromToken(tokenGuid);
            articleLogic.DeleteArticle(id, loggedUser);
            return new OkResult();
        }

        [HttpPost]
        public IActionResult PostArticle([FromBody] CreateArticleRequestDto articleDto, [FromHeader] string token)
        {
            Guid tokenGuid = Guid.Parse(token);
            User loggedUser = sessionLogic.GetUserFromToken(tokenGuid);
            Article article = ArticleConverter.FromDto(articleDto, loggedUser);
            Article newArticle = articleLogic.CreateArticle(article, loggedUser);
            return new OkObjectResult(ArticleConverter.ToDto(newArticle));
        }

        [HttpPut("{id}")]
        public IActionResult UpdateArticle([FromRoute] int id, [FromBody] Article article, [FromHeader] string token)
        {
            Guid tokenGuid = Guid.Parse(token);
            User loggedUser = sessionLogic.GetUserFromToken(tokenGuid);
            return new OkObjectResult(articleLogic.UpdateArticle(id, article, loggedUser));
        }
    }
}