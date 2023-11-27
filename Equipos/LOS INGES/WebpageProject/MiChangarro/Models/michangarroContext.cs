using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace MiChangarro.Models
{
    public partial class michangarroContext : DbContext
    {
        public michangarroContext()
        {
        }

        public michangarroContext(DbContextOptions<michangarroContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Categorium> Categoria { get; set; } = null!;
        public virtual DbSet<Cliente> Clientes { get; set; } = null!;
        public virtual DbSet<Dependiente> Dependientes { get; set; } = null!;
        public virtual DbSet<Empleado> Empleados { get; set; } = null!;
        public virtual DbSet<EmpleadoPuesto> EmpleadoPuestos { get; set; } = null!;
        public virtual DbSet<Factura> Facturas { get; set; } = null!;
        public virtual DbSet<Horario> Horarios { get; set; } = null!;
        public virtual DbSet<Orden> Ordens { get; set; } = null!;
        public virtual DbSet<Producto> Productos { get; set; } = null!;
        public virtual DbSet<ProductoOrden> ProductoOrdens { get; set; } = null!;
        public virtual DbSet<Puesto> Puestos { get; set; } = null!;
        public virtual DbSet<VistaFactura> VistaFacturas { get; set; } = null!;

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
                optionsBuilder.UseNpgsql("Host=final-project-db.postgres.database.azure.com;Database=michangarro;Username=WallsAdmin;Password=Donor_Reply8_Connector");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Categorium>(entity =>
            {
                entity.ToTable("categoria");

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.Descripcion)
                    .HasMaxLength(200)
                    .HasColumnName("descripcion");

                entity.Property(e => e.Nombre)
                    .HasMaxLength(100)
                    .HasColumnName("nombre");
            });

            modelBuilder.Entity<Cliente>(entity =>
            {
                entity.ToTable("cliente");

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.Domicilio)
                    .HasMaxLength(200)
                    .HasColumnName("domicilio");

                entity.Property(e => e.Email)
                    .HasMaxLength(100)
                    .HasColumnName("email");

                entity.Property(e => e.FechaNacimiento).HasColumnName("fecha_nacimiento");

                entity.Property(e => e.Nombre)
                    .HasMaxLength(100)
                    .HasColumnName("nombre");

                entity.Property(e => e.RazonSocial)
                    .HasMaxLength(100)
                    .HasColumnName("razon_social");

                entity.Property(e => e.Rfc)
                    .HasMaxLength(13)
                    .HasColumnName("rfc");
            });

            modelBuilder.Entity<Dependiente>(entity =>
            {
                entity.ToTable("dependiente");

                entity.HasIndex(e => e.EmpleadoId, "idx_dependiente_empleado_id");

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.Curp)
                    .HasMaxLength(18)
                    .HasColumnName("curp");

                entity.Property(e => e.EmpleadoId).HasColumnName("empleado_id");

                entity.Property(e => e.Nombre)
                    .HasMaxLength(100)
                    .HasColumnName("nombre");

                entity.Property(e => e.Parentesco)
                    .HasMaxLength(50)
                    .HasColumnName("parentesco");

                entity.HasOne(d => d.Empleado)
                    .WithMany(p => p.Dependientes)
                    .HasForeignKey(d => d.EmpleadoId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("dependiente_empleado_id_fkey");
            });

            modelBuilder.Entity<Empleado>(entity =>
            {
                entity.ToTable("empleado");

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.ApellidoMaterno)
                    .HasMaxLength(100)
                    .HasColumnName("apellido_materno");

                entity.Property(e => e.ApellidoPaterno)
                    .HasMaxLength(100)
                    .HasColumnName("apellido_paterno");

                entity.Property(e => e.Domicilio)
                    .HasMaxLength(200)
                    .HasColumnName("domicilio");

                entity.Property(e => e.Edad).HasColumnName("edad");

                entity.Property(e => e.EspecialidadCocinero)
                    .HasMaxLength(100)
                    .HasColumnName("especialidad_cocinero");

                entity.Property(e => e.FechaNacimiento).HasColumnName("fecha_nacimiento");

                entity.Property(e => e.Foto).HasColumnName("foto");

                entity.Property(e => e.Nombre)
                    .HasMaxLength(100)
                    .HasColumnName("nombre");

                entity.Property(e => e.NumEmpleado).HasColumnName("num_empleado");

                entity.Property(e => e.Rfc)
                    .HasMaxLength(13)
                    .HasColumnName("rfc");

                entity.Property(e => e.RolAdministrativo)
                    .HasMaxLength(100)
                    .HasColumnName("rol_administrativo");

                entity.Property(e => e.Sueldo)
                    .HasPrecision(10, 2)
                    .HasColumnName("sueldo");

                entity.Property(e => e.Telefono)
                    .HasMaxLength(20)
                    .HasColumnName("telefono");
            });

            modelBuilder.Entity<EmpleadoPuesto>(entity =>
            {
                entity.ToTable("empleado_puesto");

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.EmpleadoId).HasColumnName("empleado_id");

                entity.Property(e => e.PuestoId).HasColumnName("puesto_id");

                entity.HasOne(d => d.Empleado)
                    .WithMany(p => p.EmpleadoPuestos)
                    .HasForeignKey(d => d.EmpleadoId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("empleado_puesto_empleado_id_fkey");

                entity.HasOne(d => d.Puesto)
                    .WithMany(p => p.EmpleadoPuestos)
                    .HasForeignKey(d => d.PuestoId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("empleado_puesto_puesto_id_fkey");
            });

            modelBuilder.Entity<Factura>(entity =>
            {
                entity.HasNoKey();

                entity.ToView("factura");

                entity.Property(e => e.CantidadTotal)
                    .HasPrecision(10, 2)
                    .HasColumnName("cantidad_total");

                entity.Property(e => e.FechaHora)
                    .HasColumnType("timestamp without time zone")
                    .HasColumnName("fecha_hora");

                entity.Property(e => e.Folio).HasColumnName("folio");

                entity.Property(e => e.Mesero).HasColumnName("mesero");
            });

            modelBuilder.Entity<Horario>(entity =>
            {
                entity.ToTable("horario");

                entity.HasIndex(e => e.MeseroId, "idx_horario_mesero_id");

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.HoraEntrada).HasColumnName("hora_entrada");

                entity.Property(e => e.HoraSalida).HasColumnName("hora_salida");

                entity.Property(e => e.MeseroId).HasColumnName("mesero_id");

                entity.HasOne(d => d.Mesero)
                    .WithMany(p => p.Horarios)
                    .HasForeignKey(d => d.MeseroId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("horario_mesero_id_fkey");
            });

            modelBuilder.Entity<Orden>(entity =>
            {
                entity.ToTable("orden");

                entity.HasIndex(e => e.MeseroId, "idx_orden_mesero_id");

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.CantidadTotal)
                    .HasPrecision(10, 2)
                    .HasColumnName("cantidad_total");

                entity.Property(e => e.ClienteId).HasColumnName("cliente_id");

                entity.Property(e => e.FechaHora)
                    .HasColumnType("timestamp without time zone")
                    .HasColumnName("fecha_hora");

                entity.Property(e => e.Folio)
                    .HasMaxLength(50)
                    .HasColumnName("folio");

                entity.Property(e => e.MeseroId).HasColumnName("mesero_id");

                entity.HasOne(d => d.Cliente)
                    .WithMany(p => p.Ordens)
                    .HasForeignKey(d => d.ClienteId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("orden_cliente_id_fkey");

                entity.HasOne(d => d.Mesero)
                    .WithMany(p => p.Ordens)
                    .HasForeignKey(d => d.MeseroId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("orden_mesero_id_fkey");
            });

            modelBuilder.Entity<Producto>(entity =>
            {
                entity.ToTable("producto");

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.CategoriaId).HasColumnName("categoria_id");

                entity.Property(e => e.Descripcion)
                    .HasMaxLength(200)
                    .HasColumnName("descripcion");

                entity.Property(e => e.Disponible).HasColumnName("disponible");

                entity.Property(e => e.Nombre)
                    .HasMaxLength(100)
                    .HasColumnName("nombre");

                entity.Property(e => e.Precio)
                    .HasPrecision(10, 2)
                    .HasColumnName("precio");

                entity.Property(e => e.Receta).HasColumnName("receta");

                entity.HasOne(d => d.Categoria)
                    .WithMany(p => p.Productos)
                    .HasForeignKey(d => d.CategoriaId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("producto_categoria_id_fkey");
            });

            modelBuilder.Entity<ProductoOrden>(entity =>
            {
                entity.ToTable("producto_orden");

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.Cantidad).HasColumnName("cantidad");

                entity.Property(e => e.OrdenId).HasColumnName("orden_id");

                entity.Property(e => e.PrecioTotal)
                    .HasPrecision(10, 2)
                    .HasColumnName("precio_total");

                entity.Property(e => e.ProductoId).HasColumnName("producto_id");

                entity.HasOne(d => d.Orden)
                    .WithMany(p => p.ProductoOrdens)
                    .HasForeignKey(d => d.OrdenId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("producto_orden_orden_id_fkey");

                entity.HasOne(d => d.Producto)
                    .WithMany(p => p.ProductoOrdens)
                    .HasForeignKey(d => d.ProductoId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("producto_orden_producto_id_fkey");
            });

            modelBuilder.Entity<Puesto>(entity =>
            {
                entity.ToTable("puesto");

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.Descripcion)
                    .HasMaxLength(200)
                    .HasColumnName("descripcion");

                entity.Property(e => e.Nombre)
                    .HasMaxLength(50)
                    .HasColumnName("nombre");
            });

            modelBuilder.Entity<VistaFactura>(entity =>
            {
                entity.HasNoKey();

                entity.ToView("vista_factura");

                entity.Property(e => e.CantidadProducto).HasColumnName("cantidad_producto");

                entity.Property(e => e.CantidadTotal)
                    .HasPrecision(10, 2)
                    .HasColumnName("cantidad_total");

                entity.Property(e => e.FechaHora)
                    .HasColumnType("timestamp without time zone")
                    .HasColumnName("fecha_hora");

                entity.Property(e => e.Folio)
                    .HasMaxLength(50)
                    .HasColumnName("folio");

                entity.Property(e => e.MeseroId).HasColumnName("mesero_id");

                entity.Property(e => e.NombreMesero)
                    .HasMaxLength(100)
                    .HasColumnName("nombre_mesero");

                entity.Property(e => e.NombreProducto)
                    .HasMaxLength(100)
                    .HasColumnName("nombre_producto");

                entity.Property(e => e.PrecioTotalProducto)
                    .HasPrecision(10, 2)
                    .HasColumnName("precio_total_producto");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
