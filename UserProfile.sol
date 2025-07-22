// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
 //A simplified contract for users to register and manage their profile.
 
contract UserProfile {

    // Struct to define a user's profile.
    struct User {
        string name;
        uint8 age;
        string email;
        uint registrationTime; // Will be 0 if the user is not registered
    }

    // A single mapping to store all user profiles.
    // The user's address links to their User struct.
    mapping(address => User) private profiles;
     //Reverts if the user has already registered.
     
    function register(string memory _name, uint8 _age, string memory _email) public {
        // Check if the user is already registered by looking at their registration time.
        // If it's not 0, they have registered before.
        require(profiles[msg.sender].registrationTime == 0, "Error: User is already registered.");

        // Create and store the new user profile in the mapping.
        profiles[msg.sender] = User({
            name: _name,
            age: _age,
            email: _email,
            registrationTime: block.timestamp
        });
    }

    
     //Reverts if the user is not registered.
    
    function updateProfile(string memory _name, uint8 _age, string memory _email) public {
        // Ensure the user exists before allowing an update.
        require(profiles[msg.sender].registrationTime != 0, "Error: User not registered.");

        // Update the user's information.
        User storage user = profiles[msg.sender];
        user.name = _name;
        user.age = _age;
        user.email = _email;
    }

    function getProfile(address _userAddress) public view returns (string memory, uint8, string memory, uint) {
        // Retrieve the user from the mapping.
        User storage user = profiles[_userAddress];
        
        // Check that the user exists before returning their data.
        require(user.registrationTime != 0, "Error: No profile found for this address.");
        
        return (user.name, user.age, user.email, user.registrationTime);
    }
}
