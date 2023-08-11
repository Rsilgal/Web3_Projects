// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import {Voting} from "./Voting.sol";
import {Ownable} from "openzeppelin/access/Ownable.sol";

contract VotingHandler is Ownable {
    Voting[] public votes;
}