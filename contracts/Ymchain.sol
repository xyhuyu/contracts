pragma solidity ^0.5.0;

import 'openzeppelin-solidity/contracts/token/ERC20/ERC20.sol';
import 'openzeppelin-solidity/contracts/token/ERC20/ERC20Detailed.sol';
import "./Ownable.sol";

contract Ymchain is ERC20, ERC20Detailed, Ownable {
	string private _name = "YMChain";
    string private _symbol = "YMC";
    uint8 private _decimals = 18;
    uint256 private _totalSupply = 2000000000 * (10 ** uint256(_decimals));

	//代币初始化
    constructor(address _owner) Ownable(_owner) public ERC20Detailed(_name, _symbol, _decimals) {
		_mint(_owner, _totalSupply);

    }

    //游戏管理
	event eventSetGame(uint _gameId, string name);

 	struct Game {
		string name;
	}
	mapping(uint => Game) public _games;

	function setGame(uint gameid, string memory name) onlyOwner public {
        _games[gameid].name = name;
        emit eventSetGame(gameid, name);
    }

    function getGame(uint gameid) view public returns (string memory) {
        return _games[gameid].name;
    }

	//用户管理: 名称、等级
	event eventSetMember(uint _memberId, string name, string level);

	struct Member {
		string name;
		string level;
	}
	mapping(uint => Member) public _members;

	function setMember(uint memberId, string memory name, string memory level) onlyOwner public {
		Member memory item;
		item.name = name;
		item.level = level;
		_members[memberId] = item;
		emit eventSetMember(memberId, name, level);
	}

	function getMember(uint memberId) view public returns (string memory, string memory) {
		return (_members[memberId].name, _members[memberId].level);
	}

}

