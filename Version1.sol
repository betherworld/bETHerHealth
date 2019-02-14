pragma solidity >=0.4.22 <0.6.0;


//1 Contract per Company, keeps track of its runners
//TODO remove testingAddCoins before deploying
//


contract bETHerHealth {

    struct Runner {
        uint coincount;
        uint weekStart;
        uint weekDistance;
    }
    
    struct Reward {
        string description;
        uint cost;
    }
    
    uint weeklyLimit;
    uint usercount;
    uint intialCoins;
    address company;
    uint companyToken;

    mapping(address => Runner) runners;
    Reward[] rewards;
    
    /*unused
    uint wMultiplier;
    uint aMultiplier;
    */

    /// Create a new company account with _intialCoins of startvalue for the users.
    constructor(uint _intialCoins) public {
        company = msg.sender;
        companyToken = 0;
        intialCoins = _intialCoins;
    }
    
    //user creates account, maps Address to his data
    function createRunner() public {
        runners[msg.sender] = Runner(intialCoins,now,0);
    }

   //user registers Kilometers run, assigns based on Age and Weight Multiplier
   //but no more than weekly Limit
    function registerKm (uint _distance, uint _ageRate) public {
        
        Runner storage me = runners[msg.sender];
        
        if (now >= 1 weeks + me.weekStart) {
            me.weekStart += 1 weeks;
            uint bonus;
            if(me.weekDistance<weeklyLimit){
                bonus = me.weekDistance;
            }else{
                bonus = weeklyLimit;
            }
            uint generated = bonus * _ageRate;
            me.coincount += generated;
            companyToken += generated;
            me.weekDistance = _distance;
            
        }else{
            //add to existing distance
            me.weekDistance += _distance;
        }
    }
    
    
    function testingAddCoins (uint _amount) public returns (bool) {
        Runner storage me = runners[msg.sender];
        me.coincount += _amount;
        return true;
    }
    
    function getCoins () public view returns (uint) {
        return runners[msg.sender].coincount;
       
    }
    
    function getCoins(address addr) public view returns (uint) {
        require(msg.sender == company);
        return runners[addr].coincount;
    }
    
    function getCompanyTokens() public view returns (uint){
        return companyToken/usercount;
    }
    
    //claims a reward from the rewards-list
    function claimReward(uint _id) public {
        runners[msg.sender].coincount -= rewards[_id].cost;
    }
    
    //adds Reward with Description and Claim Cost
    function addReward(string _description, uint _cost) public returns (uint){
        require(msg.sender == company);
        uint id = rewards.push(Reward(_description, _cost)) - 1;
        return id;
    }
    
    
    
        
}
