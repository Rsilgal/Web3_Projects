// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract Voting {
    uint256 public startDate; // Extract to a function
    uint256 public endDate;
    uint256 public durationDays;
    uint256 public totalVotes;
    uint256 public minimumPaticipation;

    address[] _optionsList;
    address[] _usersList;

    mapping(address => uint256) _votes; // option address => votes count
    mapping(address => bool) _userHasVoted;
    mapping(address => bool) _options; // option address => option id
    mapping(address => bool) _userAllowed;

    constructor(
        uint256 _startDate,
        uint256 _durationDays,
        uint256 _minimumPaticipation,
        address[] memory options,
        address[] memory users
    ) {
        startDate = _startDate;
        durationDays = _durationDays;
        endDate = durationDays * 1 days;
        minimumPaticipation = _minimumPaticipation;
        _optionsList = options;
        _usersList = users;
        _optionsGenerator(options);
        _usersGenerator(users);
        emit StartVoting();
    }

    event StartVoting();
    event StopVoting();
    event VoteAdded();
    event SendResult(uint256);

    modifier validOption(address _option) {
        require(_optionValidator(_option), "No valid option");
        _;
    }

    modifier validUser(address _user) {
        require(_userValidator(_user), "No valid user");
        _;
    }

    modifier canVote(address _user) {
        require(_userHasVoted[_user] == false, "You has voted");
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
        return (_votes[option] * 100 )/ totalVotes;
    }

    function getAvailableOptions() external view returns (address[] memory) {
        return _optionsList;
    }

    function getAvailableUsers() external view returns (address[] memory) {
        return _usersList;
    }

    function isValid() external view returns (bool) {
        return totalVotes >= minimumPaticipation;
    }

    function _addVote(address _option) internal {
        _userHasVoted[msg.sender] = true;
        _votes[_option]++;
        emit VoteAdded();
    }

    function _optionValidator(address option) internal view returns (bool) {
        return _options[option];
    }

    function _userValidator(address user) internal view returns (bool) {
        return _userAllowed[user];
    }

    function _optionsGenerator(address[] memory options) internal {
        for (uint256 index = 0; index < options.length; index++) {
            _options[options[index]] = true;
        }
    }

    function _usersGenerator(address[] memory _users) internal {
        for (uint256 index = 0; index < _users.length; index++) {
            _userAllowed[_users[index]] = true;
        }
    }
}
