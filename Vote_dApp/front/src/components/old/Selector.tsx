// import { useState } from "react";
import "./Selector.css"

interface SelectorProps {
    name: string,
    id: string
    entrada: string[],
}

export const Selector:React.FC<SelectorProps> = ({name, id, entrada}) => {
  // const [selection, setSelection] = useState();

  return (
    <div className="Selector">
        <select name={name} id={id}>
            {
                entrada.map((f) => <option key={f.concat(id)} value={f}>{f}</option>)
            }
        </select>
    </div>
  );
};
