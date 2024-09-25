// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract EthiCoin is ERC20 {
    address public admin;

    constructor() ERC20("EthiCoin", "ETHC") {
        admin = msg.sender;
        _mint(admin, 1000000 * 10 ** decimals()); // Initial minting
    }

    function reward(address _to, uint256 _amount) public {
        
        _transfer(admin, _to, _amount);
    }

    function burnFrom(address _from, uint256 _amount) public {
        
        _burn(_from, _amount);
    }


}
