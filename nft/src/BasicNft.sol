// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import { ERC721 } from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BasicNft is ERC721 {
	uint256 private s_tokenCounter;
	mapping(uint256 => string) private s_tokenURIs;
	
	constructor() ERC721("Doggie", "Dog") {
		s_tokenCounter = 0;
	}

	function mintNft(string memory _tokenURI) public {
		uint256 tokenId = s_tokenCounter;
		s_tokenURIs[tokenId] = _tokenURI;
		_safeMint(msg.sender, tokenId);
		s_tokenCounter++;
	}

	function tokenURI(uint256 _tokenId) public view override returns (string memory) {
		return s_tokenURIs[_tokenId];
	}

}
