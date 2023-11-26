import { trpc } from "@/utils/trpc";
import { ItemListaAlimentosMenu } from "./ItemListaAlimentosMenu/ItemListaAlimentosMenu";
import { useState } from "react";
import { InputNumber } from "primereact/inputnumber";
import { InputText } from "primereact/inputtext";

import { Checkbox } from "primereact/checkbox";

export const ListaDeAlimentosMenu = () => {
  const [elementosPorFila, setElementosPorFila] = useState(1);
  const [busqueda, setBusqueda] = useState("");
  const [alineado, setAlineado] = useState(false);
  const { data, isLoading } = trpc.menuRouter.obtenerMenuDisponible.useQuery(
    undefined,
    {
      refetchOnMount: true,
      refetchOnWindowFocus: false,
    }
  );
  if (isLoading) return <div>Cargando...</div>;
  if (data) {
    const { menu } = data;
    const _menu = menu.filter(({ nombre }) =>
      nombre.toLowerCase().includes(busqueda.toLowerCase())
    );
    return (
      <ul className="max-w-[70%] mx-auto bg-stone-400 rounded-xl text-black overflow-y-scroll max-h-[80vh] bg-blanco">
        <div
          className="text-negro flex justify-between items-center sticky z-50 bg-blanco mb-10 p-10 shadow-xl"
          style={{ top: "-1px" }}
        >
          <div>
            <p className=" text-2xl mb-2">Elementos por fila</p>
            <InputNumber
              value={elementosPorFila}
              onValueChange={(e) => setElementosPorFila(e.value || 1)}
              showButtons
              min={1}
              max={5}
              buttonLayout="horizontal"
              decrementButtonClassName="p-button-secondary"
              incrementButtonClassName="p-button-secondary"
              incrementButtonIcon="pi pi-plus"
              decrementButtonIcon="pi pi-minus"
            />
            <div className="flex align-items-center mt-2">
              <Checkbox
                inputId="alineado"
                name="alineadoCheck"
                value={alineado}
                onChange={({ checked }) => {
                  setAlineado(checked || false);
                }}
                checked={alineado}
              />
              <label htmlFor="alineado" className="ml-2">
                Alinear
              </label>
            </div>
          </div>
          <div>
            <p className="text-2xl text-end mb-2">Buscar por Nombre</p>
            <span className="p-input-icon-left">
              <i className="pi pi-search" />
              <InputText
                placeholder="Papas fritas"
                value={busqueda}
                onChange={(e) => setBusqueda(e.target.value || "")}
              />
            </span>
          </div>
        </div>
        <div className="px-10 flex flex-col gap-10 mb-10">
          {_menu.map((item, index) => {
            const shouldRender = index % elementosPorFila === 0;
            if (shouldRender) {
              const elementsToRender = _menu.slice(
                index,
                Math.min(index + elementosPorFila, _menu.length)
              );
              return (
                <div className="flex gap-3" key={index}>
                  {elementsToRender.map((item, subIndex) => (
                    <ItemListaAlimentosMenu
                      key={subIndex}
                      flexBasis1={alineado || elementosPorFila === 1}
                      alimento_id={item.alimento_id}
                      nombre={item.nombre}
                      precio={Number(item.precio)}
                      descripcion={item.descripcion}
                      nombreCategoria={item.categoria_alimento.nombre}
                    />
                  ))}
                </div>
              );
            }

            return null;
          })}
        </div>
      </ul>
    );
  }
};
