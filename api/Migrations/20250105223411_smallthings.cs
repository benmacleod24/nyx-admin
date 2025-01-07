using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace api.Migrations
{
    /// <inheritdoc />
    public partial class smallthings : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<bool>(
                name: "CanBeDeleted",
                table: "Roles",
                type: "tinyint(1)",
                nullable: false,
                defaultValue: false);

            migrationBuilder.UpdateData(
                table: "Permissions",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "Description", "FriendlyName", "Key" },
                values: new object[] { "Allow the user to view roles.", "View Roles", "VIEW_ROLES" });

            migrationBuilder.InsertData(
                table: "Permissions",
                columns: new[] { "Id", "Description", "FriendlyName", "Key" },
                values: new object[,]
                {
                    { 2, "Allow the user to create new roles.", "Create Roles", "CREATE_ROLE" },
                    { 3, "Allow the user to modify role permissions and order. Keep in mind they will be able to modify any permissions for roles below them.", "Modify Roles", "MODIFY_ROLES" },
                    { 4, "Allow the user to delete roles.", "Delete Roles", "DELETE_ROLES" }
                });

            migrationBuilder.UpdateData(
                table: "Roles",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CanBeDeleted", "CreatedAt" },
                values: new object[] { false, new DateTime(2025, 1, 5, 22, 34, 11, 570, DateTimeKind.Utc).AddTicks(800) });

            migrationBuilder.UpdateData(
                table: "Roles",
                keyColumn: "Id",
                keyValue: 2,
                columns: new[] { "CanBeDeleted", "CreatedAt" },
                values: new object[] { false, new DateTime(2025, 1, 5, 22, 34, 11, 570, DateTimeKind.Utc).AddTicks(810) });

            migrationBuilder.InsertData(
                table: "RolePermissions",
                columns: new[] { "Id", "PermissionId", "RoleId" },
                values: new object[,]
                {
                    { 2, 2, 1 },
                    { 3, 3, 1 },
                    { 4, 4, 1 }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "RolePermissions",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "RolePermissions",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "RolePermissions",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Permissions",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Permissions",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Permissions",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DropColumn(
                name: "CanBeDeleted",
                table: "Roles");

            migrationBuilder.UpdateData(
                table: "Permissions",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "Description", "FriendlyName", "Key" },
                values: new object[] { null, "View System Settings", "VIEW_SYSTEM_SETTINGS" });

            migrationBuilder.UpdateData(
                table: "Roles",
                keyColumn: "Id",
                keyValue: 1,
                column: "CreatedAt",
                value: new DateTime(2025, 1, 5, 0, 18, 22, 189, DateTimeKind.Utc).AddTicks(2670));

            migrationBuilder.UpdateData(
                table: "Roles",
                keyColumn: "Id",
                keyValue: 2,
                column: "CreatedAt",
                value: new DateTime(2025, 1, 5, 0, 18, 22, 189, DateTimeKind.Utc).AddTicks(2670));
        }
    }
}
