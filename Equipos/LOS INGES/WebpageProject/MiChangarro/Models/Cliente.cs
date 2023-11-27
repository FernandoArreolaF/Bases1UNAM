using System;
using System.Collections.Generic;

namespace MiChangarro.Models
{
    public partial class Cliente
    {
        public Cliente()
        {
            Ordens = new HashSet<Orden>();
        }

        public int Id { get; set; }
        public string Rfc { get; set; } = null!;
        public string Nombre { get; set; } = null!;
        public string Domicilio { get; set; } = null!;
        public string RazonSocial { get; set; } = null!;
        public string Email { get; set; } = null!;
        public DateOnly FechaNacimiento { get; set; }

        public virtual ICollection<Orden> Ordens { get; set; }
    }
}
