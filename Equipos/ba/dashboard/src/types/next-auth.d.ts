import NextAuth, { DefaultSession } from "next-auth"

declare module "next-auth" {
    interface User {
        id:number,
        tipo:"cliente" | "empleado"
        nombre:string
    }
    interface AdapterUser{
        id:number,
        tipo:"cliente" | "empleado"
        nombre:string
    }
    interface Session {
        user: User
    }
}