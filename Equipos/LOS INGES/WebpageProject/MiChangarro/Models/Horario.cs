using System;
using System.Collections.Generic;

namespace MiChangarro.Models
{
    public partial class Horario
    {
        public int Id { get; set; }
        public int MeseroId { get; set; }
        public TimeOnly HoraEntrada { get; set; }
        public TimeOnly HoraSalida { get; set; }

        public virtual Empleado Mesero { get; set; } = null!;
    }
}
