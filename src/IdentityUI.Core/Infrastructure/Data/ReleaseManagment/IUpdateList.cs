using System;
using System.Collections.Generic;
using System.Text;

namespace SSRD.IdentityUI.Core.Infrastructure.Data.ReleaseManagment
{
    public interface IUpdateList
    {
        IEnumerable<IUpdate> Get();
    }
}
