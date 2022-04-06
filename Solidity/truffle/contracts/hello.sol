// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract HelloWorld {
    string message = "Hello World";

    function setMessage(string memory newMessage) public payable {
        message = newMessage;
    }

    function hello() public view returns (string memory) {
        return message;
    }
}

/**
    let instance = await HelloWorld.deployed()
    instance.hello()
    instance.setMessage("Hi!")
    instance.hello()

    setMessage.call.("") => Don't value the value of the blockchain only executes the function with the new value.
    setMessage("") => I'll do a transaction and the value will be stored in the blockchain.
    
    value => We can pass a parameter with the Wei quantity.
 */
