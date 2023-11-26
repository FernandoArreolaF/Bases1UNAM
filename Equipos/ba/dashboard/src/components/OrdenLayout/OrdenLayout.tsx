import { useSession } from "next-auth/react";
import { useRouter } from "next-nprogress-bar";
import { FC, ReactNode } from "react";

interface OrdenLayoutProps {
  children: ReactNode;
}
export const OrdenLayout: FC<OrdenLayoutProps> = ({ children }) => {
  const { status } = useSession();
  const router = useRouter();
  if (status === "unauthenticated") router.push("/");
  return (
    <div className="py-10">
      {children}
    </div>
  );
};
