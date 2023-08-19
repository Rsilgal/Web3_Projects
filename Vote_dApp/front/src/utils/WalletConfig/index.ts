import { configureChains, createConfig } from "wagmi";
import { avalanche } from "wagmi/chains";
import { MetaMaskConnector } from "wagmi/connectors/metaMask";
import { infuraProvider } from "wagmi/providers/infura";
import { publicProvider } from "wagmi/providers/public";

const { chains, publicClient, webSocketPublicClient } = configureChains(
    [avalanche],
    [infuraProvider({ apiKey: '' }), publicProvider()]
)

export const config = createConfig({
    autoConnect: true,
    connectors: [
        new MetaMaskConnector({ chains })
    ],
    publicClient,
    webSocketPublicClient
})