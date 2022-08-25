using Microsoft.EntityFrameworkCore.Migrations;

namespace Entities.Migrations
{
    public partial class Database_v1 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ExcryptionKeys_Users_UserId",
                schema: "Codenames",
                table: "ExcryptionKeys");

            migrationBuilder.DropPrimaryKey(
                name: "PK_ExcryptionKeys",
                schema: "Codenames",
                table: "ExcryptionKeys");

            migrationBuilder.RenameTable(
                name: "ExcryptionKeys",
                schema: "Codenames",
                newName: "EncryptionKeys",
                newSchema: "Codenames");

            migrationBuilder.RenameIndex(
                name: "IX_ExcryptionKeys_UserId",
                schema: "Codenames",
                table: "EncryptionKeys",
                newName: "IX_EncryptionKeys_UserId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_EncryptionKeys",
                schema: "Codenames",
                table: "EncryptionKeys",
                column: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_EncryptionKeys_Users_UserId",
                schema: "Codenames",
                table: "EncryptionKeys",
                column: "UserId",
                principalSchema: "Codenames",
                principalTable: "Users",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_EncryptionKeys_Users_UserId",
                schema: "Codenames",
                table: "EncryptionKeys");

            migrationBuilder.DropPrimaryKey(
                name: "PK_EncryptionKeys",
                schema: "Codenames",
                table: "EncryptionKeys");

            migrationBuilder.RenameTable(
                name: "EncryptionKeys",
                schema: "Codenames",
                newName: "ExcryptionKeys",
                newSchema: "Codenames");

            migrationBuilder.RenameIndex(
                name: "IX_EncryptionKeys_UserId",
                schema: "Codenames",
                table: "ExcryptionKeys",
                newName: "IX_ExcryptionKeys_UserId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_ExcryptionKeys",
                schema: "Codenames",
                table: "ExcryptionKeys",
                column: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_ExcryptionKeys_Users_UserId",
                schema: "Codenames",
                table: "ExcryptionKeys",
                column: "UserId",
                principalSchema: "Codenames",
                principalTable: "Users",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
