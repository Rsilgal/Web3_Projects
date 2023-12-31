// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import {Voting} from "./Voting.sol";
import {Ownable} from "openzeppelin/access/Ownable.sol";

contract VotingHandler is Ownable {
    Voting[] public votes;
    mapping(address => uint256[]) _creatorOfTheVote;
    mapping(uint256 => address) _identifierFromVote;
    uint256 _totalVotesAdded = 0;

    event VoteAdded(address);

    function addVote(
        uint256 _startDate,
        uint256 _durationDays,
        uint256 _minumumParticipation,
        address[] memory _options,
        address[] memory _users
    ) external returns (address) {
        Voting vote = new Voting(_startDate, _durationDays, _minumumParticipation, _options, _users);
        votes.push(vote);
        _totalVotesAdded++;
        _creatorOfTheVote[msg.sender].push(_totalVotesAdded);
        _identifierFromVote[_totalVotesAdded] = address(vote);
        emit VoteAdded(address(vote));
        return address(vote);
    }

    function getVotesByCreator(address creator) external view returns (address[] memory) {
        address[] memory result;
        for (uint256 i = 0; i < _creatorOfTheVote[creator].length; i++) {
            result[i] = _identifierFromVote[_creatorOfTheVote[creator][i]];
        }
        return result;
    }

    function getAllVotes() external view returns (address[] memory) {
        address[] memory result;
        for (uint256 i = 0; i < _totalVotesAdded; i++) {
            result[i] = _identifierFromVote[i];
        }
        return result;
    }

    function getVoteById(uint256 id) external view returns (address) {
        return _identifierFromVote[id];
    }
}
