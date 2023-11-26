import { TabView, TabPanel } from "primereact/tabview";
import { OrdenesPorMesChar } from "./OrdenesPorMesChart/OrdenesPorMesChar";
import { MontosPorMesChart } from "./MontosPorMesChart/MontosPorMesChart";

export const BalancesGenerales = () => {
  return (
    <TabView className="shadow-2xl">
      <TabPanel header="Ordenes por Mes">
        <OrdenesPorMesChar />
      </TabPanel>
      <TabPanel header="Monto por Mes">
        <MontosPorMesChart />
      </TabPanel>
    </TabView>
  );
};
