using api.Models;
using api.Services.TableColumnsService;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TableColumnsController : ControllerBase
    {
        private readonly ITableColumnsService _tableColumnsService;

        public TableColumnsController(ITableColumnsService tableColumnsService)
        {
            _tableColumnsService = tableColumnsService;
        }

        [HttpGet("{tableKey}")]
        public async Task<ActionResult<List<UITableColumn>>> GetTableColumns(string tableKey)
        {
            var columns = await _tableColumnsService.GetTableColumns(tableKey);
            return Ok(columns);
        }
    }
}
