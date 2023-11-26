import React, { FC, ReactNode } from "react";
import { BalancesGenerales } from "..";
import { useSession } from "next-auth/react";
import { useRouter } from "next-nprogress-bar";
interface VentasLayoutProps {
  children?: ReactNode;
}
export const VentasLayout: FC<VentasLayoutProps> = ({ children }) => {
  const { status } = useSession();
  const router = useRouter();
  if (status === "unauthenticated") router.push("/");
  return (
    <div className="max-w-[80%] mx-auto flex flex-col gap-2">
      <header className="flex flex-col gap-3 mb-3">
        <h2 className="text-5xl">Reporte por Mes</h2>
      </header>
      <BalancesGenerales />
      {children}
    </div>
  );
};
