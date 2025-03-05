using api.DTOs.Request;
using api.Models;

namespace api.Services.TableColumnsService
{
    public interface ITableColumnsService
    {
        public Task<List<UITableColumn>> GetTableColumns(string tableKey);
        public Task<UITableColumn> CreateTableColumn(CreateUITableColumn data);
        public Task DeleteTableColumn(string tableKey, string valuePath);
    }
}
