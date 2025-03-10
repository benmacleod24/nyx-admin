using api.DTOs.Request;
using api.DTOs.Response;
using api.Models;
using api.Services.CitizenService;
using AutoMapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Query;
using System.ComponentModel;

namespace api.Services.RemarksService
{
    public class RemarksService : IRemarksService
    {
        private readonly DatabaseContext _context;
        private readonly IMapper _mapper;
        private readonly ICitizenService _citizenService;

        public RemarksService(DatabaseContext context, IMapper mapper, ICitizenService citizenService)
        {
            _context = context;
            _mapper = mapper;
            _citizenService = citizenService;
        }

        public async Task<List<RemarkDTO>> GetPlayerRemarks(string license, int? limit)
        {
            List<PlayerRemark> remarks = await _context.PlayerRemarks
                 .Where(r => r.License == license)
                 .OrderByDescending(r => r.Created)
                 .Take(limit ?? int.MaxValue)
                 .Include(r => r.User)
                 .ToListAsync();

            return _mapper.Map<List<RemarkDTO>>(remarks);
        }

        public async Task<PaginationResponseDTO<RemarkDTO>> GetRemarksByCitizenId(string citizenId, PaginationRequestDTO pagination, string where = "")
        {
            CitizenDTO? citizen = await _citizenService.GetCitizenById(citizenId);

            if (citizen == null) return new PaginationResponseDTO<RemarkDTO>
            {
                Items = new List<RemarkDTO>(),
                TotalPages = 0,
            };

            IQueryable<PlayerRemark> query = _context.PlayerRemarks
                .Where(r => r.License == citizen.License)
                .Include(r => r.User);

            // Apply search filter if provided
            if (!string.IsNullOrWhiteSpace(where))
            {
                query = query.Where(r => r.Content.ToLower().Contains(where.ToLower()) || r.User.Username.ToLower().Contains(where.ToLower()));
            }

            var totalNumberOfItems = await query.CountAsync();

            // Order, paginate, and map
            var remarks = await query
                .OrderByDescending(r => r.Created)
                .Skip((pagination.Page - 1) * pagination.Size)
                .Take(pagination.Size)
                .ToListAsync();

            return new PaginationResponseDTO<RemarkDTO>
            {
                Items = _mapper.Map<List<RemarkDTO>>(remarks),
                TotalPages = (int)Math.Ceiling((decimal)totalNumberOfItems / (decimal)pagination.Size),
            };
        }

        public async Task<RemarkDTO> CreateRemark(CreateRemarkDTO data, int userId)
        {
            PlayerRemark remark = new PlayerRemark
            {
                Content = data.Content,
                License = data.License,
                UserId = userId,
            };

            _context.PlayerRemarks.Add(remark);
            await _context.SaveChangesAsync();

            return _mapper.Map<RemarkDTO>(remark);
        }
    }
}
