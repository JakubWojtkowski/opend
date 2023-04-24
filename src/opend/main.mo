import Principal "mo:base/Principal";
import Nat8 "mo:base/Nat8";
import NFTActorClass "../NFT/nft";
import Cycles "mo:base/ExperimentalCycles";
import Debug "mo:base/Debug";
import HashMap "mo:base/HashMap";

actor OpenD {

    var mapOfNFTs = HashMap.HashMap<Principal, NFTActorClass.NFT>(1, Principal.equal, Principal.hash);

    public shared (msg) func mint(imgData : [Nat8], name : Text) : async Principal {
        let owner : Principal = msg.caller;

        Debug.print(debug_show(Cycles.balance()));
        Cycles.add(100_500_000_000);

        let newNFT = await NFTActorClass.NFT(name, owner, imgData);

        let newNFTPrincipal = await newNFT.getCanisterId();
        mapOfNFTs.put(newNFTPrincipal, newNFT);

        return newNFTPrincipal;
    };
};
