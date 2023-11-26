import { Login } from "@/components";
import { useSession } from "next-auth/react";
import { Inter } from "next/font/google";
import { TypeAnimation } from "react-type-animation";
const inter = Inter({ subsets: ["latin"] });

export default function Home() {
  const { data: session } = useSession();
  if (!session) return <Login />;
  return (
    <main className={`${inter.className} bg-gris w-full h-[88vh] flex flex-col justify-center`}>
      <h1 className="text-6xl text-center">
        Bienvenido {session.user.nombre} a A LA CARTA
      </h1>
      <div className="text-center">
        <TypeAnimation
          sequence={[
            "En podrás analizar las ventas",
            1000,
            "En podrás ver tendencias",
            1000,
            "En podrás entender a tus clientes",
            1000,
            "En podrás incrementar tus ganancias$$",
            1000,
          ]}
          wrapper="p"
          speed={65}
          style={{ fontSize: "60px" }}
          repeat={Infinity}
        />
      </div>
    </main>
  );
}
