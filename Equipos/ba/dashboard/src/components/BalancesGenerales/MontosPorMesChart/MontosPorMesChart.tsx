import React, { useEffect, useState } from "react";
import { Chart } from "primereact/chart";
import { trpc } from "@/utils/trpc";
export const MontosPorMesChart = () => {
  const {data} = trpc.ventasRouter.obtenerEstadisticasVentas.useQuery()
  if(!data) return "Loading..."
  const chartData = {
    labels: data.estadiscas.map(({ mes }) => mes),
    datasets: [
      {
        label: "Ventas",
        data: data.estadiscas.map(({ ordenesCanceladas,promedioDelMontoTotalDeOrdenesEntregadas,totalDeOrdenes }) => Number(promedioDelMontoTotalDeOrdenesEntregadas)*(totalDeOrdenes-ordenesCanceladas)).sort((x,y) => x-y),
        hoverOffset:20,
      },
    ],
  }
  return (
    <div className="flex justify-center">
      <Chart
        type="pie"
        data={chartData}
        options={{
          plugins: {
            legend: {
              labels: {
                usePointStyle: true,
              },
            },
          }}}
        className="w-[60%]"
      />
    </div>
  );
};
