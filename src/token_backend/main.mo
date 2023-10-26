import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import Debug "mo:base/Debug";

actor Token {

    var owner : Principal = Principal.fromText("xevzc-zvwds-xausy-2z2hh-4fftx-ckm32-pjxvj-bkoqf-57xg5-nl6jb-lae");
    var totalSupply : Nat = 1000000000;
    var symbol : Text = "DNaf";

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
        // shared => get hold of caller of the function

        Debug.print(debug_show (msg.caller));

        if (balances.get(msg.caller) == null) {
            let amount = 10000;
            // balances.put(msg.caller, amount);
            let result = await transfer(msg.caller, amount);
            return result;
        } else {
            return "Already Claimed";
        };
    };

    public shared (msg) func transfer(to : Principal, amount : Nat) : async Text {
        // when we call one func from another the msg.caller will give actor id

        // let result = await payOut();
        let fromBalance = await balanceOf(msg.caller);
        if (fromBalance > amount) {

            let newFromBalance : Nat = fromBalance - amount;
            balances.put(msg.caller, newFromBalance);

            let toBalance = await balanceOf(to);
            let newToBalance : Nat = toBalance + amount;
            balances.put(to, newToBalance);
            return "Successful";
        } else {
            return "Insufficient Amount";
        };

    };
};
