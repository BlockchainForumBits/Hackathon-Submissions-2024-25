// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./WorkerRegistry.sol";
import "./LaborCompliance.sol";
import "./EthiCoin.sol";

contract EthicalLaborSystem {
    WorkerRegistry public workerRegistry;
    LaborCompliance public laborCompliance;
    EthiCoin public ethiCoin;

    constructor(
        address _workerRegistryAddress,
        address _laborComplianceAddress,
        address _ethiCoinAddress
    ) {
        workerRegistry = WorkerRegistry(_workerRegistryAddress);
        laborCompliance = LaborCompliance(_laborComplianceAddress);
        ethiCoin = EthiCoin(_ethiCoinAddress);
    }

    function rewardEmployer(address _employer, uint256 _amount) public {
        require(workerRegistry.isAuthorizedEmployer(_employer), "Not authorized employer");
        ethiCoin.reward(_employer, _amount);
    }

    function registerAndLogWork(
        address _worker,
        string memory _name,
        string memory _position,
        string memory _qualifications,
        uint256 _startDate,
        uint256 _hoursWorked,
        uint256 _wagePaid,
        string memory compissue
    ) public {
        workerRegistry.registerWorker(_worker, _name, _position, _qualifications, _startDate);
        laborCompliance.logWorkHours(_worker, _hoursWorked, _wagePaid, compissue);
    }
}
