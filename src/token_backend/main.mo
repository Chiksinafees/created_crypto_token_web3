import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import Debug "mo:base/Debug";
import Iter "mo:base/Iter";

actor Token {

Debug.print("hello");

    let owner : Principal = Principal.fromText("xevzc-zvwds-xausy-2z2hh-4fftx-ckm32-pjxvj-bkoqf-57xg5-nl6jb-lae");
    let totalSupply : Nat = 1000000000;
    let symbol : Text = "DNaf";
   
    private stable var balanceEntries : [(Principal, Nat)] = []; // used just to hold the value of HashMap while updation time so it's value won't lost
                                                                 // it's computation is too costly so for searching we won't use , just for storing data we use them

    private var balances = HashMap.HashMap<Principal, Nat>(1, Principal.equal, Principal.hash); // private => so no other class cannot access these

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

    public shared (msg) func payOut() : async Text {           // shared => get hold of caller of the function

        Debug.print(debug_show (msg.caller));

        if (balances.get(msg.caller) == null) {
            let amount = 10000;
            let result = await transfer(msg.caller, amount);
            return result;
        } else {
            return "Already Claimed";
        };
    };

    public shared (msg) func transfer(to : Principal, amount : Nat) : async Text {        // when we call one func from another the msg.caller will give actor id

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

    system func preupgrade() {         // trigger before update

        balanceEntries := Iter.toArray(balances.entries())       // entries => convert HashMap into iterable mode
    };

    system func postupgrade() {       // trigger after update
        balances := HashMap.fromIter<Principal, Nat>(balanceEntries.vals(), 1, Principal.equal, Principal.hash); //.vals=> make balanceEntries iterable
        if (balances.size() < 1) {
            balances.put(owner, totalSupply);
        };
    };

};
