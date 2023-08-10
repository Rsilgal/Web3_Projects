// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract Voting {
    uint256 public startDate; // Extract to a function
    uint256 private endDate;
    uint256 durationDays;
    uint256 totalVotes;
    uint8 minimumPaticipation;

    address[] private optionsList;
    address[] private usersList;

    mapping(address => uint256) private votes; // option address => votes count
    mapping(address => bool) userHasVoted;
    mapping(address => bool) options; // option address => option id
    mapping(address => bool) userAllowed;

    constructor(
        uint256 _startDate,
        uint256 _durationDays,
        uint8 _minimumPaticipation,
        address[] memory _options,
        address[] memory _users
    ) {
        startDate = _startDate;
        durationDays = _durationDays;
        endDate = durationDays * 1 days;
        minimumPaticipation = _minimumPaticipation;
        optionsList = _options;
        usersList = _users;
        _optionsGenerator(_options);
        _usersGenerator(_users);
        emit startVoting();
    }

    event startVoting();
    event stopVoting();
    event voteAdded();
    event sendResult(uint256);

    modifier validOption(address _option) {
        require(_optionValidator(_option), "No valid option");
        _;
    }

    modifier validUser(address _user) {
        require(_userValidator(_user), "No valid user");
        _;
    }

    modifier canVote(address _user) {
        require(userHasVoted[_user] == false, "You has voted");
        _;
    }

    modifier openVoting() {
        require(startDate <= block.timestamp && block.timestamp <= endDate, "Voting process is over");
        _;
    }

    modifier processOver() {
        require(block.timestamp > endDate, "The process is not over");
        _;
    }

    function addVote(address _option)
        external
        validOption(_option)
        validUser(msg.sender)
        openVoting
        canVote(msg.sender)
    {
        _addVote(_option);
        totalVotes++;
    }

    function getOptionResult(address option) public view processOver returns (uint256) {
        return (votes[option] * 100 )/ totalVotes;
    }

    function getAvailableOptions() external view returns (address[] memory) {
        return optionsList;
    }

    function getAvailableUsers() external view returns (address[] memory) {
        return usersList;
    }

    function isValid() external view returns (bool) {
        return totalVotes >= minimumPaticipation;
    }

    function _addVote(address _option) internal {
        userHasVoted[msg.sender] = true;
        votes[_option]++;
        emit voteAdded();
    }

    function _optionValidator(address option) internal view returns (bool) {
        return options[option];
    }

    function _userValidator(address user) internal view returns (bool) {
        return userAllowed[user];
    }

    function _optionsGenerator(address[] memory _options) internal {
        for (uint256 index = 0; index < _options.length; index++) {
            options[_options[index]] = true;
        }
    }

    function _usersGenerator(address[] memory _users) internal {
        for (uint256 index = 0; index < _users.length; index++) {
            userAllowed[_users[index]] = true;
        }
    }
}
