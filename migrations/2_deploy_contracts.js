
var CoinCreator=artifacts.require('CoinCreator.sol')
module.exports = function(deployer,network, account) {
    deployer.then(async () => {
    await deployer.deploy(CoinCreator)
    }
)

};
