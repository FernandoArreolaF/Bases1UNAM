import { trpc } from "@/utils/trpc";
import { ItemPlato } from "./ItemPlato/ItemPlato";
import { PrimeIcons } from "primereact/api";

export const TopPlatos = () => {
  const { data } = trpc.ordenRouter.platoMasVendido.useQuery();
  if (!data) return "Cargando...";
  const {
    alimentos: { masVendido, menosVendido, queGeneroMas },
  } = data;
  return (
    <div className="flex flex-col gap-10 mt-20">
      <h2 className=" text-center text-5xl text-negro mb-10`">
        <span className={PrimeIcons.STAR + " text-4xl"}></span> Los Mejores{" "}
        <span className={PrimeIcons.STAR + " text-4xl"}></span>
      </h2>
      <div className="flex gap-10 bg-blanco">
        {masVendido.existe && (
          <ItemPlato
            alimento={masVendido.alimento}
            estadistica={{
              titulo: "Numero de Ventas",
              valor: masVendido.numeroVentas,
            }}
            tituloItem="Platillo Mas Vendido"
          />
        )}
        {menosVendido.existe && (
          <ItemPlato
            alimento={menosVendido.alimento}
            estadistica={{
              titulo: "Numero de Ventas",
              valor: menosVendido.numeroVentas,
            }}
            tituloItem="Platillo Menos Vendido"
          />
        )}
        {queGeneroMas.existe && (
          <ItemPlato
            alimento={queGeneroMas.alimento}
            estadistica={{
              titulo: "Monto Generado",
              valor: queGeneroMas.montoGenerado,
            }}
            tituloItem="Que Genero Mas"
          />
        )}
      </div>
    </div>
  );
};
