// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Test} from "forge-std/Test.sol";
import {Voting} from "../src/Voting.sol";

contract VotingTest is Test {
    Voting public voting;
    address[] public options;
    address[] public users;

    function setUp() public {
        for (uint256 i = 0; i < 3; i++) {
            options[i] = vm.addr(i);
        }

        for (uint256 j = 0; j < 5; j++) {
            options[j] = vm.addr(j * users.length);
        }

        voting = new Voting(
            block.timestamp,
            1,
            2,
            options,
            users
        );
    }
}
