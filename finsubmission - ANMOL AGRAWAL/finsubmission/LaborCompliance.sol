// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./WorkerRegistry.sol";
import "./EthiCoin.sol";

contract LaborCompliance {
    uint256 public minimumWage;
    uint256 public maxWorkingHours;
    WorkerRegistry workerRegistry;
    EthiCoin ethiCoin;

    struct WorkRecord {
        uint256 hoursWorked;
        uint256 wagePaid;
        bool isCompliant;
        string complianceIssue;
    }

    mapping(address => WorkRecord) public workRecords;

    constructor(address _workerRegistryAddress, address _ethiCoinAddress) {
        workerRegistry = WorkerRegistry(_workerRegistryAddress);
        ethiCoin = EthiCoin(_ethiCoinAddress);
    }

    modifier onlyAuthorizedEmployer() {
        require(workerRegistry.isAuthorizedEmployer(msg.sender), "Not authorized");
        _;
    }

    function setComplianceRules(uint256 _minimumWage, uint256 _maxWorkingHours) public {
        // In real application this data would be taken via oracles. Only an authorized entity (admin/DAO) should be able to call this function
        minimumWage = _minimumWage;
        maxWorkingHours = _maxWorkingHours;
    }

    function logWorkHours(address _worker, uint256 _hoursWorked, uint256 _wagePaid, string memory compissue) public onlyAuthorizedEmployer {
        string memory complianceIssue = "None";
        bool isCompliant = true;
        //In real application work hours would be automatically recorded through biometric sensors.

        if (_hoursWorked > maxWorkingHours) {
            isCompliant = false;
            complianceIssue = "Exceeded maximum working hours";
            ethiCoin.burnFrom(msg.sender, 10 * 10**ethiCoin.decimals()); // Burn EthiCoins for non-compliance
            if (keccak256(abi.encodePacked(compissue)) != keccak256(abi.encodePacked(complianceIssue)) ){
                ethiCoin.burnFrom(msg.sender, (10 * 10**ethiCoin.decimals())/2);
            }
        }

        if (_wagePaid < _hoursWorked * minimumWage) {
            isCompliant = false;
            complianceIssue = "Wage is below minimum wage";
            ethiCoin.burnFrom(msg.sender, 10 * 10**ethiCoin.decimals()); // Burn EthiCoins for non-compliance
            if (keccak256(abi.encodePacked(compissue)) != keccak256(abi.encodePacked(complianceIssue)) ){
                ethiCoin.burnFrom(msg.sender, (10 * 10**ethiCoin.decimals())/2);
            }
        }

        if (isCompliant) {
            ethiCoin.reward(msg.sender, 10 * 10**ethiCoin.decimals()); // Reward EthiCoins for compliance
        }

        // Log the transaction with compliance status
        workRecords[_worker] = WorkRecord(_hoursWorked, _wagePaid, isCompliant, complianceIssue);
    }

    function getWorkRecord(address _worker) public view returns (uint256, uint256, bool, string memory) {
        WorkRecord memory record = workRecords[_worker];
        return (record.hoursWorked, record.wagePaid, record.isCompliant, record.complianceIssue);
    }
}
//This is just a demo of how the idea will work. Real product will be much more feature rich and polished.
//The data recorded will be accesible by labor departments and we will look forward to partner with government on this to  implement this on larger scale.
//Incentives for factory owners would be Ethicoin, reduced no. of labor audits needed by our partnership with govt. and increased reputation and image with ethical labor practices.