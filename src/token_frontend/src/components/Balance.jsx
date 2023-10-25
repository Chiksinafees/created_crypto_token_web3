import React from "react";
import { useState } from "react";
import { Principal } from "@dfinity/principal";
import { token_backend } from "../../../declarations/token_backend";
import { getSymbol } from "../../../declarations/token_backend"


function Balance() {
  const [input, setInput] = useState("");
  const [balanceRes, setBalanceRes] = useState("");
  const [tokenSymbol, setTokenSymbol] =useState("")
  const [isHidden, setIsHidden]=useState(true)

  async function handleClick() {
    // console.log("Balance Button Clicked");

    const principal = Principal.fromText(input);
    const balance = await token_backend.balanceOf(principal);
    setBalanceRes(balance.toLocaleString());
    setTokenSymbol(await token_backend.getSymbol())
    setIsHidden(false)
  }

  return (
    <div className="window white">
      <label>Check account token balance:</label>
      <p>
        <input
          id="balance-principal-id"
          type="text"
          placeholder="Enter a Principal ID"
          value={input}
          onChange={(e) => setInput(e.target.value)}
        />
      </p>
      <p className="trade-buttons">
        <button id="btn-request-balance" onClick={handleClick}>
          Check Balance
        </button>
      </p>
      <p hidden={isHidden}>This account has a balance of {balanceRes} {tokenSymbol}.</p>
    </div>
  );
}

export default Balance;
