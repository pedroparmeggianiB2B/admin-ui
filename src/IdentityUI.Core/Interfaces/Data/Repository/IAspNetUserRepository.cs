using SSRD.IdentityUI.Core.Data.Models;
using SSRD.IdentityUI.Core.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace SSRD.IdentityUI.Core.Interfaces.Data.Repository
{
    public interface IAspNetUserRepository : IBaseRepository<ApplicationUser>
    {
        List<GroupedCountData> GetRegistrations(DateTimeOffset from, DateTimeOffset to);

        int GetUsersCount();
        int GetActiveUsersCount();
        int GetUnconfirmedUsersCount();
        int GetDisabledUsersCount();
    }
}
