pragma solidity ^0.4.24;

// interface Aion
contract AionContract {
    uint256 public serviceFee;
    function ScheduleCall(uint256 blocknumber, address to, uint256 value, uint256 gaslimit, uint256 gasprice, bytes data, bool schedType) public payable returns (uint);


}

// Main contract
contract SinaContract{

    AionContract aion;
    address public Reciever;

    constructor(address _reciever) public {
        Reciever = _reciever;
    }

    function scheduleTransaction(uint256 _fromNow) public {
        aion = AionContract(0x2fC197cD7897f41957F72e8E390d5a7cF2858CBF);
        uint256 callCost = 10e16 + 800000*100e9 + aion.serviceFee();
        aion.ScheduleCall.value(callCost)( block.timestamp + _fromNow, Reciever, 10e16, 800000, 100e9, hex"00", true);
    }

    function () public payable {}

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    function getTimeStamp() public view returns(uint) {
        return block.timestamp;
    }
}
