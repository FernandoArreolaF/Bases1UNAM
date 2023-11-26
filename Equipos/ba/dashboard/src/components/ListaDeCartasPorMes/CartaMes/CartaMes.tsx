import { Card } from "primereact/card";
import { Tag } from "primereact/tag";
import { FC } from "react";
interface CartaMesProps {
  mes: string;
  total: number;
  promedio: number;
  canceladas: number;
}
export const CartaMes:FC<CartaMesProps> = ({canceladas,mes,promedio,total}) => {
  return (
    <Card className="min-h-[220px] flex-1" title={mes}>
      <Tag>Total de Ordenes</Tag>
      <p className="text-xl">{total}</p>
      <Tag>Promedio del monto total</Tag>
      <p className="text-xl">{promedio}MXN</p>
      <Tag severity={"danger"}>Ordenes Canceladas</Tag>
      <p className="text-xl">{canceladas}</p>
    </Card>
  );
};
