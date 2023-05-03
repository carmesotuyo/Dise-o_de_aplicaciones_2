﻿using BlogsApp.Logging.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BlogsApp.Logging.Services
{
    public interface ILogEntryRepository
    {
        void Add(LogEntry logEntry);
        ICollection<LogEntry> GetLogsByActionTypeAndDates(string actionType, DateTime startDate, DateTime endDate);
    }
}
