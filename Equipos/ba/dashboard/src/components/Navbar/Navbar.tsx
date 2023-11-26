import Link from "next/link";
import { Button } from "primereact/button";
import { FC } from "react";
import { PrimeIcons } from "primereact/api";
import { signOut } from "next-auth/react";
interface NavbarProps {}
const Navbar: FC<NavbarProps> = () => {
  return (
    <div className="flex justify-end p-4">
      <div className="flex gap-4">
        <Link href={"/"}>
          <Button
            outlined
            className="text-xl p-3 flex gap-2 flex-row-reverse"
            icon={PrimeIcons.HOME}
          >
            Inicio
          </Button>
        </Link>
        <Link href={"/ventas"}>
          <Button
            outlined
            className="text-xl p-3 flex gap-2 flex-row-reverse"
            icon={PrimeIcons.SHOPPING_BAG}
          >
            Ventas
          </Button>
        </Link>
        <Link href={"/menu"}>
          <Button
            outlined
            className="text-xl p-3 flex gap-2 flex-row-reverse"
            icon={PrimeIcons.MAP}
          >
            Menu
          </Button>
        </Link>
        <Link href={"/ordenes"}>
          <Button
            outlined
            className="text-xl p-3 flex gap-2 flex-row-reverse"
            icon={PrimeIcons.TAG}
          >
            Ordenes
          </Button>
        </Link>
        <Button
          outlined
          className="text-xl p-3 flex gap-3 flex-row-reverse justify-center"
          icon={PrimeIcons.SIGN_OUT}
          onClick={() => signOut({ redirect: true ,callbackUrl:"/"})}
        >
          Cerrar Sesión
        </Button>
      </div>
    </div>
  );
};

export default Navbar;
