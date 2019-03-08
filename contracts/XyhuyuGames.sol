pragma solidity ^0.5.0;

import "./WhitelistedRole.sol";

contract XyhuyuGames is WhitelistedRole {

	constructor(address _owner) WhitelistedRole(_owner) public{

	}

	//游戏管理
	event eventSetGame(uint _gameId, string name);

 	struct Game {
		string name;
	}
	mapping(uint => Game) public _games;

	function setGame(uint gameid, string memory name) onlyWhitelisted public {
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

	function setMember(uint memberId, string memory name, string memory level) onlyWhitelisted public {
		Member memory item;
		item.name = name;
		item.level = level;
		_members[memberId] = item;
		emit eventSetMember(memberId, name, level);
	}

	function getMember(uint memberId) view public returns (string memory, string memory) {
		return (_members[memberId].name, _members[memberId].level);
	}


	//添加用户账号下的所属游戏账号
	mapping(uint => uint[]) _memberGameIdsMapping;

	//设置平台账号下的所有游戏账号ID
	function setMemberGameIds(uint memberId, uint gameId) onlyWhitelisted public {
		uint [] storage memberGameIdsStorage = _memberGameIdsMapping[memberId];
		memberGameIdsStorage.push(gameId);
	}

	//获取平台账号下的所有游戏账号ID
	function getMemberGameIds(uint memberId) public view returns (uint[] memory) {
		return _memberGameIdsMapping[memberId];
	}

	//删除平台账号下某个游戏账号
	function deleteMemberGameId(uint memberId, uint gameId) onlyWhitelisted public {

		uint[] storage memberGameIdsStorage = _memberGameIdsMapping[memberId];

		for (uint i = 0; i < memberGameIdsStorage.length; i++) {
			if (gameId == memberGameIdsStorage[i]) {
				for (uint k = i; k < memberGameIdsStorage.length - 1; k++) {
					memberGameIdsStorage[k] = memberGameIdsStorage[k + 1];
				}
				memberGameIdsStorage.length--;
			}
		}
	}

	//记录日志
	event eventSetLog(uint logId, string str);
	mapping(uint => string) _logMapping;

	function setLog(uint logId, string memory str) onlyWhitelisted public {
		_logMapping[logId] = str;
		emit eventSetLog(logId, str);
	}

	function getLog(uint logId) view public returns (string memory) {
		return _logMapping[logId];
	}
}

