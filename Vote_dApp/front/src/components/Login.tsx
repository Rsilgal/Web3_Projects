interface Props {
  connectWallet: () => void;
}

export const Login = ({ connectWallet }: Props) => {
  return (
    <div>
      <h1>Welcome to your first dApp</h1>
      <button onClick={connectWallet}>Login with Metamask</button>
    </div>
  );
};
