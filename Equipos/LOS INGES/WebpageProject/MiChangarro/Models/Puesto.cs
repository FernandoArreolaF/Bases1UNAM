using System;
using System.Collections.Generic;

namespace MiChangarro.Models
{
    public partial class Puesto
    {
        public Puesto()
        {
            EmpleadoPuestos = new HashSet<EmpleadoPuesto>();
        }

        public int Id { get; set; }
        public string Nombre { get; set; } = null!;
        public string Descripcion { get; set; } = null!;

        public virtual ICollection<EmpleadoPuesto> EmpleadoPuestos { get; set; }
    }
}
