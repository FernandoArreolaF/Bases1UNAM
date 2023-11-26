import { Button } from "primereact/button";
import { Tag } from "primereact/tag";
import { FC } from "react";
interface ItemListaAlimentosMenuProps {
  alimento_id: number;
  nombre: string;
  flexBasis1?: boolean;
  precio: number;
  descripcion: string;
  nombreCategoria: string;
}
export const ItemListaAlimentosMenu: FC<ItemListaAlimentosMenuProps> = ({
  nombre,
  flexBasis1,
  precio,
  descripcion,
  nombreCategoria,
}) => {
  return (
    <div className={`shadow-xl p-4 bg-grisOscuro rounded-lg shadow-negro ${flexBasis1 ? "flex-1":""}`}>
      <div className="flex justify-between items-center mb-4">
        <div className="flex flex-col gap-1">
          <h2 className="text-3xl font-roboto">{nombre}</h2>
          <span className="flex items-center gap-5 font-nunito text-md">
            <span className="text-xl">Precio: {precio}$ </span><Tag>{nombreCategoria}</Tag>
          </span>
        </div>
      </div>
      <hr style={{ color: "#c0c0c0" }}></hr>
      <div className="flex flex-col gap-2 mt-2">
        <p>
          <strong className="text-xl">Descripción</strong>
        </p>
        <p className="text-lg font-roboto">{descripcion}</p>
      </div>
    </div>
  );
};
