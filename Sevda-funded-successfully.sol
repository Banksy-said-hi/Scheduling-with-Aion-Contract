pragma solidity ^0.4.24;

// interface Aion
contract AionContract {
    uint256 public serviceFee;
    function ScheduleCall(uint256 blocknumber, address to, uint256 value, uint256 gaslimit, uint256 gasprice, bytes data, bool schedType) public payable returns (uint,address);

}

// Main contract
contract SinaContract{

    address public Reciever;

    uint256 public sqrtValue;
    uint256 public Nonce;
    uint256 public Interval;
    uint256 public TotalAmount;

    AionContract aion;

    constructor(address _reciever) public {
        Reciever = _reciever;
    }



    function schedule_rqsr(uint256 _secFromNow) public {
        // require(address(this).balance >= 12*TotalAmount/10, "Please provide more funds to the contract!!");
        // Kovan Aion Contract
        aion = AionContract(0x2fC197cD7897f41957F72e8E390d5a7cF2858CBF);
        bytes memory data = abi.encodeWithSelector(bytes4(keccak256('transfer()')));
        uint callCost = 800000*100e9 + aion.serviceFee();
        aion.ScheduleCall.value(callCost)( block.timestamp + _secFromNow, address(this), 0, 800000, 100e9, data, true);
    }

    function transfer() public {
        Reciever.transfer(9*(address(this).balance)/10);
    }



    function getTimeStamp() public view returns(uint) {
        return block.timestamp;
    }
    
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
    
    function () public payable {}   
}
