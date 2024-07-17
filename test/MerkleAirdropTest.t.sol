// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test , console} from "lib/forge-std/src/Test.sol";
import {MerkleAirdrop} from"../src/MerkleAirdrop.sol";
import {Laddo} from "../src/Laddo.sol";
import {DeployMerkleAirdrop} from "../script/DeployMerkleAirdrop.s.sol";


contract MerkleAirdropTest is Test {

    MerkleAirdrop airdrop;
    Laddo laddo;

    uint256 constant AMOUNT = 25 * 1e18;
    uint256 constant AMOUNT_TO_SEND = AMOUNT * 4;
    bytes32 merkleRoot = 0xaa5d581231e596618465a56aa0f5870ba6e20785fe436d5bfb82b08662ccc7c4;
    

    bytes32 proofOne = 0x0fd7c981d39bece61f7499702bf59b3114a90e66b51ba2c53abdf7b62986c00a;
    bytes32 proofTwo = 0xe5ebd1e1b5a5478a944ecab36a9a954ac3b6b8216875f6524caa7a1d87096576;
    bytes32[] proof = [proofOne, proofTwo];
    address user ;
    uint256 userPrivKey;
    address public gasPayer;

    function setUp() public {
        DeployMerkleAirdrop deployer = new DeployMerkleAirdrop();
        (airdrop , laddo) = deployer.run();
       
        (user , userPrivKey) = makeAddrAndKey("user");
        gasPayer = makeAddr("gasPayer");
    }


    function testUsersCanClaim() public {
        uint256 startingBalance = laddo.balanceOf(user);
        bytes32 digest = airdrop.getMessage(user , AMOUNT);

        (uint8 v , bytes32 r , bytes32 s) = vm.sign(userPrivKey , digest);


        vm.prank(gasPayer);
        
        airdrop.claim(user, AMOUNT, proof , v , r , s);

        uint256 endingUserBalance = laddo.balanceOf(user);

        assertEq(endingUserBalance - startingBalance , AMOUNT);
    }
}


