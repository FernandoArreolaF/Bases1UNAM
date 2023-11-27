using System;
using System.Collections.Generic;

namespace MiChangarro.Models
{
    public partial class Orden
    {
        public Orden()
        {
            ProductoOrdens = new HashSet<ProductoOrden>();
        }

        public int Id { get; set; }
        public string Folio { get; set; } = null!;
        public DateTime FechaHora { get; set; }
        public decimal CantidadTotal { get; set; }
        public int MeseroId { get; set; }
        public int ClienteId { get; set; }

        public virtual Cliente Cliente { get; set; } = null!;
        public virtual Empleado Mesero { get; set; } = null!;
        public virtual ICollection<ProductoOrden> ProductoOrdens { get; set; }
    }
}
