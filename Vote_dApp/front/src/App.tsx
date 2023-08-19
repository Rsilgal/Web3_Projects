// import { useState } from "react";
import { WagmiConfig } from "wagmi";
import "./App.css";
import { config } from "./utils/WalletConfig";
import { Profile } from "./components/Profile";
// import { Header } from "./components/Header";
// import { Selector } from "./components/Selector";
// import { Boton } from "./components/Boton";
// import { useEffect, useState } from "react";
// import { ethers } from "ethers";
// import { Contract } from "ethers";
// import { contractABI, contractAddress } from "./constants";
// import { formatUnits } from "ethers";

function App() {
  // const [count, setCount] = useState(0);
  // const votaciones: string[] = ["Votación 1", "Votación 2"];
  // const opciones: string[] = ["Opción 1", "Opción 2", "Opción 3"];

  // let provider;
  // let signer;

  // const walletConnection = async () => {
  //   console.log("Cargado");

  //   if (window.ethereum == null) {
  //     console.log("Mongolo, instala Metamask");
  //   } else {
  //     try {
  //       provider = new ethers.BrowserProvider(window.ethereum);
  //       signer = await provider.getSigner();
  //       console.log("Provider:", provider);
  //       console.log("Signer:", signer);
  //     } catch (e) {
  //       console.log(e);
  //     }
  //   }
  // };

  // let contract;

  // const contractConnection = async () => {
  //   contract = new Contract(contractAddress, contractABI, signer);
  //   // contract = new Contract(contractAddress, contractABI, provider);
  //   let retieve = await contract.retrieve();
  //   console.log(formatUnits(retieve));

  //   let quantity = await contract.store(99875);
  //   console.log(quantity);

  //   retieve = await contract.retrieve();
  //   console.log(formatUnits(retieve));
  // };

  // const handlerClick = async () => {
  //   console.log("Se ha pulsado");
  //   await walletConnection();
  // };

  // const show = async () => {
  //   console.log("Provider:", provider);
  //   console.log("Signer:", signer);
  //   let retieve = await contract.retrieve();
  //   console.log(formatUnits(retieve));
  // };
  return (
    // <>
    //   <header>
    //     <Header />
    //   </header>
    //   <main>
    //     <Selector entrada={votaciones} name="votaciones" id="1"></Selector>

    //     <div>
    //       {" "}
    //       {/* Esta etiqueta será la tarjeta */}
    //       <Selector entrada={opciones} name="opciones" id="2" />
    //       {/* <button onClick={handlerClick}>Vote</button> */}
    //       <Boton func={handlerClick} texto="Conectar a la red" />
    //       <Boton func={contractConnection} texto="Conectar al contrato" />
    //       <Boton func={show} texto="Show" />
    //     </div>
    //   </main>
    //   Signer: {signer}
    //   <br />
    //   Provider: {provider}
    // </>
    <WagmiConfig config={config}>
      <Profile />
    </WagmiConfig>
  );
}

export default App;
