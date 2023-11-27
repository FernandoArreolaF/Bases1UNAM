using System;
using System.Collections.Generic;

namespace MiChangarro.Models
{
    public partial class EmpleadoPuesto
    {
        public int Id { get; set; }
        public int EmpleadoId { get; set; }
        public int PuestoId { get; set; }

        public virtual Empleado Empleado { get; set; } = null!;
        public virtual Puesto Puesto { get; set; } = null!;
    }
}
