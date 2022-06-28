// SPDX-License-Identifier: MIT
pragma solidity >=0.7.6;
pragma experimental ABIEncoderV2;

import { IUniswapV3Router } from "../interfaces/IUniswapV3Router.sol";
import { TransferHelper } from "../utils/TransferHelper.sol";

contract UniswapV3Router {
    bytes4 uniV3Selector;
    function uniV3SwapSingle(
        address recipient,
        address router,
        address[] memory path,
        uint256 amountIn,
        uint256 amountOutMin,
        uint24 poolFee,
        uint64 deadline
    ) internal returns (uint256 amountOut) {
        TransferHelper.safeApprove(path[0],router, amountIn);
        uniV3Selector = IUniswapV3Router.exactInputSingle.selector;
        (
            bool success, 
            bytes memory data
        ) = router.call(
            abi.encodeWithSelector(
                IUniswapV3Router.exactInputSingle.selector, 
                IUniswapV3Router.ExactInputSingleParams(
                    {
                        tokenIn: path[0],
                        tokenOut: path[1],
                        fee: poolFee,
                        recipient: recipient,
                        deadline: deadline,
                        amountIn: amountIn,
                        amountOutMinimum: amountOutMin,
                        sqrtPriceLimitX96: 0
                    }
                )
            )
        );
        require(success, "Swap failed on UniswapV3!");
        amountOut = abi.decode(data, (uint256));
    }
    
    /// @notice uniswapV3ExactInputTriangular swaps a fixed amount of token1 for a maximum possible amount of token3 through an intermediary pool.
    /// For this example, we will swap token1 to token2, then token2 to token3 to achieve our desired output.
    /// @dev The calling address must approve this contract to spend at least `amountIn` worth of its token1 for this function to succeed.
    /// @param amountIn The amount of token1 to be swapped.
    /// @return amountOut The amount of token3 received after the swap.
    // function uniV3SwapTriangular(
    //     address recipient,
    //     address[] memory path,
    //     uint256 amountIn,
    //     uint256 amountOutMin,
    //     uint24[] memory poolFee,
    //     uint64 deadline
    // ) internal returns (uint256 amountOut) {
      
    //     require(path.length == 3, "Invaild triangular trade");
    //     require(poolFee.length == 2, "Invaild pool fee");
    //     // Approve the router to spend token1.
    //     TransferHelper.safeApprove(path[0], address(uniswapV3Router), amountIn);
    //     bytes memory datas = abi.encodePacked(path[0], poolFee[0], path[1], poolFee[1], path[2]);
    //     // Multiple pool swaps are encoded through bytes called a `path`. A path is a sequence of token addresses and poolFees that define the pools used in the swaps.
    //     // The format for pool encoding is (tokenIn, fee, tokenOut/tokenIn, fee, tokenOut) where tokenIn/tokenOut parameter is the shared token across the pools.
    //     // Since we are swapping token1 to token2 and then token2 to token3 the path encoding is (token1, 0.3%, token2, 0.3%, token3).
    //     amountOut = uniswapV3Router.exactInput(
    //         IUniswapV3Router.ExactInputParams({
    //             path: datas,
    //             recipient: recipient,
    //             deadline: deadline,
    //             amountIn: amountIn,
    //             amountOutMinimum: amountOutMin
    //         })
    //     );
    //     require(amountOut > 0, "Swap failed on UniswapV3!");
    // }
}