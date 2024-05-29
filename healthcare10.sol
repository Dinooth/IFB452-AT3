// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HealthcarePayment {
    mapping(address => uint256) public balances;

    // Event to log payment transactions
    event PaymentInitiated(address payer, address healthcareProvider, uint256 amount);

    // Function to initiate payment
    function initiatePayment(address healthcareProvider, uint256 amount) external {
        require(amount > 0, "Invalid amount");
        balances[healthcareProvider] += amount;
        emit PaymentInitiated(msg.sender, healthcareProvider, amount);
    }

    // Function to authorize and execute payment
    function authorizePayment(address /*healthcareProvider*/, uint256 amount) external {
        require(amount > 0, "Invalid amount");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        
    }

    // Function to check balance
    function checkBalance(address account) external view returns (uint256) {
        return balances[account];
    }
}

contract PatientConsentManagement {
    mapping(address => mapping(address => bool)) public consent;

    // Event to log consent changes
    event ConsentChanged(address patient, address healthcareProvider, bool consentStatus);

    // Function to grant consent
    function grantConsent(address healthcareProvider) external {
        consent[msg.sender][healthcareProvider] = true;
        emit ConsentChanged(msg.sender, healthcareProvider, true);
    }

    // Function to revoke consent
    function revokeConsent(address healthcareProvider) external {
        consent[msg.sender][healthcareProvider] = false;
        emit ConsentChanged(msg.sender, healthcareProvider, false);
    }

    // Function to check consent status
    function checkConsent(address patient, address healthcareProvider) external view returns (bool) {
        return consent[patient][healthcareProvider];
    }
}
