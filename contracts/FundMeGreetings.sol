// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMeGreetings {
    AggregatorV3Interface internal priceFeed;
    address private _owner;
    uint256 private _minimumForGreetings = 50 * 1e18;

    constructor(AggregatorV3Interface _AggregatorAddress) {
        priceFeed = AggregatorV3Interface(_AggregatorAddress);
        _owner = msg.sender;
    }

    function fundWithGreetings() public payable returns (string memory) {
        require(
            convert(msg.value) >= _minimumForGreetings,
            "No lo suficiente para darte las gracias"
        );
        return "Thank you!";
    }

    function withdraw() public returns (bool) {
        require(msg.sender == _owner, "Casiiii");
        (bool callSuccess, ) = payable(_owner).call{
            value: address(this).balance
        }("");
        return callSuccess;
    }

    fallback() external payable {}

    receive() external payable {}

    //Obtenido de chainlink
    function getLatestPrice() public view returns (int) {
        // prettier-ignore
        (
            /* uint80 roundID */,
            int price,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = priceFeed.latestRoundData();
        return price;
    }

    function convert(uint256 amount) private view returns (uint256) {
        return
            ((uint256(getLatestPrice()) * amount) *
                (10 ** (18 - priceFeed.decimals()))) / 1e18; //casteo a uint256//lo ponemos en los mismos decimales
    }
}
