using api.DTOs.Request;
using api.Models;
using Microsoft.EntityFrameworkCore;

namespace api.Services.TableColumnsService
{
    public class TableColumnService : ITableColumnsService
    {
        private readonly DatabaseContext _context;

        public TableColumnService(DatabaseContext context)
        {
            _context = context;
        }

        public async Task<List<UITableColumn>> GetTableColumns(string tableKey)
        {
            var columns = await _context.UITableColumns
                .Where(c => c.TableKey == tableKey)
                .ToListAsync();

            return columns;
        }

        public async Task<UITableColumn> CreateTableColumn(CreateUITableColumn data)
        {
            UITableColumn column = new UITableColumn
            {
                FriendlyName = data.Friendlyname,
                TableKey = data.TableKey,
                ValuePath = data.ValuePath,
            };

            _context.UITableColumns.Add(column);
            await _context.SaveChangesAsync();

            return column;
        }

        public async Task DeleteTableColumn(string tableKey, string valuePath)
        {
            var role = await _context.UITableColumns
                .Where(c => c.TableKey == tableKey && c.ValuePath == valuePath)
                .FirstOrDefaultAsync();

            if (role == null)
            {
                return;
            }

            _context.UITableColumns.Remove(role);
            await _context.SaveChangesAsync();
                
        }
    }
}
