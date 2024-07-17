// SPDX-License-Identifier: MIT

pragma solidity 0.8.24;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol"; 
import {MerkleAirdrop} from "../src/MerkleAirdrop.sol";

contract Intera is Script{
    address CLAIMING_ADDRESS = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;

    uint256 CLAIMING_AMOUNT = 25 * 1e18;
    bytes32 proofOne = 0xd1445c931158119b00449ffcac3c947d028c0c359c34a6646d95962b3b55c6ad;
    bytes32 proofTwo = 0xe5ebd1e1b5a5478a944ecab36a9a954ac3b6b8216875f6524caa7a1d87096576;

    bytes32[] public proof = [proofOne , proofTwo];
    bytes SIGNATURE = hex"5e9a33ab80939c3d14233e227ded66e1a5700ec1172a53f5695b33819ca41b417f946cf416b13407ad6ce6a415836da58621d78af259eecfea3f440e2fda99211b";

    error ClaimAirdrop__InvalidSignatureLength();
        


     function claimAirdrop(address airdrop) public {
        vm.startBroadcast();
        (uint8 v , bytes32 r , bytes32 s) = splitSignature(SIGNATURE);
        MerkleAirdrop(airdrop).claim(CLAIMING_ADDRESS , CLAIMING_AMOUNT , proof , v, r, s);
        vm.stopBroadcast();
    }

    function splitSignature(bytes memory sig) public returns(uint8 v , bytes32 r , bytes32 s){
        if(sig.length != 65){
            revert ClaimAirdrop__InvalidSignatureLength();
        }

        assembly {
            r := mload(add(sig ,32))
            s := mload(add(sig , 64))
            v := byte(0, mload(add(sig,96)))
        }
    }

    function run() external {
        address mostRecentDeployed = DevOpsTools.get_most_recent_deployment("MerkleAirdrop" , block.chainid);
        claimAirdrop(mostRecentDeployed);
    }
}