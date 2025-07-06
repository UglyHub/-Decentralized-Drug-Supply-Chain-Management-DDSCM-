// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

// Drug Registration Contract
contract DrugRegistration {
    struct Drug {
        string uniqueId;
        string name;
        string batchNumber;
        string manufacturingDate;
        string expirationDate;
        string ipfsHash; // Points to off-chain data
        address owner; // Current owner of the drug
    }

    mapping(string => Drug) public drugs;

    event DrugRegistered(string uniqueId, string name, string batchNumber, address owner);

    function registerDrug(
        string memory _uniqueId,
        string memory _name,
        string memory _batchNumber,
        string memory _manufacturingDate,
        string memory _expirationDate,
        string memory _ipfsHash
    ) public {
        require(bytes(drugs[_uniqueId].uniqueId).length == 0, "Drug already registered");
        drugs[_uniqueId] = Drug(
            _uniqueId,
            _name,
            _batchNumber,
            _manufacturingDate,
            _expirationDate,
            _ipfsHash,
            msg.sender
        );
        emit DrugRegistered(_uniqueId, _name, _batchNumber, msg.sender);
    }

    function getDrugOwner(string memory _uniqueId) public view returns (address) {
        return drugs[_uniqueId].owner;
    }
}

// Ownership Transfer Contract
contract OwnershipTransfer {
    DrugRegistration public drugRegistration;

    event OwnershipTransferred(string indexed drugId, address indexed previousOwner, address indexed newOwner);

    constructor(address _drugRegistration) {
        drugRegistration = DrugRegistration(_drugRegistration);
    }

    function transferOwnership(string memory _drugId, address _newOwner) public {
        require(_newOwner != address(0), "New owner cannot be zero address");

        address currentOwner = drugRegistration.getDrugOwner(_drugId);
        require(currentOwner == msg.sender, "Only current owner can transfer");

        emit OwnershipTransferred(_drugId, currentOwner, _newOwner);
    }
}

// Verification Contract
contract Verification {
    mapping(string => bool) public verifiedDrugs;

    struct VerificationResult {
        bool isAuthentic;
        string details;
    }

    function verifyDrug(string memory _drugId) public view returns (VerificationResult memory) {
        if (verifiedDrugs[_drugId]) {
            return VerificationResult(true, "Drug is authentic.");
        }
        return VerificationResult(false, "Drug is not authentic.");
    }

    function markAsVerified(string memory _drugId) public {
        verifiedDrugs[_drugId] = true;
    }
}

// Recall Management Contract
contract RecallManagement {
    struct Recall {
        string drugId;
        string reason;
        uint256 timestamp;
    }

    Recall[] public recalls;

    event DrugRecalled(string drugId, string reason);

    function recallDrug(string memory _drugId, string memory _reason) public {
        recalls.push(Recall(_drugId, _reason, block.timestamp));
        emit DrugRecalled(_drugId, _reason);
    }

    function getRecalls() public view returns (Recall[] memory) {
        return recalls;
    }
}
