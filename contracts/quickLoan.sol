// SPDX-License-Identifier: MIT

pragma solidity 0.8.10;

import "hardhat/console.sol";

import {FlashLoanSimpleReceiverBase} from "@aave/core-v3/contracts/flashloan/base/FlashLoanSimpleReceiverBase.sol";
import {IPoolAddressesProvider} from "@aave/core-v3/contracts/interfaces/IPoolAddressesProvider.sol";
import {IERC20} from "@aave/core-v3/contracts/dependencies/openzeppelin/contracts/IERC20.sol";

// import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract  QuickLoan is FlashLoanSimpleReceiverBase {
    address payable owner;

    // using SafeERC20 for IERC20;

    // receives ether to the contract
    receive() external payable {}


    constructor(address _lendingPool) FlashLoanSimpleReceiverBase(IPoolAddressesProvider(_lendingPool)) {
        owner = payable(msg.sender); 
    }

    function requestFlashLoan (address _token, uint256 _amount) public {
        address getFlashLoan = address(this);
        address asset = _token;
        uint256 amount = _amount;
        bytes memory params = "";
        uint16 referralCode = 0;
        

        POOL.flashLoanSimple(getFlashLoan,
            asset,
            amount,
            params,
            referralCode);

    }

    function executeOperation(address _asset, uint256 amount, uint256 loanfee) external returns(bool) {
        uint256 paybackAmount = amount + loanfee;
        IERC20(_asset).approve(address(POOL), paybackAmount);

        return true;
    }

    function getBalance (address tokenAddress) external view returns(uint256){
        return IERC20(tokenAddress).balanceOf(address(this));
    }

    function withdraw(address tokenAddress) external onlyOwner{

        IERC20 token = IERC20(tokenAddress);
        token.transfer(msg.sender, token.balanceOf(address(this)));

    }

    modifier onlyOwner () {
        require (msg.sender == owner, "not the owner");
        _;
    }
}