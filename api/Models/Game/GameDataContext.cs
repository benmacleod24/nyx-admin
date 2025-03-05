using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using Pomelo.EntityFrameworkCore.MySql.Scaffolding.Internal;

namespace api.Models.Game;

public partial class GameDataContext : DbContext
{
    public GameDataContext()
    {
    }

    public GameDataContext(DbContextOptions<GameDataContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Ban> Bans { get; set; }

    public virtual DbSet<Player> Players { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder
            .UseCollation("utf8mb4_uca1400_ai_ci")
            .HasCharSet("utf8mb4");

        modelBuilder.Entity<Ban>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity
                .ToTable("bans")
                .UseCollation("utf8mb4_general_ci");

            entity.HasIndex(e => e.Discord, "discord");

            entity.HasIndex(e => e.Ip, "ip");

            entity.HasIndex(e => e.License, "license");

            entity.Property(e => e.Id)
                .HasColumnType("int(11)")
                .HasColumnName("id");
            entity.Property(e => e.Bannedby)
                .HasMaxLength(255)
                .HasDefaultValueSql("'LeBanhammer'")
                .HasColumnName("bannedby");
            entity.Property(e => e.Discord)
                .HasMaxLength(50)
                .HasColumnName("discord");
            entity.Property(e => e.Expire)
                .HasColumnType("int(11)")
                .HasColumnName("expire");
            entity.Property(e => e.Ip)
                .HasMaxLength(50)
                .HasColumnName("ip");
            entity.Property(e => e.License)
                .HasMaxLength(50)
                .HasColumnName("license");
            entity.Property(e => e.Name)
                .HasMaxLength(50)
                .HasColumnName("name");
            entity.Property(e => e.Reason)
                .HasColumnType("text")
                .HasColumnName("reason");
        });

        modelBuilder.Entity<Player>(entity =>
        {
            entity.HasKey(e => e.Citizenid).HasName("PRIMARY");

            entity
                .ToTable("players")
                .UseCollation("utf8mb4_general_ci");

            entity.HasIndex(e => e.Id, "id");

            entity.HasIndex(e => e.LastUpdated, "last_updated");

            entity.HasIndex(e => e.License, "license");

            entity.Property(e => e.Citizenid)
                .HasMaxLength(50)
                .HasColumnName("citizenid");
            entity.Property(e => e.Charinfo)
                .HasColumnType("text")
                .HasColumnName("charinfo")
                .HasConversion(v => JsonConvert.SerializeObject(v), v => JsonConvert.DeserializeObject<CharInfo>(v));
            entity.Property(e => e.Cid)
                .HasColumnType("int(11)")
                .HasColumnName("cid");
            entity.Property(e => e.CrmAvatarId)
                .HasDefaultValueSql("'1'")
                .HasColumnType("int(11)")
                .HasColumnName("crm_avatar_id");
            entity.Property(e => e.CrmCk)
                .HasColumnType("int(11)")
                .HasColumnName("crm_ck");
            entity.Property(e => e.CrmFavorite)
                .HasColumnType("int(11)")
                .HasColumnName("crm_favorite");
            entity.Property(e => e.CrmIsPremium)
                .HasMaxLength(50)
                .HasDefaultValueSql("'0'")
                .HasColumnName("crm_is_premium");
            entity.Property(e => e.CrmSlot)
                .HasDefaultValueSql("-1")
                .HasColumnType("int(11)")
                .HasColumnName("crm_slot");
            entity.Property(e => e.CrmTattoos)
                .HasDefaultValueSql("''")
                .HasColumnType("text")
                .HasColumnName("crm_tattoos");
            entity.Property(e => e.CryptoWalletId)
                .HasColumnType("text")
                .HasColumnName("crypto_wallet_id");
            entity.Property(e => e.Cryptocurrency)
                .HasDefaultValueSql("''")
                .HasColumnName("cryptocurrency");
            entity.Property(e => e.Gang)
                .HasColumnType("text")
                .HasColumnName("gang")
                .HasConversion(v => JsonConvert.SerializeObject(v), v => JsonConvert.DeserializeObject<GangAffiliation>(v));
            entity.Property(e => e.Id)
                .ValueGeneratedOnAdd()
                .HasColumnType("int(11)")
                .HasColumnName("id");
            entity.Property(e => e.Inside)
                .HasMaxLength(50)
                .HasDefaultValueSql("''")
                .HasColumnName("inside");
            entity.Property(e => e.Inventory).HasColumnName("inventory");
            entity.Property(e => e.Job)
                .HasColumnType("text")
                .HasColumnName("job")
                .HasConversion(v => JsonConvert.SerializeObject(v), v => JsonConvert.DeserializeObject<PlayerJob>(v));
            entity.Property(e => e.LastUpdated)
                .ValueGeneratedOnAddOrUpdate()
                .HasDefaultValueSql("current_timestamp()")
                .HasColumnType("timestamp")
                .HasColumnName("last_updated");
            entity.Property(e => e.License).HasColumnName("license");
            entity.Property(e => e.Metadata)
                .HasColumnType("text")
                .HasColumnName("metadata");
            entity.Property(e => e.Money)
                .HasColumnType("text")
                .HasColumnName("money")
                .HasConversion(v => JsonConvert.SerializeObject(v), v => JsonConvert.DeserializeObject<PlayerMoney>(v))
                .UseCollation("utf8mb4_bin");
            entity.Property(e => e.Name)
                .HasMaxLength(255)
                .HasColumnName("name");
            entity.Property(e => e.PhoneNumber)
                .HasMaxLength(20)
                .HasColumnName("phone_number");
            entity.Property(e => e.Position)
                .HasColumnType("text")
                .HasColumnName("position");
        });



        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
