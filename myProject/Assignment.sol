// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.0;

contract PaymentChannel {
  // The address of the sender
  address payable public sender;
  // The address of the receiver
  address payable public receiver;
  // The amount of Ether to be sent
  uint public amount;

  // A flag indicating whether the receiver has confirmed receipt of the funds
  bool public received;
  
  // The contract constructor, which is called when the contract is deployed
  constructor(address payable _sender, address payable _receiver, uint _amount) payable   {
    // Store the addresses of the sender and receiver
    sender = _sender;
    receiver = _receiver;

    // Store the amount of Ether to be sent
    amount = _amount;

    // Initialize the received flag to false
    received = false;
  }

  // A function that allows the receiver to confirm receipt of the funds
  function confirmReceived() public {
    // Make sure that the caller is the receiver
    require(msg.sender == receiver, "Only the receiver can confirm receipt of funds.");

    // Set the received flag to true
    received = true;
  }

  // A function that allows the sender to release the funds to the receiver
  function release() public payable {
    // Make sure that the funds have been confirmed as received
    require(received, "Funds have not been confirmed as received.");

    // Make sure that the caller is the sender
    require(msg.sender == sender, "Only the sender can release the funds.");
    // Transfer the funds to the receiver
   receiver.transfer(amount);
  }

 
}
