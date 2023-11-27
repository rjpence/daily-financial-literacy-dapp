//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

// Useful for debugging. Remove when deploying to a live network.
import "hardhat/console.sol";

// Use openzeppelin to inherit battle-tested implementations (ERC20, ERC721, etc)
// import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * A smart contract that allows changing a state variable of the contract and tracking the changes
  * @author rjpence
 */
contract YourContract {
	// State Variables
	address public owner;
	uint256 public readCounter = 0; //total reads among all users
	mapping (address => uint) public userReadCounter; //individual total reads among users

	event logContentConsumed(address indexed sender, string message);

	// Constructor: Called once on contract deployment
	// Check packages/hardhat/deploy/00_deploy_your_contract.ts
	constructor(address _owner) {
		owner = _owner;
	}

	modifier isOwner() {
		// msg.sender: predefined variable that represents address of the account that called the current function
		require(msg.sender == owner, "Not owner");
		_;
	}

	//Upon executing function, readCounter adds one more total read and userReadCounter one more read per user 
	function userAction(address _user) isOwner public  {
		readCounter +=1;
		userReadCounter[_user] += 1;
		emit logContentConsumed(_user, "Content Confirmed");
		console.log("Content Confirmed");
		
	}
	
}
