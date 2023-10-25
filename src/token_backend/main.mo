import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import Debug "mo:base/Debug";

actor Token {

    var owner : Principal = Principal.fromText("xevzc-zvwds-xausy-2z2hh-4fftx-ckm32-pjxvj-bkoqf-57xg5-nl6jb-lae");
    var totalSupply : Nat = 1000000000;
    var symbol : Text = "Naf";

    var balances = HashMap.HashMap<Principal, Nat>(1, Principal.equal, Principal.hash);
    balances.put(owner, totalSupply);

    public query func balanceOf(who : Principal) : async Nat {

        let balance : Nat = switch ((balances.get(who))) {
            case null 0;
            case (?result) result;
        };

        return balance;
    };

    public query func getSymbol() : async Text {
        return symbol;
    };

    public shared (msg) func payOut() : async Text {
        // Debug.print(debug_show (msg.caller));

        if (balances.get(msg.caller) == null) {
            let amount = 10000;
            balances.put(msg.caller, amount);
            return "Success";
        } else {
            return "Already Claimed";
        };
    };
};
