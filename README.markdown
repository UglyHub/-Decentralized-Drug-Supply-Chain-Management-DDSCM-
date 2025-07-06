# Drug Supply Chain Management Smart Contracts

This repository contains a set of Ethereum smart contracts designed to manage a drug supply chain, ensuring transparency, ownership tracking, verification, and recall management. The contracts are written in Solidity (version ^0.8.0) and are licensed under the GPL-3.0 license.

## Overview

The project consists of four interconnected smart contracts that collectively facilitate a decentralized drug registration and tracking system:

1. **DrugRegistration**: Registers drugs with unique identifiers and associated metadata.
2. **OwnershipTransfer**: Manages the transfer of ownership between parties.
3. **Verification**: Provides a mechanism to verify the authenticity of drugs.
4. **RecallManagement**: Handles the recall process for defective or unsafe drugs.

These contracts leverage blockchain technology to ensure immutability, transparency, and security in the pharmaceutical supply chain.

## Features

- **Drug Registration**: Allows the creation of a digital record for each drug with details such as name, batch number, manufacturing date, expiration date, and an IPFS hash for off-chain data storage.
- **Ownership Tracking**: Tracks the current owner of each drug and enables secure ownership transfers.
- **Authenticity Verification**: Provides a verification system to confirm the legitimacy of drugs.
- **Recall Management**: Facilitates the recall of drugs with a recorded reason and timestamp for traceability.

## Contracts

### 1. DrugRegistration
- **Purpose**: Registers new drugs and stores their details on the blockchain.
- **Key Functions**:
  - `registerDrug`: Registers a new drug with provided details, ensuring no duplicates via unique ID.
  - `getDrugOwner`: Retrieves the current owner of a drug by its unique ID.
- **Events**:
  - `DrugRegistered`: Emitted when a new drug is registered.

### 2. OwnershipTransfer
- **Purpose**: Manages the transfer of drug ownership between addresses.
- **Key Functions**:
  - `transferOwnership`: Transfers ownership to a new address, restricted to the current owner.
- **Events**:
  - `OwnershipTransferred`: Emitted when ownership is successfully transferred.
- **Dependencies**: Relies on the `DrugRegistration` contract for owner verification.

### 3. Verification
- **Purpose**: Verifies the authenticity of registered drugs.
- **Key Functions**:
  - `verifyDrug`: Returns the verification status and details of a drug.
  - `markAsVerified`: Marks a drug as verified by an authorized entity.
- **Data Structures**:
  - `VerificationResult`: Struct containing authenticity status and details.

### 4. RecallManagement
- **Purpose**: Manages the recall of drugs due to safety or quality issues.
- **Key Functions**:
  - `recallDrug`: Initiates a recall with a reason and timestamp.
  - `getRecalls`: Retrieves the list of all recalls.
- **Events**:
  - `DrugRecalled`: Emitted when a drug is recalled.
- **Data Structures**:
  - `Recall`: Struct containing drug ID, reason, and timestamp.

## Installation

1. **Prerequisites**:
   - Install [Node.js](https://nodejs.org/) and [npm](https://www.npmjs.com/).
   - Install [Truffle](https://www.trufflesuite.com/truffle/) or [Hardhat](https://hardhat.org/) for development and testing.
   - Set up a local Ethereum network (e.g., Ganache) or connect to a testnet (e.g., Ropsten).

2. **Setup**:
   - Clone the repository: `git clone <repository-url>`.
   - Navigate to the project directory: `cd drug-supply-chain`.
   - Install dependencies: `npm install`.

3. **Configuration**:
   - Update the `truffle-config.js` or `hardhat.config.js` file with your network settings.
   - Deploy the contracts using Truffle or Hardhat commands (see below).

## Usage

### Deployment
- Compile the contracts: `truffle compile` or `npx hardhat compile`.
- Deploy to a network:
  - Local: `truffle migrate --network development`.
  - Testnet: `truffle migrate --network ropsten` (after configuring API keys).
- Note the deployed contract addresses for interaction.

### Interacting with Contracts
- Use a web3 provider (e.g., MetaMask) or a script to call functions.
- Example script (using Truffle console):
  ```javascript
  let instance = await DrugRegistration.deployed();
  await instance.registerDrug("DRUG001", "Aspirin", "BN123", "2025-01-01", "2026-01-01", "Qm...");
  ```

## Testing
- Write test cases in JavaScript using Mocha (included with Truffle).
- Run tests: `truffle test` or `npx hardhat test`.
- Ensure tests cover registration, ownership transfer, verification, and recall scenarios.

## Security Considerations
- **Access Control**: Only the current owner can transfer ownership; verify `msg.sender` in critical functions.
- **Input Validation**: Ensure unique IDs and non-zero addresses to prevent errors.
- **Upgradability**: Contracts are not upgradable; consider using a proxy pattern for future updates.
- **Auditing**: Conduct a security audit before mainnet deployment to mitigate vulnerabilities.

## License
This project is licensed under the [GNU General Public License v3.0](https://www.gnu.org/licenses/gpl-3.0.en.html).

## Contributing
Contributions are welcome! Please fork the repository and submit pull requests with detailed descriptions of changes. Ensure tests pass and adhere to the coding standards.

## Contact
For questions or contributions, please contact [Chiderah Onwumelu] at [chiderahonwumelu@gmail.com].

