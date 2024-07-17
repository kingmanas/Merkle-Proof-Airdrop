// SPDX-License-Identifier: MIT

pragma solidity 0.8.24;

import {Script} from "forge-std/Script.sol";
import {MerkleAirdrop} from "../src/MerkleAirdrop.sol";
import {Laddo} from "../src/Laddo.sol";

contract DeployMerkleAirdrop is Script {
    MerkleAirdrop airdrop;
    Laddo laddo;
    bytes32 public constant ROOT = 0xaa5d581231e596618465a56aa0f5870ba6e20785fe436d5bfb82b08662ccc7c4;
    uint256 constant AMOUNT = 25 * 1e18;
    uint256 constant AMOUNT_TO_SEND = AMOUNT * 4;

    function deployMerkleAirdrop() internal returns (MerkleAirdrop , Laddo) {
        vm.startBroadcast();
        laddo = new Laddo();
        airdrop = new MerkleAirdrop(ROOT , laddo);
        laddo.mint(laddo.owner() , AMOUNT_TO_SEND);
        laddo.transfer(address(airdrop) , AMOUNT_TO_SEND);
        vm.stopBroadcast();
        return (airdrop , laddo);
    }
    function run() external returns(MerkleAirdrop ,Laddo){
        return deployMerkleAirdrop();
    }

    
} 