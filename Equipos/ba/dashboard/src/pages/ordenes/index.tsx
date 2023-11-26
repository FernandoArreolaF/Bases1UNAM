import {
  LineaTendenciaHoraPico,
  OrdenLayout,
  TopPlatos,
} from "@/components";

const OrdenPage = () => {
  return (
    <OrdenLayout>
      <div className="bg-blanco w-[80%] mx-auto p-10">
        <LineaTendenciaHoraPico />
        <TopPlatos />
      </div>
    </OrdenLayout>
  );
};

export default OrdenPage;
