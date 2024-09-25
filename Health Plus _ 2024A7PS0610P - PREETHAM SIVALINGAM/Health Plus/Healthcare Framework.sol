pragma solidity ^0.8.0;

contract Healthcare {
    // Admin address
    address public admin;

    // Mappings for each role
    mapping(address => bool) public patients;
    mapping(address => bool) public ambulances;
    mapping(address => bool) public hospitals;
    mapping(address => bool) public pharmacies;

    // Structs for logs
    struct PatientLog {
        uint timestamp;
        string details;
    }

    struct AmbulanceLog {
        uint departureTime;
        uint pickupTime;
        uint coordinateDec; // I plan to read realtime location data through blockchain oracles and display the location to the user by mapping the coordinates using an API
        uint coordinateDeg;
    }

    struct HospitalLog {
        uint arrivalTime;
        string prescribedMedicine;
    }

    struct PharmacyLog {
        bool dispensed;
    }

    // Mappings to store the logs
    mapping(uint => PatientLog) public patientLogs;
    mapping(uint => AmbulanceLog) public ambulanceLogs;
    mapping(uint => HospitalLog) public hospitalLogs;
    mapping(uint => PharmacyLog) public pharmacyLogs;

    // Events for transparency and tracking
    event PatientCalled(uint patientId, uint timestamp);
    event AmbulanceDeparted(uint patientId, uint departureTime);
    event AmbulancePickedUp(uint patientId, uint pickupTime);
    event PatientArrivedAtHospital(uint patientId, uint arrivalTime);
    event MedicinePrescribed(uint patientId, string medicine);
    event MedicineDispensed(uint patientId);

    // Constructor to set the admin
    constructor() {
        admin = msg.sender;
    }

    // Modifiers to restrict access
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    modifier onlyPatient() {
        require(patients[msg.sender], "Only patients can perform this action");
        _;
    }

    modifier onlyAmbulance() {
        require(ambulances[msg.sender], "Only ambulances can perform this action");
        _;
    }

    modifier onlyHospital() {
        require(hospitals[msg.sender], "Only hospitals can perform this action");
        _;
    }

    modifier onlyPharmacy() {
        require(pharmacies[msg.sender], "Only pharmacies can perform this action");
        _;
    }

    // Functions to assign roles
    function addPatient(address patient) public onlyAdmin {
        patients[patient] = true;
    }

    function addAmbulance(address ambulance) public onlyAdmin {
        ambulances[ambulance] = true;
    }

    function addHospital(address hospital) public onlyAdmin {
        hospitals[hospital] = true;
    }

    function addPharmacy(address pharmacy) public onlyAdmin {
        pharmacies[pharmacy] = true;
    }

    // Function for Patients to log their call
    function logPatientCall(uint patientId) public onlyPatient {
        patientLogs[patientId] = PatientLog(block.timestamp, "Patient called for an ambulance");
        emit PatientCalled(patientId, block.timestamp);
    }

    // Function for Ambulance to log departure and pickup
    function logAmbulanceDeparture(uint patientId) public onlyAmbulance {
        ambulanceLogs[patientId].departureTime = block.timestamp;
        emit AmbulanceDeparted(patientId, block.timestamp);
    }

    function logAmbulancePickup(uint patientId) public onlyAmbulance {
        ambulanceLogs[patientId].pickupTime = block.timestamp;
        emit AmbulancePickedUp(patientId, block.timestamp);
    }

    // Function for Hospitals to log patient arrival and prescribed medicines
    function logPatientArrival(uint patientId) public onlyHospital {
        hospitalLogs[patientId].arrivalTime = block.timestamp;
        emit PatientArrivedAtHospital(patientId, block.timestamp);
    }

    function prescribeMedicine(uint patientId, string memory medicine) public onlyHospital {
        hospitalLogs[patientId].prescribedMedicine = medicine;
        emit MedicinePrescribed(patientId, medicine);
    }

    // Function for Pharmacies to log medicine dispensation
    function dispenseMedicine(uint patientId) public onlyPharmacy {
        pharmacyLogs[patientId].dispensed = true; //In case the same patient revisits, a new ID will be created since this software primarily caters to emergency cases. However, in the future, the software can be reworked for general usage as well, allowing the users to access the services mutiple times using their patient ID. 
        emit MedicineDispensed(patientId);
    }
}
