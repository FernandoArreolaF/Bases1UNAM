import { z } from "zod";
import { router } from "../trpc";
import { menuRouter } from "./menu/menuRouter";
import { ventasRouter } from "./ventas/ventasRouter";
import { ordenRouter } from "./ordenes/ordenesRouters";
export const appRouter = router({
  menuRouter,
  ventasRouter,
  ordenRouter,
});

// export type definition of API
export type AppRouter = typeof appRouter;
