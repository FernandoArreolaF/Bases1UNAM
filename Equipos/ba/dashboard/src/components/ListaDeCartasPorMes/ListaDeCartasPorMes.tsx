import React from "react";
import { CartaMes } from "./CartaMes";
import { trpc } from "@/utils/trpc";

export const ListaDeCartasPorMes = () => {
  const { data } = trpc.ventasRouter.obtenerEstadisticasVentas.useQuery(
    undefined,
    { refetchOnWindowFocus: false, refetchOnMount: true }
  );
  if (!data) return <div>Loading...</div>;
  return (
    <div className="flex flex-col gap-10">
      {data.estadiscas.map((item, index) => {
        if (index % 3 != 0) return null;
        const subArregloElementosRenderizar = data.estadiscas.slice(
          index,
          Math.min(data.estadiscas.length, index + 3)
        );
        return (
          <div key={index} className="flex justify-between gap-10">
            {subArregloElementosRenderizar.map(
              ({
                mes,
                ordenesCanceladas,
                promedioDelMontoTotalDeOrdenesEntregadas,
                totalDeOrdenes,
              }) => {
                return (
                  <CartaMes
                    key={mes}
                    mes={mes}
                    canceladas={ordenesCanceladas}
                    promedio={Number(promedioDelMontoTotalDeOrdenesEntregadas)}
                    total={totalDeOrdenes}
                  />
                );
              }
            )}
          </div>
        );
      })}
    </div>
  );
};
