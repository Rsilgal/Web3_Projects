// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Test} from "forge-std/Test.sol";
import {Voting} from "../src/Voting.sol";
import "forge-std/console.sol";

contract VotingTest is Test {
    Voting public voting;
    uint256 startAt;
    address[] public options;
    address[] public users;

    event startVoting();

    function setUp() public {
        options = [address(1), address(2), address(3), address(9)];
        users = [address(4), address(5), address(6), address(7), address(8)];

        voting = createVote();
        startAt = voting.startDate();
    }

    function test_AddVote() public {
        vm.prank(users[0]);
        voting.addVote(options[0]);
    }

    function test_sameUserVoteTwoTimes() public {
        vm.prank(users[0]);
        voting.addVote(options[0]);

        vm.expectRevert(bytes("You has voted"));
        vm.prank(users[0]);
        voting.addVote(options[0]);
    }

    function test_ifVoteAfterTheEndDate() public {
        vm.expectRevert(bytes("Voting process is over"));
        vm.warp(startAt + 2 days);
        vm.prank(users[0]);
        voting.addVote(options[0]);
    }

    function test_InvalidUserAddVote() public {
        vm.expectRevert(bytes("No valid user"));
        vm.prank(address(150));
        voting.addVote((options[0]));
    }

    function test_InvalidOptionToVote() public {
        vm.expectRevert(bytes("No valid option"));
        vm.prank(users[0]);
        voting.addVote(address(150));
    }

    // TODO: Will be refactored to be a generic test
    function test_GetResultsAfterVoteEndDate() public {
        vm.prank(users[0]);
        voting.addVote(options[0]);

        vm.prank(users[1]);
        voting.addVote(options[0]);

        vm.prank(users[2]);
        voting.addVote(options[0]);

        vm.prank(users[3]);
        voting.addVote(options[1]);

        vm.warp(startAt + 5 days);

        uint256 resultFromOption_0 = 75;
        uint256 resultFromOption_1 = 25;

        assertEq(resultFromOption_0, voting.getOptionResult(options[0]));
        assertEq(resultFromOption_1, voting.getOptionResult(options[1]));
    }

    function test_GetResultsBeforeVoteEndDate() public {
        vm.prank(users[0]);
        voting.addVote(options[0]);

        vm.prank(users[1]);
        voting.addVote(options[0]);

        vm.prank(users[2]);
        voting.addVote(options[0]);

        vm.prank(users[3]);
        voting.addVote(options[1]);

        vm.expectRevert(bytes("The process is not over"));
        voting.getOptionResult(options[0]);
    }

    function test_GetAvailableOptions() public {
        assertEq(options, voting.getAvailableOptions());
    }

    function test_GetAvailableUsers() public {
        assertEq(users, voting.getAvailableUsers());
    }

    function createVote() public returns (Voting) {
        return new Voting(
            block.timestamp,
            1,
            2,
            options,
            users
        );
    }
}
