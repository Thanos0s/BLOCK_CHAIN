// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./ERC20.sol";


contract simpleAMM{
    ERC20 public tokenA;
    ERC20 public tokenB;
    uint256 public reserveA;
    uint256 public reserveB;

    constructor(address _tokenA,address _tokenB){

        tokenA =ERC20(_tokenA);
        tokenB =ERC20(_tokenB);

    }

   function addLiquidity(uint256 amountA,uint256 amountB) external {
    require(tokenA.transferFrom(msg.sender,address(this),amountA), "A transfer Failed" );
    require(tokenB.transferFrom(msg.sender,address(this),amountB), "A transfer Failed" );
      reserveA +=amountA;
      reserveB +=amountB;
   }
   function getAmountOut(uint256 amountIn,uint256 reserveIn,uint256 reserveOut) public pure returns (uint256 amountOut){
    uint256 amountInWithFee= amountIn*997;
    uint256 num = amountInWithFee*reserveOut;
    uint256 den =(reserveIn*1000) + amountInWithFee;
    return num/den;
   }
   function swapAForB(uint256 amountAIn) external{
    uint256 amountBOut = getAmountOut(amountAIn,reserveA,reserveB);
    require(tokenA.transferFrom(msg.sender,address(this),amountAIn),"A transfer failed");
    require(tokenB.transfer(msg.sender,amountBOut),"B transfer failed");
    reserveA +=amountAIn;
    reserveB -=amountBOut;
   }
   function swapBForA(uint256 amountBIn) external {
    uint256 amountAOut = getAmountOut(amountBIn, reserveB, reserveA);
    require(tokenB.transferFrom(msg.sender,address(this),amountBIn),"B transfer failed");
    require(tokenA.transfer(msg.sender,amountAOut),"A transfer failed");
    reserveB +=amountBIn;
    reserveA -=amountAOut;
   }

}