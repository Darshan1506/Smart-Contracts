//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


//Import ERC20 Contract from openzeppline
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract LearnWithDarshanToken is ERC20 {

    // we also want to call constructor present
    //inside ERC20     
    constructor(string memory _name,string memory _symbol) ERC20(_name,_symbol){
        
        // GET some token for our self
        //msg..sender person deploying contarct
        _mint(msg.sender,1000*(10**18));
    }
    function mint()public{
        _mint(msg.sender,1000*(10**18));
    }
}

