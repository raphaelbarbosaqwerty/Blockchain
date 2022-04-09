// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

uint256 constant TOTAL_NFTS = 10;

contract GabulNft {
    address public owner = msg.sender;

    struct NFT {
        uint256 price;
        address owner;
    }

    NFT[TOTAL_NFTS] public nfts;

    constructor() {
        for (uint256 i = 0; i < 10; i++) {
            nfts[i].price = 1e17; // 0.1 ETH
            nfts[i].owner = address(0x0);
        }
    }

    function buy(uint256 _index) external payable {
        require(_index < TOTAL_NFTS && _index >= 0);
        require(nfts[_index].owner == address(0x0));
        require(msg.value >= nfts[_index].price);
        nfts[_index].owner = msg.sender;
    }

    function getTotalNfts() external view returns (uint256) {
        return nfts.length;
    }

    function getNftOwnerByIndex(uint256 _index)
        external
        view
        returns (address)
    {
        return nfts[_index].owner;
    }

    function getTotalNftQuantityByOwner(address _address)
        external
        view
        returns (uint256)
    {
        uint256 total = 0;
        for (uint256 i = 0; i < nfts.length; i++) {
            if (nfts[i].owner == _address) {
                total++;
            }
        }
        return total;
    }

    function getNftById(uint256 _index)
        external
        view
        returns (uint256, address)
    {
        return (nfts[_index].price, nfts[_index].owner);
    }
}
