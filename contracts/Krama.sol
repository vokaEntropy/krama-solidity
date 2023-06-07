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

    // Run after add contract to blockchain one time
    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        if (msg.sender != owner) {
            revert(unicode"😡 WAT YOU DOING!!! THIS IS MY MONEY!!! 😡");
        }
        _;
    }

    // Scope types   - public, external, internal, private
    // And modifiers - view (read data), pure (don't read memory data), paybale
    function getBalance() public view onlyOwner returns(uint balance) {
        balance = address(this).balance;
        // no need
        // return balance;
    }

    function getMaxVersion() public view onlyOwner returns(int8 max) {
        max = type(int8).max;
    }

    function changeContractName(string memory newName) external onlyOwner{
        name = newName;
    }

    event Paid(address indexed _from, uint _amount, uint _timestamp);

    function pay() public payable {
        payments[msg.sender] = msg.value;
        currentStatus = Status.Paid;

        emit Paid(msg.sender, msg.value, block.timestamp);
    }

    function withdraw(address payable _to) external onlyOwner {
        // require(msg.sender == owner, unicode"😡 WAT YOU DOING!!! THIS IS MY MONEY!!! 😡");

        assert(true);
        _to.transfer(address(this).balance);
    }
}