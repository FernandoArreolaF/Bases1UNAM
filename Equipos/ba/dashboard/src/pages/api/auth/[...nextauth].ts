import type { NextAuthOptions, User } from "next-auth";
import NextAuth from "next-auth/next";
import CredentialsProvider from "next-auth/providers/credentials";
import { prisma } from "@/server/prisma";
import type { NextApiRequest, NextApiResponse } from "next";
const secret = process.env.NEXTAUTH_SECRET;
import { SHA256 } from "crypto-js";
export const authOptions: NextAuthOptions = {
  jwt: {
    maxAge: 3 * 60 * 60,
  },
  secret,
  providers: [
    CredentialsProvider({
      name: "credentials",
      credentials: {
        email: {
          label: "email",
          type: "text",
        },
        password: { label: "password", type: "password" },
      },
      async authorize(credentials) {
        if (!credentials) {
          return null;
        }
        const { email, password } = credentials;
        const empleado = await prisma.empleado.findUnique({
          select: { numero_empleado_id: true, nombre: true, pw: true },
          where: { email },
        });
        if (!empleado) return null;
        const hashPassword = SHA256(password).toString();
        const { pw } = empleado;
        if (hashPassword !== pw) return null;
        return {
          id: empleado.numero_empleado_id,
          nombre: empleado.nombre,
          tipo: "empleado",
        };
      },
    }),
  ],
  callbacks: {
    jwt({ token, user, trigger }) {
      if (user) {
        return { ...token, ...user };
      }
      return token;
    },
    session({ session, token }) {
      session.user = {
        id: token.id,
        tipo: token.tipo,
        nombre: token.nombre,
      } as User;
      return session;
    },
  },
  pages: {
    signIn: "/",
    signOut: "/",
  },
  session: {
    strategy: "jwt",
    maxAge: 3 * 60 * 60,
  },
};
export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse
) {
  return (await NextAuth(req, res, authOptions)) as unknown;
}
