using System;
using System.Collections.Generic;

namespace MiChangarro.Models
{
    public partial class Producto
    {
        public Producto()
        {
            ProductoOrdens = new HashSet<ProductoOrden>();
        }

        public int Id { get; set; }
        public string Nombre { get; set; } = null!;
        public string Descripcion { get; set; } = null!;
        public string Receta { get; set; } = null!;
        public decimal Precio { get; set; }
        public bool Disponible { get; set; }
        public int CategoriaId { get; set; }

        public virtual Categorium Categoria { get; set; } = null!;
        public virtual ICollection<ProductoOrden> ProductoOrdens { get; set; }
    }
}
