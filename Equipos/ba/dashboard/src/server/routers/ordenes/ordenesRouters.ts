import { prisma } from "@/server/prisma";
import { procedure, router } from "@/server/trpc";
import groupBy from "just-group-by";

const ordenProcedure = procedure;
export const ordenRouter = router({
  obtenerHorasPico: ordenProcedure.query(async () => {
    const data = await prisma.orden_general.findMany();
    const _data = groupBy(data, ({ fecha }) => fecha.getHours());
    const estadisticas = Object.entries(_data).map(([key, value]) => {
      return {
        hora: key,
        cantidadDeOrdenes: value.length,
      };
    });
    return { data: estadisticas };
  }),
  platoMasVendido: ordenProcedure.query(async () => {
    const informacionAProcesar = await prisma.orden_general.findMany({
      include: {
        orden_detalle: {
          include: {
            alimento: {
              include: {
                categoria_alimento: true,
              },
            },
          },
        },
      },
      where: {
        estatus: {
          equals: "ENTREGADA",
        },
      },
    });
    interface ItemMap {
      alimento: (typeof informacionAProcesar)[0]["orden_detalle"][0]["alimento"];
      accNumCantidades: number;
      accSumaSubTotales: number;
    }
    const informacionAlimentos = new Map<number, ItemMap>();
    informacionAProcesar.forEach((orden) => {
      orden.orden_detalle.forEach((compra) => {
        const { alimento_id, alimento, subtotal, cantidad } = compra;
        const informacionPrevia = informacionAlimentos.get(alimento_id);
        if (informacionPrevia) {
          informacionPrevia.accNumCantidades += Number(cantidad);
          informacionPrevia.accSumaSubTotales += Number(subtotal);
          informacionAlimentos.set(alimento_id, informacionPrevia);
        } else {
          informacionAlimentos.set(alimento_id, {
            alimento,
            accNumCantidades: Number(cantidad),
            accSumaSubTotales: Number(subtotal),
          });
        }
      });
    });
    const ids = {
      idMasVendido: -1,
      idMenosVendido: -1,
      idQueGeneroMas: -1,
    };
    informacionAlimentos.forEach((value, key) => {
      const prevMasVendido = informacionAlimentos.get(ids.idMasVendido);
      if (!prevMasVendido) {
        ids.idMasVendido = key;
      } else if (prevMasVendido.accNumCantidades < value.accNumCantidades) {
        ids.idMasVendido = key;
      }
      const prevMenosVendido = informacionAlimentos.get(ids.idMenosVendido);
      if (!prevMenosVendido) {
        ids.idMenosVendido = key;
      } else if (prevMenosVendido.accNumCantidades > value.accNumCantidades) {
        ids.idMenosVendido = key;
      }
      const prevQueGeneroMas = informacionAlimentos.get(ids.idQueGeneroMas);
      if (!prevQueGeneroMas) {
        ids.idQueGeneroMas = key;
      } else if (prevQueGeneroMas.accSumaSubTotales < value.accSumaSubTotales) {
        ids.idQueGeneroMas = key;
      }
    });
    const _alimentos = {
      masVendido: informacionAlimentos.get(ids.idMasVendido),
      menosVendido: informacionAlimentos.get(ids.idMenosVendido),
      queGeneroMas: informacionAlimentos.get(ids.idQueGeneroMas),
    };
    const alimentos = {
      masVendido: {
        existe: _alimentos.masVendido !== undefined,
        numeroVentas: _alimentos.masVendido?.accNumCantidades,
        alimento: _alimentos.masVendido?.alimento,
      },
      menosVendido: {
        existe: _alimentos.menosVendido !== undefined,
        numeroVentas: _alimentos.menosVendido?.accNumCantidades,
        alimento: _alimentos.menosVendido?.alimento,
      },
      queGeneroMas: {
        existe: _alimentos.queGeneroMas !== undefined,
        montoGenerado: _alimentos.queGeneroMas?.accSumaSubTotales,
        alimento: _alimentos.queGeneroMas?.alimento,
      },
    };
    return { alimentos };
  }),
});
