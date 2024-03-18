// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

// import "./2_Owner.sol";
import "./14_ERC20Standard.sol";

/** 
 * @title VendorSHAC
 * @dev Description
 */
contract VendorSHAC is Owner{
    // For deploying this contract, deploy the ff in sequence: 
    //    - Ownder.sol make chosen owner deploying account
    //    - MyERC20 with minter again as input
    //    - Use above contract address as myECR20 address when deploying
    
    MyERC20 _myERC20;
    address private VOwner;
    uint TokensPerEther = 100;

    event BuyToken(address indexed _buyer, uint256 _valueSent, uint256 _tokenQuantity);
    event SellToken(address indexed _seller, uint256 _howMany, uint256 _amount);
    event WithdrawBalance(address indexed _withdrawer, uint256 _contractBal);

    constructor(address myERC20_) {

        VOwner = msg.sender; // this must be the user running the contract - the owner
        _myERC20 = MyERC20(myERC20_); // This is the address of the erc20 contract
    }

    function buyToken() payable public returns(bool) {
        // buying from contract to user. msg.value is the value entered in the
        // value input of Deploy & Run transactions, not any input in functions
         require( msg.value >= 1, " min purchase is 1 ether." );

         uint tokenQty = ( msg.value / 1 ether ) * TokensPerEther;

         uint vendorTokenBal = _myERC20.balanceOf(address(this));

        require( vendorTokenBal >= tokenQty, " Not enough vendor token." );

        (bool sent) = _myERC20.transfer(msg.sender, tokenQty);
        require( sent, "Token transfer failed." );

        emit BuyToken(msg.sender, msg.value, tokenQty);

        return true;

    }

    function sellToken(uint howMany) payable public returns(bool) {
        // selling from Vendor to contract

        uint token = howMany % TokensPerEther;

        require(token == 0, "Must sell in multiple of 100." ); // Check that the tokens are in multipples of 100

        uint limit = _myERC20.allowance(msg.sender, address(this)); // Get how much user is allowed to transfer to vendor(this contract)

        require(limit >= howMany, "Exceeded allowed quantity." ); // Check that the allow amount to transfer to this contract

        uint etherQty = howMany / TokensPerEther; // convert from tokens into ether
        uint vendorBal = ( address(this).balance / 1 ether); // convert balance into ether

        require(vendorBal >= etherQty, "Insufficient vendor balance." ); // Check that the allow amount to transfer to this contract

        (bool success) = _myERC20.transferFrom(msg.sender, address(this), howMany);
        require( success, "Token transfer failed." );

        (bool sent, ) = msg.sender.call{ value: etherQty * 1e18 }(''); // Pay user in wei
        require(sent, "Failed to withdraw.");

        emit SellToken(msg.sender, howMany, etherQty);

        return true;

    }

    function withdraw() public  payable returns(bool){
        // Withdrawing from contract to vendor. Vendor must be selected for withdrawal up top
        require(msg.sender == VOwner, "Only vendor can withdraw.");

        uint contractBal = address(this).balance;
        require(contractBal > 0, "Nothing to withdraw.");

        (bool sent, ) = msg.sender.call{ value: contractBal }('');
        require(sent, "Failed to withdraw.");

        emit WithdrawBalance(msg.sender, contractBal);

        return true;

    }

}