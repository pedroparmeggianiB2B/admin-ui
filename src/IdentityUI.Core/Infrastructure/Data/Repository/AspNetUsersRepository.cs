using SSRD.IdentityUI.Core.Data.Models;
using SSRD.IdentityUI.Core.Interfaces.Data.Repository;
using SSRD.IdentityUI.Core.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace SSRD.IdentityUI.Core.Infrastructure.Data.Repository
{
    internal class AspNetUsersRepository : BaseRepository<ApplicationUser>, IAspNetUserRepository
    {
        public AspNetUsersRepository(IdentityDbContext context) : base(context)
        {
        }

        public int GetActiveUsersCount()
        {
            throw new NotImplementedException();
        }

        public int GetDisabledUsersCount()
        {
            throw new NotImplementedException();
        }

        public List<GroupedCountData> GetRegistrations(DateTimeOffset from, DateTimeOffset to)
        {
            throw new NotImplementedException();
        }

        public int GetUnconfirmedUsersCount()
        {
            throw new NotImplementedException();
        }

        public int GetUsersCount()
        {
            throw new NotImplementedException();
        }
    }
}
