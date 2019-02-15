pragma solidity >=0.4.22 <0.6.0;

//Reward System given in other contracts

contract bETHerHealth {
    function newInsuranceAt(address _address) public;
}

contract insurance {
    
    uint reputation;
    
    mapping(uint => string) reward_text;
    mapping(uint => uint) reward_cost;
    mapping(uint => uint) reward_time;
   // uint public conversionRate;
    
    address owner;
    uint deployTime;
    
    constructor(address _bETHerHealth) public {
        bETHerHealth(_bETHerHealth).newInsuranceAt(this);
        owner = msg.sender;
        deployTime = now;
        reputation = 1;
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
    
    function addRep(uint _rep) public{
        reputation += _rep;
    }
    
    function getRep() public view returns (uint) {
        return reputation;
    }
    
    
    function getReward(uint _id) public returns (string, uint){
    //get Voucher from external (barcode/QR/...)
        if(now < reward_time[_id]) removeReward(_id);
        require(now>reward_time[_id]);
        string memory text = reward_text[_id];
        uint cost = reward_cost[_id];
        return (text,cost);
    }
    
    function addReward(/*uint _tier,*/ uint _id, string _text, uint _cost, uint _daysExisting) public{
        require(msg.sender==owner);
        require(now < deployTime + 1 weeks);
        reward_text[_id] = _text;
        reward_cost[_id] = _cost;
        reward_time[_id] = now + _daysExisting*60*60*24;
    }
    
    function removeReward(uint _id) private {
        reward_text[_id] = "";
        reward_cost[_id] = 0;
    }
    
    
}
