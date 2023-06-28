pragma solidity ^0.8.13;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/AccessControlEnumerableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20BurnableUpgradeable.sol";

contract TokenERC20 is Initializable, ERC20BurnableUpgradeable, AccessControlEnumerableUpgradeable {

    bytes32 public constant MINT_ROLE = keccak256("MINT_ROLE");

    function initialize(string memory name, string memory symbol, uint256 initialSupply) public virtual initializer {
        __ERC20_init(name, symbol);
        __AccessControlEnumerable_init();
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _mint(msg.sender, initialSupply);
    }

    function mint(address to, uint256 amount) public virtual {
        require(hasRole(MINT_ROLE, msg.sender), "ERC20Token: must have minter role to mint");
        _mint(to, amount);
    }

    function mintFuzz(address to, uint256 amount) public virtual {
        require(hasRole(MINT_ROLE, msg.sender), "ERC20Token: must have minter role to mint");
        require(amount % 10e18 == 0, "ERC20Token: amount must be multiple of 10e18");
        _mint(to, amount);
    }

    function mintInvariable(address to, uint256 amount) public virtual {
        require(hasRole(MINT_ROLE, msg.sender), "ERC20Token: must have minter role to mint");
        _mint(to, amount);
        _revokeRole(MINT_ROLE, msg.sender);
    }
}
