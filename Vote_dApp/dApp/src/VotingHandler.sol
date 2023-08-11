// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import {Voting} from "./Voting.sol";
import {Ownable} from "openzeppelin/access/Ownable.sol";

contract VotingHandler is Ownable {
    Voting[] public votes;
    mapping(address => uint256[]) _creatorOfTheVote;
    mapping(uint256 => address) _identifierFromVote;
    uint256 _totalVotesAdded = 0;


    function addVote(
        uint256 _startDate, 
        uint256 _durationDays,
        uint256 _minumumParticipation,
        address[] memory _options,
        address[] memory _users
        ) external {
        Voting vote = new Voting(_startDate, _durationDays, _minumumParticipation, _options, _users);
        votes.push(vote);
        _totalVotesAdded++;
        _creatorOfTheVote[msg.sender].push(_totalVotesAdded);
        _identifierFromVote[_totalVotesAdded] = address(vote);
        //TODO: Emit an event to send the address of the created contract
    }

    function getVotesByCreator(address creator) external view returns(address[] memory result) {       
        for (uint256 i = 0; i < _creatorOfTheVote[creator].length; i++) {
            result[i] = _identifierFromVote[_creatorOfTheVote[creator][i]];
        }
    }

    function getAllVotes() external view returns(address[] memory result){
        for (uint256 i = 0; i < _totalVotesAdded; i++) {
            result[i] = _identifierFromVote[i];
        }
    }
}