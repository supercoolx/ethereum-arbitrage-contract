// SPDX-License-Identifier: MIT
pragma solidity >=0.7.6;

import { ICurveFi } from "../interfaces/ICurveFi.sol";
import { TransferHelper } from "@uniswap/v3-periphery/contracts/libraries/TransferHelper.sol";

contract CurveswapRouter {

    ICurveFi public curveRouter;

    function curveSwap(
        address[] memory path,
        uint256 amountIn,
        uint256 amountOutMin
    ) internal returns (uint256 amountOut) {
        // Approve the router to spend token.
        TransferHelper.safeApprove(path[0], address(curveRouter), amountIn);
        // amountOut = curveRouter.exchange(path[0], path[1], amountIn, amountOutMin);
    }

}