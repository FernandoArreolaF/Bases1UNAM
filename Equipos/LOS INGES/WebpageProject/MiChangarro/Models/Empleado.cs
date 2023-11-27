using System;
using System.Collections.Generic;

namespace MiChangarro.Models
{
    public partial class Empleado
    {
        public Empleado()
        {
            Dependientes = new HashSet<Dependiente>();
            EmpleadoPuestos = new HashSet<EmpleadoPuesto>();
            Horarios = new HashSet<Horario>();
            Ordens = new HashSet<Orden>();
        }

        public int Id { get; set; }
        public string Rfc { get; set; } = null!;
        public int NumEmpleado { get; set; }
        public string Nombre { get; set; } = null!;
        public string ApellidoPaterno { get; set; } = null!;
        public string? ApellidoMaterno { get; set; }
        public DateOnly FechaNacimiento { get; set; }
        public string Telefono { get; set; } = null!;
        public int Edad { get; set; }
        public string Domicilio { get; set; } = null!;
        public decimal Sueldo { get; set; }
        public string? RolAdministrativo { get; set; }
        public string? EspecialidadCocinero { get; set; }
        public byte[]? Foto { get; set; }

        public virtual ICollection<Dependiente> Dependientes { get; set; }
        public virtual ICollection<EmpleadoPuesto> EmpleadoPuestos { get; set; }
        public virtual ICollection<Horario> Horarios { get; set; }
        public virtual ICollection<Orden> Ordens { get; set; }
    }
}
