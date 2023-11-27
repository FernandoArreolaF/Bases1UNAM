using System;
using System.Collections.Generic;

namespace MiChangarro.Models
{
    public partial class ProductoOrden
    {
        public int Id { get; set; }
        public int ProductoId { get; set; }
        public int OrdenId { get; set; }
        public int Cantidad { get; set; }
        public decimal PrecioTotal { get; set; }

        public virtual Orden Orden { get; set; } = null!;
        public virtual Producto Producto { get; set; } = null!;
    }
}
