// 2_deploy_contract.js；truffle migrate 命令的执行顺序与文件名有关，所以多个部署脚本需要按照顺序命名

var Ymchain = artifacts.require("YMChainToken");
var XyhuyuGames = artifacts.require("XyhuyuGames");

module.exports = function(deployer) {
	deployer.deploy(Ymchain);
	deployer.deploy(XyhuyuGames);
};