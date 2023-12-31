import React ,{useState} from "react";
import { token_backend } from "../../../declarations/token_backend";

function Faucet() {
     
  const [isDisabled, setIsDisabled] =useState(false)
  const [buttonText, setButtonText] = useState("Gimme gimme")

  async function handleClick(event) {
     setIsDisabled(true)
     const text= await token_backend.payOut()
     setButtonText(text)
    }

  return (
    <div className="blue window">
      <h2>
        <span role="img" aria-label="tap emoji">
          🚰
        </span>
        Faucet
      </h2>
      <label>Get your free DAngela tokens here! Claim 10,000 DANG coins to your account.</label>
      <p className="trade-buttons">
        <button id="btn-payout" onClick={handleClick} disabled={isDisabled}>
          {buttonText}
        </button>
      </p>
    </div>
  );
}

export default Faucet;
