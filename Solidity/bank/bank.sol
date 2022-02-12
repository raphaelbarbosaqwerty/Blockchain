// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Bank {
    mapping(address => uint256) balance;
    address admin;

    modifier onlyAdmin() {
        require(msg.sender == admin, "You don't have permissions!");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    function addBalance(uint256 _toAdd) public onlyAdmin returns (uint256) {
        balance[msg.sender] += _toAdd;
        return balance[msg.sender];
    }

    function getBalance() public view returns (uint256) {
        return balance[msg.sender];
    }

    function transferBalance(address recipient, uint256 _amount) public {
        require(balance[msg.sender] >= _amount, "Balance not sufficiente");
        require(msg.sender != recipient, "Don't transfer money to yourself");
        uint256 previousBalance = balance[msg.sender];

        _transfer(msg.sender, recipient, _amount);
        assert(balance[msg.sender] == previousBalance - _amount);
    }

    function _transfer(
        address from,
        address recipient,
        uint256 _transferRemove
    ) private {
        balance[from] -= _transferRemove;
        balance[recipient] += _transferRemove;
    }
}
