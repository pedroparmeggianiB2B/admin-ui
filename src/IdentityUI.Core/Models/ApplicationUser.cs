using Microsoft.AspNetCore.Identity;
using SSRD.IdentityUI.Core.Data.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SSRD.IdentityUI.Core.Models
{
    public class ApplicationUser : IdentityUser<Guid>, IBaseEntity
    {
        public string Comments { get; set; }
        public string ClientIds { get; set; }
        public DateTimeOffset? _CreatedDate { get; set; }
        public DateTimeOffset? _ModifiedDate { get; set; }

        /// <summary>
        /// Retrieves the clientIds as an array of ints.
        /// </summary>
        /// <returns>An array of int with the clientIds.</returns>
        public int[] GetClientIds()
        {
            if (!string.IsNullOrEmpty(ClientIds))
                return ClientIds.Split(',').Select(x => int.Parse(x)).ToArray();

            return new int[1];
        }
        public ApplicationUser() { }
        public ApplicationUser(string name, string email)
        {
            UserName = name;
            Email = email;
        }
    }
}
