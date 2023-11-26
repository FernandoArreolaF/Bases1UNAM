import { procedure, router } from "@/server/trpc";
import { prisma } from "@/server/prisma";
import groupBy from "just-group-by";
import { determinarElNombreDelMes } from "@/utils/determinarElNombreDelMes";
import mean from "just-mean";
const ventasProcedure = procedure;
export const ventasRouter = router({
  obtenerEstadisticasVentas: ventasProcedure.query(async () => {
    const _estadiscas = await prisma
      .$extends({
        result: {
          orden_general: {
            mes: {
              needs: { fecha: true },
              compute({ fecha }) {
                return determinarElNombreDelMes(fecha.getMonth() + 1);
              },
            },
          },
        },
      })
      .orden_general.findMany({ include: { orden_detalle: true } })

      .then((estas) => groupBy(estas, ({ mes }) => mes));
    type Estadisticas = typeof _estadiscas;
    type Mes = keyof Estadisticas;
    const resumenEstadisticas = Object.keys(_estadiscas).map((key) => {
      const _key = key as Mes;
      const item = _estadiscas[_key];
      const ordenesCanceladas = item.filter(
        (item) => item.estatus === "CANCELADA"
      ).length;
      const totalesDeOrdenesEntregadas = item
      .filter((item) => item.estatus === "ENTREGADA")
      .map(({ total }) => Number(total))
      let promedio;
      if(totalesDeOrdenesEntregadas.length ===0){
        promedio=0
      }else{
        promedio = mean(totalesDeOrdenesEntregadas)
      }
      return {
        mes: _key,
        ordenesCanceladas,
        promedioDelMontoTotalDeOrdenesEntregadas:promedio.toFixed(2),
        totalDeOrdenes:item.length
      };
    });
    return { estadiscas: resumenEstadisticas };
  }),
});
