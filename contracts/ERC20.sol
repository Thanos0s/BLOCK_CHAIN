// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// class ==contract
 contract ERC20{
string public name;
string public symbol;
uint8 decimals=18;
uint256 public totalsupply;


mapping (address=>uint256) public balanceOf; // account with current balance

mapping (address=> mapping(address=>uint256)) public allowance;

constructor(string memory _name,
string memory _symbol, uint256 _initialsupply)
{
    name=_name;
    symbol = _symbol;
    totalsupply =_initialsupply;
    balanceOf[msg.sender]=_initialsupply;
}
// checking the guy is having amount or not
function transfer(address to, uint256 amt) external returns (bool){
  require(balanceOf[msg.sender]>=amt, "INSUFFICNT AMT");
  balanceOf[msg.sender]-=amt;

  balanceOf[to]+=amt;
  return true;
}
// 
function approve(address spender,uint256 amt) external returns(bool){
    allowance[msg.sender][spender]=amt;
    return true;
}
function transferFrom(address from,address to,uint256 amt) external returns (bool){
    require(balanceOf[from]>=amt, "Insufficent amount");
    require(allowance[from][msg.sender]>=amt,"Allowance exceeded");

    allowance[from][msg.sender]-=amt;

    balanceOf[from]-=amt;
    balanceOf[to]+=amt;
    return true;
}






}