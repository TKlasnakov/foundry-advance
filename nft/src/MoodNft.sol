// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import { ERC721 } from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import { Base64 } from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNft is ERC721 {
	error MoodNft__CantFlipMoodIfNotOwner();

	uint256 private s_tokenCounter;
	string private s_sadSvgImageUri;
	string private s_happySvgImageUri;

	enum Mood {
		HAPPY,
		SAD
	}

	mapping(uint256 => Mood) s_tokenIdMood;

	constructor (
		string memory happySvgImageUri,
		string memory sadSvgImageUri
	)
	ERC721("Mood NFT", "MN") {
		s_tokenCounter = 0;
		s_sadSvgImageUri = sadSvgImageUri;
		s_happySvgImageUri = happySvgImageUri;
	}	

	function mintNft() public {
		_safeMint(msg.sender, s_tokenCounter);
		s_tokenIdMood[s_tokenCounter] = Mood.HAPPY;
		s_tokenCounter ++;
	}

	function flipMode(uint256 tokenId) public view {
		if(!_isAuthorized(_ownerOf(tokenId), msg.sender, tokenId)) {
			revert MoodNft__CantFlipMoodIfNotOwner();
		}

		if (s_tokenIdMood[tokenId] == Mood.HAPPY) {
			s_tokenIdMood[tokenId] == Mood.SAD;
		} else {
			s_tokenIdMood[tokenId] == Mood.HAPPY;
		}
	}

	function _baseURI() internal pure override returns (string memory) {
		return "data:appication/json;base64,";
	}

	function tokenURI(uint256 tokenId) public view override returns (string memory) {
		string memory imageUri;

		if (s_tokenIdMood[tokenId] == Mood.HAPPY) {
			imageUri = s_happySvgImageUri;
		} else {
			imageUri = s_sadSvgImageUri;
		}

		return
			string (
				abi.encodePacked (
					_baseURI(),
					Base64.encode (
						bytes (
							abi.encodePacked (
								'{"name": "',
									name(),
									'", "description": An NFT that reflects the owner mood.", "attributes":'
									'[{"trait_type": "moodiness", "value": 100}], "image": "',
									imageUri,
									'"}'
							)
						)
					)
				)
			);
	}
}
