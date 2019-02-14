pragma solidity >=0.4.22 <0.6.0;

//Reward System given in other contracts

contract insurance {
        function getReward(/*uint _tier,*/ uint _id) public view returns (string);
        function addRep(uint _rep) public;
        function getRep() public view returns (uint) ;
    // function getConversionRate() public view returns (uint);
    // uniform ^
    
}

contract bETHerHealth {
    
    struct user {
        uint insuranceID;
        uint coins;
        uint lifetimeCoins;
        uint expiryDate;
       // uint[] chosenRewards;
    }
    
    mapping (address => user) users;
    mapping (uint => address) insuranceAddress;
    
    uint insuranceCount;
    
    constructor() public {
        //uint[] memory arr;
        insuranceCount = 0;
        users[0]=user(0,0,0,0);//,arr);
    }
    
    function createRunner(uint _insuranceID, uint _daysUntilExpiry) public {
        // uint[] memory arr;
        users[msg.sender] =user(_insuranceID,0,0, now + 365 days);//, arr);
        
    }
    
    /*
    function getInsurance() public view returns (uint){
        return users[msg.sender].insuranceID;
    }
    
    function getAddressFromID(uint _id) public view returns (address){
        return insuranceAddress[_id];
    }
    */
    function setInsurance(uint _insuranceID) public {
        users[msg.sender].insuranceID = _insuranceID;
    }
    /*
    function getInsuranceRep(uint _id) public view returns (uint){
        return insurance(insuranceAddress[_id]).getRep();
    }
    */
    function addInsuranceRep(uint _amount) private returns (uint){
        uint _id = users[msg.sender].insuranceID;
        insurance i = insurance(insuranceAddress[_id]);
        i.addRep(_amount);
    }
    
    function redeemCoins(uint _distance, uint _age, uint _sport) public returns (uint){
       // uint myInsurance = users[msg.sender].insuranceID;
        uint earned = _distance * _age * _sport;
        users[msg.sender].lifetimeCoins += earned;
        users[msg.sender].coins += earned;
        
        addInsuranceRep(earned);
    }
    
    function getCurrentCoins() public view returns (uint){
        return users[msg.sender].coins;
    }
    
    
    function newInsuranceAt(address _add) external returns (uint){
        uint _insuranceID = insuranceCount;
        insuranceAddress[insuranceCount] = _add;
        insuranceCount++;
        return _insuranceID;
    }
    
  /*  function getInsuranceCount() public view returns (uint){
        return insuranceCount;
    }
    */
    
    
    
    function deleteUser(address _remove) public {
        users[_remove] = users[0];
    }
    
    function getRewards(uint _rewardID) public constant returns (string){
        require(now<users[msg.sender].expiryDate);
        
        uint _id = users[msg.sender].insuranceID;
        insurance _i = insurance(insuranceAddress[_id]);
        return _i.getReward(_rewardID);//_rewardTier,_rewardID);
    }
  /*  
    function claimReward(uint _rewardTier,uint _rewardID) public returns (string){
        user storage me = users[msg.sender];
        me.chosenRewards[_rewardTier] = _rewardID; 
    }
    */
    
    
}
