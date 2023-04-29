﻿using System;
namespace BlogsApp.WebAPI.DTOs
{
	public class MessageResponseDTO
	{
        public bool Success { get; set; }
        public string Message { get; set; }

        public MessageResponseDTO(bool success, string message)
        {
            Success = success;
            Message = message;
        }
    }
}

