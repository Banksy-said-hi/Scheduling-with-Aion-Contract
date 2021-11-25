pragma solidity ^0.4.24; 

// AION INTERFACE 
contract Aion {
    uint256 public serviceFee;
    function ScheduleCall(
        uint256 blocknumber,
        address to, 
        uint256 value, 
        uint256 gaslimit, 
        uint256 gasprice, 
        bytes data, 
        bool schedType
        ) public payable returns (uint,address);
}

// OUR MAIN CONTRACT
contract MyContract {


    uint256 public result;
    Aion aion;


    // This function will schedule executing add() function in 30 seconds from clicking
    function schedule_add(uint256 x, uint y) public {
        aion = Aion(0xFcFB45679539667f7ed55FA59A15c8Cad73d9a4E);
        bytes memory data = abi.encodeWithSelector(bytes4(keccak256('add(uint256,uint256)')),x,y); 
        uint callCost = 200000*1e9 + aion.serviceFee();
        aion.ScheduleCall.value(callCost)( block.timestamp + 30 seconds, address(this), 0, 200000, 1e9, data, true);
    }


    // Our customized function for witnessing intended results 
    function add(uint x, uint y) public {
        result = x + y;
    }

    // Before scheduling any event (-By clicking schedule_add()-) make sure to send enough funds to the contract
    function () public payable {}

}
