// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract WorkerRegistry {
    struct Worker {
        string name;
        string position;
        string qualifications;
        uint256 startDate;
        uint256 endDate;
    }

    mapping(address => Worker) private workers;
    mapping(address => bool) private authorizedEmployers;

    modifier onlyAuthorizedEmployer() {
        require(authorizedEmployers[msg.sender], "Not authorized");
        _;
    }

    function registerWorker(
        address _worker,
        string memory _name,
        string memory _position,
        string memory _qualifications,
        uint256 _startDate
    ) public onlyAuthorizedEmployer {
        workers[_worker] = Worker(_name, _position, _qualifications, _startDate, 0);
    }

    function updateEndDate(address _worker, uint256 _endDate) public onlyAuthorizedEmployer {
        workers[_worker].endDate = _endDate;
    }

    function authorizeEmployer(address _employer) public {
        authorizedEmployers[_employer] = true;
    }

    function isAuthorizedEmployer(address _employer) public view returns (bool) {
        return authorizedEmployers[_employer];
    }

    function getWorkerDetails(address _worker) public view returns (string memory, string memory, string memory, uint256, uint256) {
        Worker memory worker = workers[_worker];
        return (worker.name, worker.position, worker.qualifications, worker.startDate, worker.endDate);
    }
}
