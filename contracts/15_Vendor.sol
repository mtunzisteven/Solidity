// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./2_Owner.sol";
import "./14_ERC20Standard.sol";

/** 
 * @title VendorSHAC
 * @dev Description
 */
contract VendorSHAC is Owner{

    MyERC20 _myERC20;
    address private VOwner;
    uint TokensPerEther = 100;

    constructor(address myERC20_) {

        VOwner = msg.sender;
        _myERC20 = MyERC20(myERC20_);
    }

    function buyToken( uint howMany) payable public returns(bool) {
         require( msg.value >= 1, " min purchase is 1 ether." );

         uint tokenQty = msg.value * TokensPerEther;

         uint vendorTokenBal = _myERC20.balanceOf(address(this));
    }

}