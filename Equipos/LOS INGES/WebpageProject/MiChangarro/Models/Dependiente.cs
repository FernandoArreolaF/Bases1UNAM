using System;
using System.Collections.Generic;

namespace MiChangarro.Models
{
    public partial class Dependiente
    {
        public int Id { get; set; }
        public string Curp { get; set; } = null!;
        public string Nombre { get; set; } = null!;
        public string Parentesco { get; set; } = null!;
        public int EmpleadoId { get; set; }

        public virtual Empleado Empleado { get; set; } = null!;
    }
}
