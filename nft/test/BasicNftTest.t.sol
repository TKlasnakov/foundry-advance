// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import { Test } from "forge-std/Test.sol";
import { BasicNft } from "../src/BasicNft.sol";
import { DeployBasicNft } from "../script/DeployBasicNft.s.sol";

contract BasicNftTest is Test {
	BasicNft private basicNft;
	string public constant PUG_URI = "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json"; 

	function setUp() external {
		DeployBasicNft deployBasicNft = new DeployBasicNft();
		basicNft = deployBasicNft.run();
	}

	function testNameIsCorrect() external view {
		string memory name = basicNft.name();
		assertEq(name, "Doggie");
	} 

}
