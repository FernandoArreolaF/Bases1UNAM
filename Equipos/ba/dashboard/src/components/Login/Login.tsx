import { useFormik } from "formik";
import { toFormikValidate } from "zod-formik-adapter";
import { schemaValidationLoginData } from "./SchemaValidationLoginData";
import { FC, useState } from "react";
import { InputTextWithValidation } from "../InputWithTextValidation";
import { Button } from "primereact/button";
import Link from "next/link";
import { signIn } from "next-auth/react";
import { useRouter } from "next/router";
import { Message } from "primereact/message";
export const Login: FC = () => {
  const [mostraCredencialesInvalidas, setMostraCredencialesInvalidas] = useState(false)
  const loginData = useFormik({
    initialValues: {
      email: "",
      password: "",
    },
    validate: toFormikValidate(schemaValidationLoginData),
    onSubmit({ email, password }) {
      signIn("credentials", { redirect: false, password, email }).then((value) => {
        if(!value) return
        const {ok,status} = value
        if(!ok || status === 401){
          
          console.log('o')
          setMostraCredencialesInvalidas(true)
        }
      });
    },
  });
  const { email, password } = loginData.values;
  const { email: emailTouched, password: passwordTouched } = loginData.touched;
  const { email: emailError, password: passwordError } = loginData.errors;
  const { handleBlur, handleChange } = loginData;
  return (
    <form
      className="flex flex-col justify-center items-center h-screen gap-4"
      onSubmit={loginData.handleSubmit}
    >
      <div className="flex flex-col gap-5 w-[600px] text-center p-5 shadow-2xl rounded-2xl">
        <h3 className="text-4xl">A La Carta</h3>
        <h4 className="text-2xl">Dashboard</h4>
        {mostraCredencialesInvalidas && <Message severity="error" text="Credenciales Invalidas"></Message>}
        <hr />
        <div className="flex flex-col gap-3">
          <InputTextWithValidation
            field="EMAIL"
            name="email"
            value={email}
            touched={emailTouched}
            error={emailError}
            handleOnBlur={handleBlur}
            handleOnChange={handleChange}
          />
          <InputTextWithValidation
            field="PASSWORD"
            name="password"
            value={password}
            touched={passwordTouched}
            error={passwordError}
            handleOnBlur={handleBlur}
            handleOnChange={handleChange}
          />
        </div>
        <div className="flex justify-end">
          <Button
            type="submit"
            className="text-xl text-gray-300"
          >
            Login
          </Button>
        </div>
      </div>
    </form>
  );
};
