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
    
    string public name = 'Krama';
    string public repository = 'https://github.com/vokaEntropy/krama-solidity';

    enum Status { NotPaid, Paid }
    Status public currentStatus = Status.NotPaid;

    constructor() {
        owner = msg.sender;
    }

    function getYourBalance(address targetAddress) public view returns(uint) {
       return targetAddress.balance;
    }

    function getMaxVersion() public {
        maxVersion = type(int8).max;
    }

    function sendMoney() public payable {
        payments[msg.sender] = msg.value;
        currentStatus = Status.Paid;
    }

    // function getPayments() public view returns(memory mapping(address => uint)) {
    //    return payments;
    // }

    function sendMoneyOwner() public payable {
        // Local, temp vars
        address payable _to = payable(owner);
        address _kramaContract = address(this);

        _to.transfer(_kramaContract.balance);
    }
}