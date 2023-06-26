pragma solidity ^0.8.13;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/AccessControlEnumerableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20BurnableUpgradeable.sol";


contract TokenERC20 is Initializable, ERC20BurnableUpgradeable, AccessControlEnumerableUpgradeable {
    function initialize(string memory name, string memory symbol, uint256 initialSupply) public virtual initializer {
        __ERC20_init(name, symbol);
        _mint(msg.sender, initialSupply);
    }

    function mint(address to, uint256 amount) public virtual {
        require(hasRole(DEFAULT_ADMIN_ROLE, msg.sender), "ERC20Token: must have admin role to mint");
        _mint(to, amount);
    }
}
