using System;
using System.Collections.Generic;
using System.Text;

namespace SSRD.IdentityUI.Admin.Models.Group
{
    public class GroupUserTableModel
    {
        public long Id { get; set; }

        public string UserId { get; set; }
        public string Username { get; set; }
        public string Email { get; set; }

        public string GroupRoleId { get; set; }
        public string GroupRoleName { get; set; }

        public GroupUserTableModel(long id, string userId, string username, string email, string groupRoleId, string groupRoleName)
        {
            Id = id;

            UserId = userId;
            Username = username;
            Email = email;

            GroupRoleId = groupRoleId;
            GroupRoleName = groupRoleName;
        }
    }
}
