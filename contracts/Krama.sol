// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

// The Best shop in the world!
contract Krama {
    // State
    // Saving to blockchain
    address owner;
    mapping (address => uint) payments;

    // Minimal in uint - uint8
    int8 public version = -127;
    
    string public name = 'Krama';
    string public repository = 'https://github.com/vokaEntropy/krama-solidity';

    enum Status { NotPaid, Paid }
    Status public currentStatus = Status.NotPaid;

    constructor() {
        owner = msg.sender;
    }

    // Scope types   - public, external, internal, private
    // And modifiers - view (read data), pure (don't read memory data), paybale
    function getBalance() public view returns(uint balance) {
        balance = address(this).balance;
        // no need
        // return balance;
    }

    function getMaxVersion() public pure returns(int8 max) {
        max = type(int8).max;
    }

    function changeContractName(string memory newName) external{
        name = newName;
    }

    function sendMoney() public payable {
        payments[msg.sender] = msg.value;
        currentStatus = Status.Paid;
    }

    function sendMoneyOwner() public payable {
        // Local, temp vars
        address payable _to = payable(owner);
        address _kramaContract = address(this);

        _to.transfer(_kramaContract.balance);
    }
}