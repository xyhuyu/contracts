pragma solidity ^0.5.0;

import 'openzeppelin-solidity/contracts/token/ERC20/ERC20.sol';
import 'openzeppelin-solidity/contracts/token/ERC20/ERC20Detailed.sol';
import "./Ownable.sol";

contract YMChainToken is ERC20, ERC20Detailed, Ownable {
	string private _name = "YMChainToken";
	string private _symbol = "YMC";
	uint8 private _decimals = 18;
	uint256 private _totalSupply = 2000000000 * (10 ** uint256(_decimals));

	//代币初始化
	constructor(address _owner) Ownable(_owner) public ERC20Detailed(_name, _symbol, _decimals) {
		_mint(_owner, _totalSupply);

	}
}

