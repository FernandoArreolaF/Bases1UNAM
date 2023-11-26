import { useSession } from "next-auth/react";
import { useRouter } from "next-nprogress-bar";
import { FC, ReactNode } from "react";
interface MenuLayoutProps {
  children: ReactNode;
}
const MenuLayout: FC<MenuLayoutProps> = ({ children }) => {
  const { status } = useSession();
  const router = useRouter();
  if (status === "unauthenticated") router.push("/");
  return (
    <div>
      <header className="text-5xl text-center p-10">
        Alimentos Disponibles en el Menu
      </header>
      {children}
    </div>
  );
};

export default MenuLayout;
