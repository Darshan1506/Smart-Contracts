//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HotelRoom {
    //Ether payments
    //Modifiers
    //Visibility
    //Events
    //Enums

    //1st pay the owner
    //vact pr occupied

    enum Statuses {vacat , Occupied}  // enum is collection of object that is not gonna changes
    Statuses public currentStatus;

    event Occupy(address _occupant,uint _value);  // event is basically the console.log is like those .. so it is taking the address of occupant and the cost in which theyy book the hotel

    address payable public owner;   //payable is a modifier which lets this address recieve crypto currency

    constructor() {    //initial values
        owner = payable(msg.sender);
        currentStatus = Statuses.vacat;
    }

    // one another way to reduce lines of code in fucntion is by using modifier .. first we define it and then decalre it in function and that code of line in modifier will run in function
    modifier onlyWhileVacant {
        require(currentStatus == Statuses.vacat,"currently occupied");
        _;
    }

    modifier costs(uint _amount){
        require(msg.value >= _amount,"Not enough ether provided");
        _;
    }

    function book() public payable onlyWhileVacant costs(2 ether){
        //check price of hotel
        // require(msg.value >= 2 ether,"Not enough ether provided") // wecan do this in modifier way too
        //check status (make sure it isn't booked twice)
        // require(currentStatus == Statuses.vacat,"currently occupied"); // we can put anything inside require to check whther it is true or false .. if true then function further 
        // execution will happen if false it won't execute the further execution of function

        currentStatus = Statuses.Occupied;
        // owner.transfer(msg.value);  // paying the owner .... this function will be called by someonw who wants to book room
        (bool sent, bytes memory data) =  owner.call{value:msg.value}("");
        emit Occupy(msg.sender,msg.value); //this will run the event which we declared alert::
    }
}