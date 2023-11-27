using System;
using System.Collections.Generic;

namespace MiChangarro.Models
{
    public partial class VistaFactura
    {
        public string? Folio { get; set; }
        public DateTime? FechaHora { get; set; }
        public decimal? CantidadTotal { get; set; }
        public int? MeseroId { get; set; }
        public string? NombreMesero { get; set; }
        public string? NombreProducto { get; set; }
        public int? CantidadProducto { get; set; }
        public decimal? PrecioTotalProducto { get; set; }
    }
}
