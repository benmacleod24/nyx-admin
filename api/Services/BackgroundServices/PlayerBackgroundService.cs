using api.Models;
using Quartz;

namespace api.Services.BackgroundServices
{
    public class PlayerBackgroundService : IJob
    {
        private readonly DatabaseContext _context;

        public PlayerBackgroundService(DatabaseContext context)
        {  
           _context = context; 
        }

        public Task Execute(IJobExecutionContext context)
        {
            return Task.CompletedTask;
        }
    }
}