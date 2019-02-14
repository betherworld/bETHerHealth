pragma solidity >=0.4.22 <0.6.0;

//Reward System given in other contracts

contract bETHerHealth {
    function newInsuranceAt(address _address) public;
}

contract insurance {
    
    uint reputation;
    
    mapping(uint => string) rewards;
   // uint public conversionRate;
    
    address owner;
    uint deployTime;
    
    constructor(address _bETHerHealth) public {
        bETHerHealth(_bETHerHealth).newInsuranceAt(this);
        owner = msg.sender;
        deployTime = now;
    }
 /*   
    function setConversionRate(uint _conversionRate) public {
        require(msg.sender == owner);
        conversionRate = _conversionRate;
    }
    
    function getConversionRate() public view returns (uint){
        return conversionRate;
    }
    */
    
    function addRep(uint _rep) public {
        reputation += _rep;
    }
    
    function getRep() public view returns (uint) {
        return reputation;
    }
    
    
    function getReward(/*uint _tier,*/ uint _id) public view returns (string){
    //get Voucher from external (barcode/QR/...)
        return rewards[_id];
    }
    
    function addReward(/*uint _tier,*/ uint _id, string _text) public{
        require(msg.sender==owner);
        require(now < deployTime + 1 weeks);
        rewards[_id] = _text;
    }
    
    function removeReward(uint _id) public {
        rewards[_id] = "" ;
    }
    
    
}
