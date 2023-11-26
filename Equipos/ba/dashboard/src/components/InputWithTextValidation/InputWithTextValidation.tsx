import { InputText } from "primereact/inputtext";
import { Message } from "primereact/message";
import { FC } from "react";
interface InputTextWithValidationProps {
  field:string
  handleOnBlur:(e:unknown) => void
  handleOnChange:(e:unknown) => void
  value:string
  touched?:boolean
  error?:string
  name:string
}
export const InputTextWithValidation:FC<InputTextWithValidationProps> = ({field,name,handleOnBlur,handleOnChange,value,error,touched}) => {
  return (
    <div className="flex flex-col gap-2">
      <label className="text-start text-xl">{field}</label>
      <InputText
        name={name}
        value={value}
        type={name === "password" ? "password" : "text"}
        pt={{
          root: {
            style: {
              fontSize: "18px",
              padding: "4px",
              fontFamily: "Poppins",
            },
          },
        }}
        onBlur={handleOnBlur}
        onChange={handleOnChange}
      />
      {touched && error && (
        <Message severity="warn" text={error} className="text-xs" />
      )}
    </div>
  );
};