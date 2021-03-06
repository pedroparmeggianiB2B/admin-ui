ALTER TABLE "UserClaims" ALTER COLUMN "Id" TYPE integer;
ALTER TABLE "UserClaims" ALTER COLUMN "Id" SET NOT NULL;
ALTER SEQUENCE "UserClaims_Id_seq" RENAME TO "UserClaims_Id_old_seq";
ALTER TABLE "UserClaims" ALTER COLUMN "Id" DROP DEFAULT;
ALTER TABLE "UserClaims" ALTER COLUMN "Id" ADD GENERATED BY DEFAULT AS IDENTITY;
SELECT * FROM setval('"UserClaims_Id_seq"', nextval('"UserClaims_Id_old_seq"'), false);
DROP SEQUENCE "UserClaims_Id_old_seq";

ALTER TABLE "Sessions" ALTER COLUMN "Id" TYPE bigint;
ALTER TABLE "Sessions" ALTER COLUMN "Id" SET NOT NULL;
ALTER SEQUENCE "Sessions_Id_seq" RENAME TO "Sessions_Id_old_seq";
ALTER TABLE "Sessions" ALTER COLUMN "Id" DROP DEFAULT;
ALTER TABLE "Sessions" ALTER COLUMN "Id" ADD GENERATED BY DEFAULT AS IDENTITY;
SELECT * FROM setval('"Sessions_Id_seq"', nextval('"Sessions_Id_old_seq"'), false);
DROP SEQUENCE "Sessions_Id_old_seq";

ALTER TABLE "Roles" ADD "Type" integer NOT NULL DEFAULT 1;

ALTER TABLE "RoleClaims" ALTER COLUMN "Id" TYPE integer;
ALTER TABLE "RoleClaims" ALTER COLUMN "Id" SET NOT NULL;
ALTER SEQUENCE "RoleClaims_Id_seq" RENAME TO "RoleClaims_Id_old_seq";
ALTER TABLE "RoleClaims" ALTER COLUMN "Id" DROP DEFAULT;
ALTER TABLE "RoleClaims" ALTER COLUMN "Id" ADD GENERATED BY DEFAULT AS IDENTITY;
SELECT * FROM setval('"RoleClaims_Id_seq"', nextval('"RoleClaims_Id_old_seq"'), false);
DROP SEQUENCE "RoleClaims_Id_old_seq";

CREATE TABLE "Emails" (
    "Id" bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY,
    "Subject" text NOT NULL,
    "Body" text NOT NULL,
    "Type" integer NOT NULL,
    "_CreatedDate" timestamp with time zone NULL,
    "_ModifiedDate" timestamp with time zone NULL,
    CONSTRAINT "PK_Emails" PRIMARY KEY ("Id")
);

CREATE TABLE "Groups" (
    "Id" text NOT NULL,
    "Name" text NOT NULL,
    "_CreatedDate" timestamp with time zone NULL,
    "_ModifiedDate" timestamp with time zone NULL,
    CONSTRAINT "PK_Groups" PRIMARY KEY ("Id")
);

CREATE TABLE "Permissions" (
    "Id" text NOT NULL,
    "Name" text NOT NULL,
    "Description" text NULL,
    "_CreatedDate" timestamp with time zone NULL,
    "_ModifiedDate" timestamp with time zone NULL,
    CONSTRAINT "PK_Permissions" PRIMARY KEY ("Id")
);

CREATE TABLE "RoleAssignments" (
    "Id" bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY,
    "RoleId" text NOT NULL,
    "CanAssigneRoleId" text NOT NULL,
    "_CreatedDate" timestamp with time zone NULL,
    "_ModifiedDate" timestamp with time zone NULL,
    CONSTRAINT "PK_RoleAssignments" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_RoleAssignments_Roles_CanAssigneRoleId" FOREIGN KEY ("CanAssigneRoleId") REFERENCES "Roles" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_RoleAssignments_Roles_RoleId" FOREIGN KEY ("RoleId") REFERENCES "Roles" ("Id") ON DELETE CASCADE
);

CREATE TABLE "GroupAttributes" (
    "Id" bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY,
    "Key" text NOT NULL,
    "Value" text NULL,
    "GroupId" text NOT NULL,
    "_CreatedDate" timestamp with time zone NULL,
    "_ModifiedDate" timestamp with time zone NULL,
    CONSTRAINT "PK_GroupAttributes" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_GroupAttributes_Groups_GroupId" FOREIGN KEY ("GroupId") REFERENCES "Groups" ("Id") ON DELETE CASCADE
);

CREATE TABLE "GroupUsers" (
    "Id" bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY,
    "UserId" text NOT NULL,
    "GroupId" text NOT NULL,
    "RoleId" text NULL,
    "_CreatedDate" timestamp with time zone NULL,
    "_ModifiedDate" timestamp with time zone NULL,
    CONSTRAINT "PK_GroupUsers" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_GroupUsers_Groups_GroupId" FOREIGN KEY ("GroupId") REFERENCES "Groups" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_GroupUsers_Roles_RoleId" FOREIGN KEY ("RoleId") REFERENCES "Roles" ("Id") ON DELETE SET NULL,
    CONSTRAINT "FK_GroupUsers_Users_UserId" FOREIGN KEY ("UserId") REFERENCES "Users" ("Id") ON DELETE CASCADE
);

CREATE TABLE "Invite" (
    "Id" text NOT NULL,
    "Email" text NOT NULL,
    "Token" text NOT NULL,
    "Status" integer NOT NULL,
    "RoleId" text NULL,
    "GroupId" text NULL,
    "GroupRoleId" text NULL,
    "ExpiresAt" timestamp with time zone NOT NULL,
    "_CreatedDate" timestamp with time zone NULL,
    "_ModifiedDate" timestamp with time zone NULL,
    CONSTRAINT "PK_Invite" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_Invite_Groups_GroupId" FOREIGN KEY ("GroupId") REFERENCES "Groups" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_Invite_Roles_GroupRoleId" FOREIGN KEY ("GroupRoleId") REFERENCES "Roles" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_Invite_Roles_RoleId" FOREIGN KEY ("RoleId") REFERENCES "Roles" ("Id") ON DELETE RESTRICT
);

CREATE TABLE "PermissionRole" (
    "Id" bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY,
    "PermissionId" text NOT NULL,
    "RoleId" text NOT NULL,
    "_CreatedDate" timestamp with time zone NULL,
    "_ModifiedDate" timestamp with time zone NULL,
    CONSTRAINT "PK_PermissionRole" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_PermissionRole_Permissions_PermissionId" FOREIGN KEY ("PermissionId") REFERENCES "Permissions" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_PermissionRole_Roles_RoleId" FOREIGN KEY ("RoleId") REFERENCES "Roles" ("Id") ON DELETE CASCADE
);

CREATE INDEX "IX_GroupAttributes_GroupId" ON "GroupAttributes" ("GroupId");

CREATE INDEX "IX_GroupAttributes_Key" ON "GroupAttributes" ("Key");

CREATE INDEX "IX_GroupUsers_GroupId" ON "GroupUsers" ("GroupId");

CREATE INDEX "IX_GroupUsers_RoleId" ON "GroupUsers" ("RoleId");

CREATE INDEX "IX_GroupUsers_UserId" ON "GroupUsers" ("UserId");

CREATE INDEX "IX_Invite_GroupId" ON "Invite" ("GroupId");

CREATE INDEX "IX_Invite_GroupRoleId" ON "Invite" ("GroupRoleId");

CREATE INDEX "IX_Invite_RoleId" ON "Invite" ("RoleId");

CREATE INDEX "IX_PermissionRole_PermissionId" ON "PermissionRole" ("PermissionId");

CREATE INDEX "IX_PermissionRole_RoleId" ON "PermissionRole" ("RoleId");

CREATE INDEX "IX_RoleAssignments_CanAssigneRoleId" ON "RoleAssignments" ("CanAssigneRoleId");

CREATE INDEX "IX_RoleAssignments_RoleId" ON "RoleAssignments" ("RoleId");

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20200512083339_AddPermissionsAddGroups', '3.1.3');

