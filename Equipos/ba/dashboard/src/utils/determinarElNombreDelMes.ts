export const determinarElNombreDelMes = (mes:number) => {
	switch (mes) {
		case 1:
			return "Enero"
		case 2:
			return "Febrero"
		case 3:
			return "Marzo"
		case 4:
			return "Abril"
		case 5:
			return "Mayo"
		case 6:
			return "Junio"
		case 7:
			return "Julio"
		case 8:
			return "Agosto"
		case 9:
			return "Septiembre"
		case 10:
			return "Octubre"
		case 11:
			return "Noviembre"
		case 12:
			return "Diciembre"
		default:
      throw Error("Mes no valido")
  }
}
export const determinarNumeroDelMes = (nombreDelMes: string): number => {
  switch (nombreDelMes.toLowerCase()) {
    case "enero":
      return 1;
    case "febrero":
      return 2;
    case "marzo":
      return 3;
    case "abril":
      return 4;
    case "mayo":
      return 5;
    case "junio":
      return 6;
    case "julio":
      return 7;
    case "agosto":
      return 8;
    case "septiembre":
      return 9;
    case "octubre":
      return 10;
    case "noviembre":
      return 11;
    case "diciembre":
      return 12;
    default:
      throw new Error("Nombre de mes no válido");
  }
};
