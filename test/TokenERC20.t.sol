// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../contracts/TokenERC20.sol";

contract TokenERC20Handle is StdUtils {
    TokenERC20 public tokenContract;
    uint256 public totalMint = 0;
    address public owner;
    constructor(TokenERC20 _tokenContract, address _owner) {
        tokenContract = _tokenContract;
        owner = _owner;
    }

    function mintInvariable(uint256 amount) public {
        amount = bound(amount, 1, 100*10e18);
        tokenContract.mintInvariable(owner, amount);
        totalMint += amount;
    }
}

contract TokenERC20Test is Test {

    uint256 public privateKey = 1234;
    address public signer;
    TokenERC20 public tokenContract;
    TokenERC20Handle public handler;
    string public name = "Test";
    string public symbol = "TT";
    uint256 public initialSupply = 1000000;

    function setUp() public {
        signer = vm.addr(privateKey);
        vm.startPrank(signer);
        tokenContract = new TokenERC20();
        tokenContract.initialize(name, symbol, initialSupply);
        tokenContract.grantRole(tokenContract.MINT_ROLE(), signer);
        handler = new TokenERC20Handle(tokenContract, signer);
        deal(address(handler), 100*10e18);
        tokenContract.grantRole(tokenContract.MINT_ROLE(), address(handler));
        bytes4 selector = TokenERC20Handle.mintInvariable.selector;
        bytes4[] memory selectors = new bytes4[](1);
        selectors[0] = selector;

        targetContract(address(handler));
        targetSelector(
            FuzzSelector({
                addr: address(handler),
                selectors: selectors
            })
        );
    }

    function test_init_information() public {
        assertEq(tokenContract.name(), name);
        assertEq(tokenContract.symbol(), symbol);
        assertEq(tokenContract.totalSupply(), initialSupply);
    }

    function test_fuzz_mintInvariable_token(uint96 amount) public {
        tokenContract.mintInvariable(signer, amount);
        assertEq(tokenContract.balanceOf(signer), initialSupply + amount);
    }

    function test_fuzz_mint_token(uint96 amount) public {

        tokenContract.mintFuzz(signer, amount);
        assertEq(tokenContract.balanceOf(signer), initialSupply + amount);
    }

    function invariant_test_mint_token() public {
        assertGe(handler.totalMint(), 0);
    }
}
