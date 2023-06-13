﻿using BlogsApp.Domain.Enums;
namespace BlogsApp.Domain.Entities
{
    public class Comment
    {
        public int Id { get; set; }
        public User User { get;  set; }
        public string Body { get; set; }
        public Article Article { get; set; }
        public ICollection<Comment> SubComments { get; set; }
        public DateTime DateCreated { get; set; }
        public DateTime DateModified { get; set; }
        public DateTime? DateDeleted { get; set; }
        public ContentState State { get; set; }
        public ICollection<OffensiveWord> OffensiveWords { get; set; }

        public Comment(User user, string body, Article article)
        {
            User = user;
            Body = body;
            Article = article;
            DateCreated = DateTime.Now;
            DateModified = DateTime.Now;
            SubComments = new List<Comment>();
            OffensiveWords = new List<OffensiveWord>();
        }

        public Comment() { SubComments = new List<Comment>(); }
    }
}
