// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./SimpleNFT.sol";

contract SimpleNFTCustodian {
  SimpleNFT public simpleNft;

  function setSimpleNftAddress(SimpleNFT instanceAddress) public {
    simpleNft = instanceAddress;
  }

  function buyNft(uint256 nftId) public payable {
    uint salePrice = simpleNft.getSalePrice(nftId);
    uint amountPaid = msg.value;

    require(amountPaid >= salePrice);

    address payable currentOwner = payable(simpleNft.ownerOf(nftId));

    currentOwner.transfer(amountPaid);
    simpleNft.transferNft(currentOwner, msg.sender, nftId);
    simpleNft.markAsSold(nftId);
  }
}
