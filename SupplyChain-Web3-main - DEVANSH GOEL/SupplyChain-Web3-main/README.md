---

# Supply Chain Transparency with Blockchain

## Introduction

This repository contains a smart contract that aims to revolutionize supply chain transparency using Ethereum blockchain technology. The contract allows for the creation, tracking, and completion of shipments, ensuring transparent and immutable records of all transactions. This solution addresses common issues in traditional supply chains, such as lack of trust, inefficiencies, and fraud.

## Features

- **Shipment Creation:** Senders can create shipments with details like receiver address, pickup time, price, distance, and order info.
- **Real-Time Tracking:** Track the status of shipments as they move from "Pending" to "In Transit" to "Completed."
- **Immutable Records:** All shipment and transaction data is recorded on the Ethereum blockchain, ensuring transparency and security.
- **Automated Payments:** Payments are automatically transferred to the sender upon successful delivery and confirmation by the receiver.

## Prerequisites

To work with this project, you'll need:

- **Solidity:** Version 0.8.0 or later
- **Node.js & npm:** For development and testing
- **Hardhat:** Ethereum development environment for compiling, testing, and deploying smart contracts
- **Metamask:** For interacting with the Ethereum network

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/your-username/supply-chain-blockchain.git
   ```
    ```bash
   To Start the backend BLockchain
    cd backend
    npx hardhat node
     ```
    To Start Frontend
    ```bash
   cd supply-chain-app
    npm run dev
    ```

3. Install the dependencies:

   ```bash
   npm install
   ```

4. Compile the smart contract:

   ```bash
   npx hardhat compile
   ```

5. Deploy the contract:

   ```bash
   npx hardhat run scripts/deploy.js --network your-network
   ```

## Usage

Once the contract is deployed, you can interact with it via:

- **Hardhat Console:** Use the Hardhat console to interact with your smart contract.
- **Web3.js or Ethers.js:** Integrate the smart contract with a front-end application using Web3.js or Ethers.js.
- **Metamask:** Connect your Ethereum wallet and send transactions to interact with the contract.

### Example: Create a Shipment

```js
const trackingContract = await Tracking.deployed();
await trackingContract.createShipment(receiverAddress, pickupTime, price, distance, orderInfo, { value: price });
```

### Example: Complete a Shipment

```js
await trackingContract.completeShipment(senderAddress, receiverAddress, shipmentIndex);
```

## Contract Overview

The smart contract includes the following key components:

- **Events:**
  - `ShipmentCreated`: Emitted when a new shipment is created.
  - `ShipmentTransit`: Emitted when a shipment is in transit.
  - `ShipmentDelivered`: Emitted when a shipment is delivered.
  - `ShipmentPaid`: Emitted when payment is made upon delivery.

- **Functions:**
  - `createShipment`: Creates a new shipment.
  - `startShipment`: Starts the shipment process, marking it as "In Transit."
  - `completeShipment`: Marks a shipment as completed and transfers payment.
  - `getShipment`: Retrieves details of a specific shipment.
  - `getAllTransactions`: Returns a list of all recorded shipments.

- **Mappings:**
  - `shipmentsArr`: Maps senders to their respective shipments.

## Contributing

Contributions are welcome! If you'd like to contribute, please fork the repository and submit a pull request.

1. Fork the repository
2. Create a new branch (`git checkout -b feature-branch`)
3. Commit your changes (`git commit -m 'Add new feature'`)
4. Push to the branch (`git push origin feature-branch`)
5. Open a pull request

## License

This project is licensed under the MIT License. See the `LICENSE` file for more details.

---
