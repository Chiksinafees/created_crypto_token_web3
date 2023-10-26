import React, { useState } from "react";
import {Principal} from "@dfinity/principal";
import { token_backend } from "../../../declarations/token_backend";

function Transfer() {
  const [recipientId, setRecipientId] = useState("");
  const [amount, setAmount] = useState("");
  const [isDisabled, setDisabled] = useState(false);
  const [isHidden, setHidden] = useState(true);
  const [res, setRes] = useState("");

  async function handleClick() {
    setHidden(true);
    setDisabled(false);
    const recipient =Principal.fromText(recipientId);
    const amountTransfer= Number(amount)
    const feedback = await token_backend.transfer(recipient, amountTransfer);
    setRes(feedback);
    setHidden(false);
    setRecipientId("")
    setAmount("")
  }

  return (
    <div className="window white">
      <div className="transfer">
        <fieldset>
          <legend>To Account:</legend>
          <ul>
            <li>
              <input
                type="text"
                id="transfer-to-id"
                value={recipientId}
                onChange={(e) => setRecipientId(e.target.value)}
              />
            </li>
          </ul>
        </fieldset>
        <fieldset>
          <legend>Amount:</legend>
          <ul>
            <li>
              <input
                type="number"
                id="amount"
                value={amount}
                onChange={(e) => setAmount(e.target.value)}
              />
            </li>
          </ul>
        </fieldset>
        <p className="trade-buttons">
          <button id="btn-transfer" onClick={handleClick} disabled={isDisabled}>
            Transfer
          </button>
        </p>
        <p hidden={isHidden}>{res}</p>
      </div>
    </div>
  );
}

export default Transfer;
