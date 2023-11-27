using System;
using System.Collections.Generic;

namespace MiChangarro.Models
{
    public partial class Factura
    {
        public string? Folio { get; set; }
        public DateTime? FechaHora { get; set; }
        public decimal? CantidadTotal { get; set; }
        public string? Mesero { get; set; }
    }
}
