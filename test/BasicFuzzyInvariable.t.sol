import "../contracts/BasicFuzzyInvariable.sol";
import "forge-std/Test.sol";

contract BasicFuzzyInvariableTest is Test {
    uint256 public privateKey = 1234;
    address public signer;
    BasicFuzzyInvariable public contractToTest;
    uint256 public value = 0;

    function setUp() public {
        contractToTest = new BasicFuzzyInvariable();
        bytes4 selector = BasicFuzzyInvariable.doSomething.selector;
        bytes4[] memory selectors = new bytes4[](1);
        selectors[0] = selector;

        targetContract(address(contractToTest));
        targetSelector(
            FuzzSelector({
                addr: address(contractToTest),
                selectors: selectors
            })
        );
    }

    function test_fuzz_doSomething(uint256 data) public {
        contractToTest.doSomething(data);
        assertEq(contractToTest.shouldAlwaysBeZero(), 0);
    }

    function invariant_check() public {
        assertEq(contractToTest.shouldAlwaysBeZero(), 0);
    }
}