using Microsoft.EntityFrameworkCore.Migrations;

namespace Entities.Migrations
{
    public partial class DatabaseV1 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.EnsureSchema(
                name: "Codenames");

            migrationBuilder.CreateTable(
                name: "Rooms",
                schema: "Codenames",
                columns: table => new
                {
                    Id = table.Column<int>(nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    RoomName = table.Column<string>(nullable: false),
                    IsActive = table.Column<bool>(nullable: false, defaultValue: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Rooms", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Users",
                schema: "Codenames",
                columns: table => new
                {
                    Id = table.Column<int>(nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Username = table.Column<string>(maxLength: 50, nullable: false),
                    Name = table.Column<string>(nullable: false),
                    Surname = table.Column<string>(nullable: false),
                    Email = table.Column<string>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Users", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Words",
                schema: "Codenames",
                columns: table => new
                {
                    Id = table.Column<int>(nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Value = table.Column<string>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Words", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "EncryptionKeys",
                schema: "Codenames",
                columns: table => new
                {
                    Id = table.Column<int>(nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Value = table.Column<string>(nullable: false),
                    UserId = table.Column<int>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_EncryptionKeys", x => x.Id);
                    table.ForeignKey(
                        name: "FK_EncryptionKeys_Users_UserId",
                        column: x => x.UserId,
                        principalSchema: "Codenames",
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Passwords",
                schema: "Codenames",
                columns: table => new
                {
                    Id = table.Column<int>(nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Value = table.Column<string>(nullable: false),
                    UserId = table.Column<int>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Passwords", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Passwords_Users_UserId",
                        column: x => x.UserId,
                        principalSchema: "Codenames",
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "UserRooms",
                schema: "Codenames",
                columns: table => new
                {
                    UserId = table.Column<int>(nullable: false),
                    RoomId = table.Column<int>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_UserRooms", x => new { x.UserId, x.RoomId });
                    table.ForeignKey(
                        name: "FK_UserRooms_Rooms_RoomId",
                        column: x => x.RoomId,
                        principalSchema: "Codenames",
                        principalTable: "Rooms",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_UserRooms_Users_UserId",
                        column: x => x.UserId,
                        principalSchema: "Codenames",
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "RoomWords",
                schema: "Codenames",
                columns: table => new
                {
                    RoomId = table.Column<int>(nullable: false),
                    WordId = table.Column<int>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_RoomWords", x => new { x.WordId, x.RoomId });
                    table.ForeignKey(
                        name: "FK_RoomWords_Rooms_RoomId",
                        column: x => x.RoomId,
                        principalSchema: "Codenames",
                        principalTable: "Rooms",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_RoomWords_Words_WordId",
                        column: x => x.WordId,
                        principalSchema: "Codenames",
                        principalTable: "Words",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_EncryptionKeys_UserId",
                schema: "Codenames",
                table: "EncryptionKeys",
                column: "UserId",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Passwords_UserId",
                schema: "Codenames",
                table: "Passwords",
                column: "UserId",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_RoomWords_RoomId",
                schema: "Codenames",
                table: "RoomWords",
                column: "RoomId");

            migrationBuilder.CreateIndex(
                name: "IX_UserRooms_RoomId",
                schema: "Codenames",
                table: "UserRooms",
                column: "RoomId");

            migrationBuilder.CreateIndex(
                name: "IX_Users_Email",
                schema: "Codenames",
                table: "Users",
                column: "Email",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Users_Username",
                schema: "Codenames",
                table: "Users",
                column: "Username",
                unique: true);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "EncryptionKeys",
                schema: "Codenames");

            migrationBuilder.DropTable(
                name: "Passwords",
                schema: "Codenames");

            migrationBuilder.DropTable(
                name: "RoomWords",
                schema: "Codenames");

            migrationBuilder.DropTable(
                name: "UserRooms",
                schema: "Codenames");

            migrationBuilder.DropTable(
                name: "Words",
                schema: "Codenames");

            migrationBuilder.DropTable(
                name: "Rooms",
                schema: "Codenames");

            migrationBuilder.DropTable(
                name: "Users",
                schema: "Codenames");
        }
    }
}
