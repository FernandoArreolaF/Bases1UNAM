import { trpc } from "@/utils/trpc";
import { PrimeIcons } from "primereact/api";
import { Chart } from "primereact/chart";

export const LineaTendenciaHoraPico = () => {
  const { data } = trpc.ordenRouter.obtenerHorasPico.useQuery();
  if (!data) {
    return "Cargando...";
  }
  const chartData = {
    labels: data.data.map((item) => "Hora:" + item.hora),
    datasets: [
      {
        label: "Promedio de Ordenes por Hora",
        data: data.data.map((item) => item.cantidadDeOrdenes),
        fill: false,
        tension: 0.1,
      },
    ],
  };
  return (
      <div className="bg-grisOscuro p-5 rounded-lg shadow-2xl">
        <h2 className="text-center text-5xl mb-3">Tendencias de compra<span className={PrimeIcons.CHART_LINE + " text-3xl ml-5"}></span></h2>
        <Chart type="line" data={chartData} options={{
          responsive:true,
          scales:{
            x:{
              grid:{
                color:"#444"
              }
            },
            y:{
              grid:{
                color:"#444"
              }
            }
          }
        }} />
      </div>
  );
};
