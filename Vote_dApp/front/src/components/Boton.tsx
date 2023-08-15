import { FC } from "react";
import "./Boton.css"

interface BotonProps {
    func: () => void;
    texto: string
}

export const Boton: FC<BotonProps> = ({func, texto}) => {
    return(
        <button onClick={func}>{texto}</button>
    )
}