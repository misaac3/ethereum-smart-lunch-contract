/**
 * Lunch is a contract that allows for up to 10 people pay for lunch together
 */
contract Lunch {
	
	address public organizer; // address represents an account 
	mapping (address => bool) public attendeeJoined; //hashmap of addresses to booleans
	uint public numOfAttendees; // an uint is an unsigned integer which saves space
	uint public limit;
	uint public totalCost;

	//Contract Constructor
	function Lunch ()  {
		organizer = msg.sender;
		limit = 10;
		numOfAttendees = 0;
		totalCost = 100;
	}


	//public method that changes the total cost of the lunch
	//only available to the organizer of the contract
	function changeTotalCost (uint newTotalCost) public {
		if(msg.sender != organizer){
			return;
		}
		totalCost = newTotalCost;
	}

	/*
	public method that lets people to attend the lunch 
	as long as it is under the limit of the possible.
	
	payable indicates that real money can be transferred 
	using ether, however this method does not require it here 
	*/
	function attend () public payable returns(bool) {
		if (numOfAttendees >= limit){
			return false; 
		}
		attendeeJoined[msg.sender] = true;
		numOfAttendees++;
		return true;
		
	}

	//public method that returns the number of available spots left at lunch
	function getAvailable () public returns(uint) {
		return limit - numOfAttendees;

	}

	//checks if a person is in attendace of the lunch
	function checkAttendance (address people) public returns(bool) {
		return attendeeJoined[people];
	}

	// returns the amount that each person would have to pay if the bill was split evenly
	function splitCost () public returns(uint) {
		return totalCost / numOfAttendees;
	}

	//kill method recovers funds that are involved in the contract and returns
	//them to their original owner
	function kill (){
		if(msg.sender == organizer){
			suicide(organizer);
		}
	}
	
	
	
	
	
	

}
