This assignment is part of my **fellowship program at Dev3Pack**, where I'm building and revising core Solidity concepts week by week. These smart contracts are crafted to help me reinforce the fundamentals and prepare for real-world development tasks.

---

## 📚 Week 1 – Lecture 2
# User Profile Smart Contract

This project is a simple smart contract built with Solidity that allows users to register, update, and view a personal profile on an Ethereum-compatible blockchain. Each user is identified by their unique wallet address.

This was created as a learning project to understand the fundamentals of smart contract development.

## Understanding the Smart Contract Code

The entire logic is contained within the `UserProfile.sol` file. Here are the main components and why they were used:

### 1. The `User` Struct
```solidity
struct User {
    string name;
    uint8 age;
    string email;
    uint registrationTime;
}
```
* **What it is:** A `struct` is like a blueprint or a template for grouping related data together. We created a `User` template to hold all the information for a single user profile.
* **Why we used it:** Instead of having separate variables for names, ages, and emails, a struct keeps everything organized for each user in one neat package. The `registrationTime` is set to `0` by default for a new user.

### 2. The `profiles` Mapping
```solidity
mapping(address => User) private profiles;
```
* **What it is:** A `mapping` is like a massive, key-value database or a dictionary. It links one piece of data to another.
* **Why we used it:** We used a mapping to link a user's unique wallet `address` to their `User` struct (their profile data). This is an extremely efficient way to store and retrieve data on the blockchain. When we need to find a user's profile, we just look up their address in this mapping.

### 3. Key Functions

#### `register()`
This function allows a new user to create their profile.
* **How it works:** It takes a name, age, and email as input.
* **Security Check:** It first checks if the user has already registered by looking at their `registrationTime`. If the time is `0`, it means they are a new user. If it's not `0`, the `require(profiles[msg.sender].registrationTime == 0, ...)` statement stops the function and sends an error message. This prevents anyone from registering twice.
* **Action:** It creates a new `User` struct with the provided details, sets the `registrationTime` to the current time (`block.timestamp`), and saves it in the `profiles` mapping under the user's address (`msg.sender`).

#### `updateProfile()`
This function allows an existing user to change their profile details.
* **How it works:** It's similar to `register` but for existing users.
* **Security Check:** It uses `require(profiles[msg.sender].registrationTime != 0, ...)` to make sure that only users who have already registered can update their profile.
* **Action:** It finds the user's existing profile in the `profiles` mapping and overwrites the old data with the new data provided.

#### `getProfile()`
This is a "read-only" function to view a user's profile.
* **How it works:** You provide a user's wallet address, and it returns their profile information.
* **Why `view` is important:** The `view` keyword means this function only reads data; it doesn't change anything on the blockchain. Because of this, calling a `view` function is completely free and doesn't cost any gas.

## How to Test This Contract in Remix IDE

These are the steps I followed to compile, deploy, and test the contract.

### 1. Compilation
* Pasted the `UserProfile.sol` code into the Remix editor.
* Went to the "Solidity Compiler" tab.
* Clicked the "Compile UserProfile.sol" button to turn the Solidity code into bytecode that the Ethereum Virtual Machine (EVM) can understand.

### 2. Deployment
* Navigated to the "Deploy & Run Transactions" tab.
* Ensured the **ENVIRONMENT** was set to "Remix VM" (a simulated blockchain for testing).
* Clicked the orange "Deploy" button. The contract was then live on the test blockchain and appeared under the "Deployed Contracts" section.

### 3. Testing the Functions
Once deployed, I interacted with the contract using the buttons provided by Remix.

* **Registering a User:**
    1.  Used the `register` function.
    2.  Entered my details (e.g., `"AJ"`, `19`, `"ajtest@gmail.com"`) into the input fields.
    3.  Clicked the "transact" button. The transaction was confirmed in the console.

* **Viewing a Profile:**
    1.  Copied my wallet address from the "ACCOUNT" dropdown at the top of the tab.
    2.  Pasted this address into the field next to the `getProfile` button.
    3.  Clicked `getProfile`, and my registered information was displayed correctly below the button. This confirmed the data was saved successfully.

* **Updating a Profile:**
    1.  Used the `updateProfile` function with new details.
    2.  Clicked "transact".
    3.  Called `getProfile` again with the same address and confirmed that the new, updated information was displayed. This verified that the update logic works.
 
<img width="1895" height="898" alt="Screenshot (109)" src="https://github.com/user-attachments/assets/211a963c-0449-43ed-acbe-db217e7c2e1a" />
<img width="1909" height="891" alt="Screenshot (112)" src="https://github.com/user-attachments/assets/ad801365-71a5-4a14-8d58-6273454bf55c" />
<img width="1893" height="905" alt="Screenshot (113)" src="https://github.com/user-attachments/assets/9df56684-9c64-4320-830b-83bdabe9eb7d" />
<img width="1887" height="892" alt="Screenshot (114)" src="https://github.com/user-attachments/assets/9f826d12-19d3-4a4c-a47b-bfa7397f3e03" />
<img width="1895" height="906" alt="Screenshot (115)" src="https://github.com/user-attachments/assets/c9599c9d-19e0-498f-ba2c-ba1335abef03" />










