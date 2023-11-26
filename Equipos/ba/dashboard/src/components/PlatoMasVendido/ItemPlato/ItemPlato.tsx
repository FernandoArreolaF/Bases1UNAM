import { ItemListaAlimentosMenu } from "@/components";
import { Tag } from "primereact/tag";
import { FC } from "react";
interface Alimento {
  alimento_id: number;
  categoria_alimento_id: number;
  descripcion: string;
  disponible: boolean;
  nombre: string;
  precio: string;
  receta: string;
  categoria_alimento: CategoriaAlimento;
}

interface CategoriaAlimento {
  categoria_alimento_id: number;
  nombre: string;
  descripcion: string;
}

interface ItemPlatoProps {
  tituloItem: string;
  alimento: Alimento | undefined;
  estadistica: {
    valor: number | string | boolean | undefined;
    titulo: string;
  };
}
export const ItemPlato: FC<ItemPlatoProps> = ({
  alimento,
  estadistica: { titulo, valor },
  tituloItem,
}) => {
  if (!alimento) return <></>;
  const {
    precio,
    nombre,
    descripcion,
    categoria_alimento: { nombre: nombreCategoria },
    alimento_id,
  } = alimento;
  return (
    <div className="flex-1">
      <header className="mb-5 flex flex-col gap-5 text-negro shadow-2xl rounded-xl shadow-negro p-3">
        <h2 className="text-4xl">{tituloItem}</h2>
        <div className="flex justify-between items-center px-5">
          <Tag>
            <h3 className="text-2xl">{titulo}</h3>
          </Tag>
          <p className="text-4xl">{valor}</p>
        </div>
      </header>
      <ItemListaAlimentosMenu
        descripcion={descripcion}
        nombre={nombre}
        precio={Number(precio)}
        nombreCategoria={nombreCategoria}
        alimento_id={alimento_id}
      />
      <div>
        <h4 className="text-xl">{}</h4>
      </div>
    </div>
  );
};
