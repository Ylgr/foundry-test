// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../contracts/TokenERC20.sol";

contract TokenERC20Test is Test {

    uint256 public privateKey = 1234;
    address public signer;
    TokenERC20 public tokenContract;
    string public name = "Test";
    string public symbol = "TT";
    uint256 public initialSupply = 1000000;

    function setUp() public {
        signer = vm.addr(privateKey);
        tokenContract = new TokenERC20();
        tokenContract.initialize(name, symbol, initialSupply);
    }

    function test_init_information() public {
        assertEq(tokenContract.name(), name);
        assertEq(tokenContract.symbol(), symbol);
        assertEq(tokenContract.totalSupply(), initialSupply);
    }
}
