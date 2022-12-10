//Get funds from Users
//Withdraw funds
//Set a minimum funding value in USD

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "./PriceConverter.sol";

contract FundMe {

    using PriceConverter for uint256;
    uint256 public constant MINIMUM_USD = 50*1e18; 
    mapping(address => uint256) public addressToAmountFunded;
    address[] public funders;

    //owner
    address public immutable i_owner;
    constructor(){
        i_owner = msg.sender;
    }

    function fund() public payable {
        //we should be able to send a minimum funds in rupees
        //1. How do we send Eth to this contract?
        require(msg.value.getConversionRate() >= MINIMUM_USD,"add mmore fund");
        // since it is 18 decimals
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }


    // this withdraw function is only for owner
    function withdraw() public onlyOwner{
        // require(msg.sender == owner,"sender is not owner") modifier
        //for loop
        for(uint256 funderIndex = 0;funderIndex < funders.length;funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        // reset the array
        funders = new address[](0); // new funderss array with 0 objects in it blank new aaray
         // actually withdraw the funds // 3 ways 
         //transfer
        //  payable(msg.sender).transfer(address(this).balance);
         //send
        //  bool sendSuccess = payable(msg.sender).send(address(this).balance);
        //  require(sendSuccess,"send failed")
         //call
         (bool callSuccess,) = payable(msg.sender).call{value:address(this).balance}("");
         require(callSuccess,"Call Failed");
         
    }
    // modifier
    modifier onlyOwner {
        require(msg.sender == i_owner,"sender is not owner");
        _;
    }
}