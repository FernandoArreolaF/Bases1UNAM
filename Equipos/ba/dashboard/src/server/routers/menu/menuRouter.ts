import { prisma } from "@/server/prisma";
import { procedure, router } from "@/server/trpc";
const menuProcedure = procedure;
export const menuRouter = router({
  obtenerMenuDisponible: menuProcedure.query(async () => {
    const menu = await prisma.alimento.findMany({
      select: {
        alimento_id: true,
        precio: true,
        descripcion: true,
        nombre: true,
        receta: true,
        categoria_alimento: {
          select: {
            nombre: true,
          },
        },
      },
      where: {
        disponible: { equals: true },
      },
    });
    return { menu };
  }),
});
