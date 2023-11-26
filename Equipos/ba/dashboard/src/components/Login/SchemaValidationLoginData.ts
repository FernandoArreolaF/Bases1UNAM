import {z} from "zod"
export const schemaValidationLoginData = z.object({
    email:z.string().email("El correo es invalido"),
    password:z.string().min(1,"Contraseña vacía")
})