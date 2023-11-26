import { determinarNumeroDelMes } from "@/utils/determinarElNombreDelMes";
import { trpc } from "@/utils/trpc";
import { Chart } from "primereact/chart";
import React, { useEffect, useState } from "react";

export const OrdenesPorMesChar = () => {
  const { data } = trpc.ventasRouter.obtenerEstadisticasVentas.useQuery(
    undefined,
    { refetchOnWindowFocus: false, refetchOnMount: true }
  );
  if (!data) return "Loading...";
  const chartData = {
    labels: data.estadiscas.map(({ mes }) => mes),
    datasets: [
      {
        label: "Ordenes",
        data: data.estadiscas
          .sort(
            ({ mes }, { mes: mes2 }) =>
              determinarNumeroDelMes(String(mes)) - determinarNumeroDelMes(String(mes2))
          )
          .map(({ totalDeOrdenes }) => totalDeOrdenes),
      },
    ],
  };
  return (
    <div className="card">
      <Chart
        type="bar"
        data={chartData}
        options={{
          scales: {
            y: {
              beginAtZero: true,
            },
          },
        }}
      />
    </div>
  );
};
