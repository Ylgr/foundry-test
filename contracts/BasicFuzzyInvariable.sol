pragma solidity ^0.8.13;

contract BasicFuzzyInvariable {
    uint256 public shouldAlwaysBeZero = 0;
    uint256 hiddenValue = 0;

    function doSomething(uint256 data) public {
//        if(data == 0) {
//            shouldAlwaysBeZero = 1;
//        }
//        if(hiddenValue == 7) {
//            shouldAlwaysBeZero = 1;
//        }
        hiddenValue = data;
    }

//    function fail() public {
//        revert("fail");
//    }
}