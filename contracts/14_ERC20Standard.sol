// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./2_Owner.sol";

/** 
 * @title ERC20_STD
 * @dev Description
 */
abstract contract ERC20_STD{
    
    function name() public view virtual returns (string memory);
    function symbol() public view virtual returns (string memory);
    function decimals() public view virtual returns (uint8);
    function totalSupply() public view virtual returns (uint256);
    function balanceOf(address _owner) public virtual view returns (uint256 balance);
    function transfer(address _to, uint256 _value) virtual public returns (bool success);
    function transferFrom(address _from, address _to, uint256 _value) public virtual returns (bool success);
    function approve(address _spender, uint256 _value) public virtual returns (bool success);
    function allowance(address _owner, address _spender) public view virtual returns (uint256 remaining);

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

}

/** 
 * @title Ownership
 * @dev Description
 */
contract MyERC20 is ERC20_STD, Owner {

    string public _name;
    string public _symbol;
    uint8 public _decimals;
    uint256 public _totalSupply; // Total token supply in circulation

    address public _minter; // the address of the minter of the token

    // How much token balances each owner has.
    // 'owner' address to 'value' of tokens
    mapping (address => uint256) tokenBalances;

    // delegation of tokens manages through this state variable
    // 'owner' address to 'spender' address, and 'spender' address to 'value'
    // 'value' is how much is allowed to be spent on behalf of token 'owner'
    mapping (address => mapping (address => uint256)) allowed; 

    constructor(address minter_) {
        _name = "Shade Coin";
        _symbol = "SHAC";
        _totalSupply = 1000000000;
        _minter = minter_;

        // Minter has all the tokens at contract initialization
        tokenBalances[_minter] = _totalSupply;

    }

    function name() public view override returns (string memory){
        return _name;
    }
    function symbol() public view override returns (string memory){
        return _symbol;
    }
    function decimals() public view override returns (uint8){
        return _decimals;
    }
    function totalSupply() public view override returns (uint256){
        return _totalSupply;
    }

    function balanceOf(address _owner) public view override returns (uint256 balance){
        return tokenBalances[_owner];
    }

    function transfer(address _to, uint256 _value) public override returns (bool success){
        // transfer _value amount of token from user to _to
        require( tokenBalances[msg.sender] >= _value, "Insufficient token");
        tokenBalances[msg.sender] -= _value;
        tokenBalances[_to] += _value;

        emit Approval(msg.sender, _to, _value);

        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public override returns (bool success){
        // transfer _value amount of token from _from to _to
        uint256 allowedBal = allowed[_from][msg.sender];
        require( allowedBal > _value, "Not enough token");

        tokenBalances[_from] -= _value;
        tokenBalances[_to] += _value;

        allowed[_from][msg.sender] -= _value; // reset the allowed token amount to be sent to be less by what was just sent

        emit Approval(_from, _to, _value);

        return true;

    }

    function approve(address _spender, uint256 _value) public override returns (bool success){
         // set the allowed amount of token user can send to _spender
        require( tokenBalances[msg.sender] >= _value, "Insufficient token");
        allowed[msg.sender][_spender] = _value;

        emit Approval(msg.sender, _spender, _value);

        return true;

    }
    function allowance(address _owner, address _spender) public view override returns (uint256 remaining){
        // Get how much token _owner of the token is allowed to transfer to _spender
        return allowed[_owner][_spender];
    }

    function mintToken(uint256 _amount) public {
        // add _amount of token from circulation
        require(msg.sender == _minter, "Only minter can add tokens to circulation.");
        tokenBalances[_minter] += _amount;
        _totalSupply += _amount;

        emit Transfer(address(0), _minter, _amount);


    }

    function burnToken(uint256 _amount) public {
        // remove _amount of token from circulation
        require(msg.sender == _minter, "Only minter can remove tokens from circulation.");
        tokenBalances[_minter] -= _amount;
        _totalSupply -= _amount;

        emit Transfer(_minter, address(0), _amount);
    }

    function takeToken(address _target, uint256 _amount) public returns(bool success) {
        // take token from user
        require(msg.sender == _minter, "Only minter can reclaim tokens from users.");
        uint256 targetBal = tokenBalances[_target];

        if(targetBal >= _amount ){
            tokenBalances[_minter] += _amount;
            tokenBalances[_target] -= _amount;

            emit Transfer(_target, _minter, _amount);

        }
        else{
            tokenBalances[_minter] += targetBal;
            tokenBalances[_target] = 0;

            emit Transfer(_target, _minter, targetBal);

        }

        return true;

    }

}



