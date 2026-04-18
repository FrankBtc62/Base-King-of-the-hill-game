// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract x402King {
    address public owner;
    address public king;

    uint256 public lastActionTime;
    uint256 public timeout = 5 minutes;

    uint256 public totalPool;

    uint256 public constant BUILDER_FEE = 2;
    uint256 public constant DENOMINATOR = 100;

    event NewKing(address indexed user, uint256 amount);
    event Claimed(address indexed winner, uint256 amount);

    constructor() {
        owner = msg.sender;
    }

    receive() external payable {
        enter();
    }

    function enter() public payable {
        require(msg.value > 0, "No ETH");

        if (king != address(0) && block.timestamp > lastActionTime + timeout) {
            _payout();
        }

        uint256 fee = (msg.value * BUILDER_FEE) / DENOMINATOR;
        uint256 net = msg.value - fee;

        payable(owner).transfer(fee);

        king = msg.sender;
        lastActionTime = block.timestamp;
        totalPool += net;

        emit NewKing(msg.sender, msg.value);
    }

    function claimIfWinner() external {
        require(king == msg.sender, "Not king");
        require(block.timestamp > lastActionTime + timeout, "Still active");

        _payout();
    }

    function _payout() internal {
        uint256 reward = totalPool;

        address winner = king;

        totalPool = 0;
        king = address(0);

        payable(winner).transfer(reward);

        emit Claimed(winner, reward);
    }

    function timeLeft() external view returns (uint256) {
        if (block.timestamp > lastActionTime + timeout) return 0;
        return (lastActionTime + timeout) - block.timestamp;
    }
}
