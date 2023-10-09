import {
    useAccount,
    useConnect,
    useContractWrite,
    useDisconnect,
    usePrepareContractWrite,
    useWaitForTransaction,
  } from "wagmi";
  import { contractABI, contractAddress } from "../constants";
  import { avalancheFuji } from "wagmi/dist/chains";
  import { useDebounce } from "../hooks/useDebounce";
  import { useState } from "react";
  

const { address, connector, isConnected } = useAccount();
const { connect, connectors, error, isLoading, pendingConnector } =
  useConnect();
const { disconnect } = useDisconnect();

const [retrieve, setRetrieve] = useState(0);
const debounceRetrieve = useDebounce(retrieve, 500);

const { config } = usePrepareContractWrite({
  address: contractAddress,
  abi: [
    {
      inputs: [],
      name: "retrieve",
      outputs: [
        {
          internalType: "uint256",
          name: "",
          type: "uint256",
        },
      ],
      stateMutability: "view",
      type: "function",
    },
  ],
  chainId: 43113,
  functionName: "retrieve",
  args: [],
  enabled: Boolean(debounceRetrieve),
});

const { data, write } = useContractWrite(config);