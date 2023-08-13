// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Test} from "forge-std/Test.sol";
import {VotingHandler} from "../src/VotingHandler.sol";

contract VotingHandlerTest is Test {
    VotingHandler public handler;
    uint256 public startAt;
    address[] public options;
    address[] public users;

    event VoteAdded(address);

    function setUp() public {
        startAt = block.timestamp;
        options = [address(1), address(2), address(3), address(9)];
        users = [address(4), address(5), address(6), address(7), address(8)];
        handler = new VotingHandler();
    }
}