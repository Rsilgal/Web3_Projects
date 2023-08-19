import { useAccount, useConnect, useDisconnect } from 'wagmi'

export const Profile = () => {
    const { address, connector, isConnected } = useAccount()
    const { connect, connectors, error, isLoading, pendingConnector } = useConnect();
    const { disconnect } = useDisconnect()

    if (isConnected) {
        return (
            <>
                <p>Connected to {connector.name} with address {address}</p>
                <button onClick={disconnect}>Disconnect</button>
            </>
        )
    }

    return (
        <div>
            {connectors.map((connector) => (
                <button
                    disabled={!connector.ready}
                    key={connector.id}
                    onClick={() => connect({ connector })}
                >
                    {connector.name}
                    {!connector.ready && ' (unsupported)'}
                    {isLoading &&
                        connector.id === pendingConnector?.id &&
                        ' (connecting)'}
                </button>
            ))}

            {error && <div>{error.message}</div>}
        </div>
    )
}