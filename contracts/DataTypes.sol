// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract DataTypes {
    uint256 DECIMALS = 2;
    uint256 SCALING_FACTOR = 10 ** DECIMALS;
    
    
    uint[] public myArray;

    constructor() {}

    function printBoolOperation() public pure {
        bool isTrue = true;
        bool isFalse = false;
        console.log("Negate of isTrue is %o", !isTrue);
        console.log("Negate of isFalse is %o", !isFalse);
        console.log("isTrue && isFalse is %o", isTrue && isFalse);
        console.log("isTrue || isFalse is %o", isTrue || isFalse);
        console.log("isTrue == isFalse is %o", isTrue == isFalse);
        console.log("isTrue != isFalse is %o", isTrue != isFalse);
    }

    function printIntegerOperations() public pure {
        console.log("2 << 1 is %o", uint256(uint256(2) << uint256(1)));
        console.log("~1 is %o", ~uint8(1));
        console.log("1 ^ 2 is %o", uint8(1) ^ uint8(2));
        console.log("5 % 3 is %o", uint256(uint256(5) % uint256(3)));
        console.log("Expo of 2^3 is %o", uint256(2) ** uint256(3));
    }

    function printFloatingOperations(
        uint256 a,
        uint256 b
    ) public view returns (string memory, string memory) {
        string memory aStr = printFloatAsString(multiply(a, b));
        string memory bStr = printFloatAsString(divide(a, b));
        console.log(aStr, bStr);
        return (aStr, bStr);
    }

    function printAddressOperations(address payable addr) public view {
        console.log("Address is %s", addr);
        console.log("Address balance is %s", addr.balance);
    }

    function divide(uint256 a, uint256 b) public view returns (uint256) {
        require(b != 0, "Division by zero");
        return (a * SCALING_FACTOR) / b;
    }

    function multiply(uint256 a, uint256 b) public view returns (uint256) {
        return ((a * b) / SCALING_FACTOR);
    }

    function add(uint256 a, uint256 b) public pure returns (uint256) {
        return a + b;
    }

    function subtract(uint256 a, uint256 b) public pure returns (uint256) {
        require(a >= b, "Subtraction would result in negative value");
        return a - b;
    }

    function printFloatAsString(
        uint256 val
    ) internal view returns (string memory) {
        uint256 integerPart = val / SCALING_FACTOR;
        uint256 fractionalPart = val % SCALING_FACTOR;
        return
            string(
                abi.encodePacked(
                    uint2str(integerPart, false),
                    ".",
                    uint2str(fractionalPart, true)
                )
            );
    }

    function uint2str(
        uint256 _i,
        bool isFraction
    ) internal view returns (string memory _uintAsString) {
        if (_i == 0) {
            return "0";
        }
        uint256 j = _i;
        uint256 len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        uint256 fractionLen = len;
        if (DECIMALS > len && isFraction) {
            fractionLen = DECIMALS;
        }

        bytes memory bstr = new bytes(fractionLen);
        uint256 k = fractionLen - 1;

        while (k >= 0) {
            if (len == 0) {
                bstr[k] = bytes1(uint8(48));
            } else {
                uint8 temp = (48 + uint8(_i % 10));
                bstr[k] = bytes1(temp);
                _i /= 10;
                len--;
            }
            if (k == 0) {
                break;
            }
            k--;
        }
        return string(bstr);
    }
}
