// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";

contract MyToken is ERC1155, ERC1155Burnable, Ownable, ERC1155Supply {

    uint256 public constant GOLD = 0;
    uint256 public constant SILVER = 1;
    uint256 public constant THORS_HAMMER = 2;
    uint256 public constant SWORD = 3;
    uint256 public constant SHIELD = 4;

    constructor() 
        ERC1155("https://coral-capable-damselfly-94.mypinata.cloud/ipfs/QmTSGW3B9kSmKkuZG5KHdDw9bwCwvRf7gwdTTra18dPH8L?pinataGatewayToken=e-B2EB859wsZHYE_KNKyzVRrSp1Y5CuGlIwfVkWhdTGQH2CRNH7gL_YteosVRkl3")
        Ownable(initialOwner) {

            _mint(msg.sender, GOLD, 10**18, "");
            _mint(msg.sender, SILVER, 10**27, "");
            _mint(msg.sender, THORS_HAMMER, 1, "");
            _mint(msg.sender, SWORD, 10**9, "");
            _mint(msg.sender, SHIELD, 10**9, "");

        }

    function uri(string _gateway, string _cid, string _gatewayId) override public pure returns(string memory) {
        return string(abi.encodePacked(
            "https://",
            Strings.toString(_gateway),
            ".cloud/ipfs/",
            Strings.toString(_cid),
            "?pinataGatewayToken=",
            String.toString(_gatewayId)
            ));
    }

    function mint(address account, uint256 id, uint256 amount, bytes memory data)
        public
        onlyOwner
    {
        _mint(account, id, amount, data);
    }

    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)
        public
        onlyOwner
    {
        _mintBatch(to, ids, amounts, data);
    }

    // The following functions are overrides required by Solidity.

    function _update(address from, address to, uint256[] memory ids, uint256[] memory values)
        internal
        override(ERC1155, ERC1155Supply)
    {
        super._update(from, to, ids, values);
    }
}
