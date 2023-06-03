// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

// The Best shop in the world!
contract Krama {
    // State
    // Saving to blockchain
    address owner;
    mapping (address => uint) payments;

    // Minimal in uint - uint8
    int8 public version = -128;
    int8 public maxVersion;

    constructor() {
        owner = msg.sender;
    }

    function getMaxVersion() public {
        maxVersion = type(int8).max;
    }

    function givePleaseYourMoney() public payable {
        payments[msg.sender] = msg.value;
    }

    function sendAllMoneyToOwner() public payable {
        // Local, temp vars
        address payable _to = payable(owner);
        address _kramaContract = address(this);

        _to.transfer(_kramaContract.balance);
    }
}