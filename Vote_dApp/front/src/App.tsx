// import { useState } from "react";
import { useEffect, useState } from "react";
import "./App.css";
import { Login } from "./components/Login";
import { Contract, ethers } from "ethers";
import { contractABI, contractAddress } from "./lib/constants";
import { formatUnits } from "viem";

const getNumberContract = async (): Promise<Contract> => {
  const { ethereum} = window
  const provider = new ethers.BrowserProvider(ethereum)
  const signer = await provider.getSigner();
  const contract = new ethers.Contract(contractAddress, contractABI, signer);
  return contract;
}

function App() {
  const [currentAccount, setCurrentAccount] = useState();
  const [currentValue, setCurrentValue] = useState('0')

  const connectWallet = async () => {
    const { ethereum } = window;
    if (ethereum) {
      const accounts = await ethereum.request({
        method: "eth_requestAccounts",
      });
      setCurrentAccount(accounts[0]);
    } else {
      return alert("Please install metamask wallet");
    }
  };

  async function handleContractVallue(){
    const { ethereum} = window
    const provider = new ethers.BrowserProvider(ethereum)
    const signer = await provider.getSigner();
    const contract = new ethers.Contract(contractAddress, contractABI, signer);
    const result = await contract.store(555);
    // await result.wait();
    const a = formatUnits(result, 18)
    setCurrentValue(a);
  }

  async function init() {
    const { ethereum} = window
    const provider = new ethers.BrowserProvider(ethereum)
    const signer = await provider.getSigner();
    const contract = new ethers.Contract(contractAddress, contractABI, signer);
    const result = await contract.retrieve();
    setCurrentValue(result)
  }

  useEffect(() => {
    init()
  }, [])

  return (
    <div>
      {currentAccount ? (
        <>
          <p>Wallet Address: {currentAccount}</p>
          <button onClick={handleContractVallue}>Usar el contrato definido</button>
          <p>El valor es de {currentValue}</p>
        </>
      ) : (
        <Login connectWallet={connectWallet} />
      )}
    </div>
  );
}

export default App;
