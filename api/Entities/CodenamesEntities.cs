using Microsoft.EntityFrameworkCore;

namespace Entities
{
    public partial class CodenamesEntities : DbContext
    {
        public CodenamesEntities() { }
        public CodenamesEntities(DbContextOptions options) : base(options) { }


        public virtual DbSet<Users> Users { get; set; }
        public virtual DbSet<Rooms> Rooms { get; set; }
        public virtual DbSet<UserRooms> UserRooms { get; set; }
        public virtual DbSet<Words> Words { get; set; }
        public virtual DbSet<RoomWords> RoomWords { get; set; }
        public virtual DbSet<EncryptionKeys> EncryptionKeys { get; set; }
        public virtual DbSet<Passwords> Passwords { get; set; }
        
        
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                optionsBuilder.UseSqlServer("Data Source=(localdb)\\ProjectsV13;Initial Catalog=codenames;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Users>(entity =>
            {
                entity.ToTable("Users", "Codenames");

                entity.HasKey(e => e.Id);

                entity.Property(e => e.Username)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.Name)
                    .IsRequired();

                entity.Property(e => e.Surname)
                    .IsRequired();

                entity.Property(e => e.Email)
                    .IsRequired();

                entity.HasOne(e => e.EncryptionKeys)
                    .WithOne(ek => ek.User)
                    .HasForeignKey<EncryptionKeys>(ek => ek.UserId);

                entity.HasOne(e => e.Passwords)
                    .WithOne(p => p.Users)
                    .HasForeignKey<Passwords>(ek => ek.UserId);
            });

            modelBuilder.Entity<Rooms>(entity =>
            {
                entity.ToTable("Rooms", "Codenames");

                entity.HasKey(e => e.Id);

                entity.Property(e => e.RoomName)
                    .IsRequired();

                entity.Property(e => e.IsActive)
                    .IsRequired()
                    .HasDefaultValue(true);
            });

            modelBuilder.Entity<UserRooms>(entity =>
            {
                entity.ToTable("UserRooms", "Codenames");

                entity.HasKey(e => new { e.UserId, e.RoomId });

                entity.HasOne(e => e.Users)
                    .WithMany(ur => ur.UserRooms)
                    .HasForeignKey(u => u.UserId);

                entity.HasOne(e => e.Rooms)
                    .WithMany(ur => ur.UserRooms)
                    .HasForeignKey(r => r.RoomId);
            });

            modelBuilder.Entity<Words>(entity =>
            {
                entity.ToTable("Words", "Codenames");

                entity.HasKey(e => e.Id);

                entity.Property(e => e.Value)
                    .IsRequired();
            });

            modelBuilder.Entity<RoomWords>(entity =>
            {
                entity.ToTable("RoomWords", "Codenames");

                entity.HasKey(e => new { e.WordId, e.RoomId });

                entity.HasOne(e => e.Rooms)
                    .WithMany(wr => wr.RoomWords)
                    .HasForeignKey(r => r.RoomId);

                entity.HasOne(e => e.Words)
                    .WithMany(wr => wr.RoomWords)
                    .HasForeignKey(w => w.WordId);
            });

            modelBuilder.Entity<Passwords>(entity =>
            {
                entity.ToTable("Passwords", "Codenames");

                entity.HasKey(e => e.Id);

                entity.Property(e => e.Value)
                    .IsRequired();
            });

            modelBuilder.Entity<EncryptionKeys>(entity =>
            {
                entity.ToTable("EncryptionKeys", "Codenames");

                entity.HasKey(e => e.Id);

                entity.Property(e => e.Value)
                    .IsRequired();
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
