pragma solidity 0.7.5;

// - Anyperson can add ether to the Contract.
// - The creator can insert
//   - Address from owners.
//   - Number of approvations to the transfer in the constructor.
//   - Example: Insert 3 address and define the approval limit to 2.
// - Any owners can create a transfer solicitation and specify the valeu
// - Owners can approve the transfer solicitation.
// - When the solicitation has all the necessary approvals, then the transfer happens.

contract MultiWalletSig {
    address admin;
    address[] owners;
    int256 approvalLimit;
    mapping(address => uint256) balance;
    mapping(address => bool) ownersApproved;
    event depositDone(uint256 amount, address depositedTo);

    constructor(address[] memory _owners, int256 _approvalLimit) {
        approvalLimit = _approvalLimit;
        admin = msg.sender;
        owners = _owners;
        _ownersToApprove();
    }

    function _ownersToApprove() private {
        for (uint256 index = 0; index < owners.length; index++) {
            ownersApproved[owners[index]] = false;
        }
    }

    // Any person can deposit here.
    function deposit() public payable returns (uint256) {
        balance[admin] += msg.value;
        emit depositDone(msg.value, admin);
        return balance[admin];
    }

    // GetBalance
    function getBalance() public view returns (uint256) {
        return balance[admin];
    }

    function sign() public {
        require(_isCorrectOnwer(msg.sender), "User not allowed to sign!");
        ownersApproved[msg.sender] = true;
    }

    // Create Transfer
    function transfer(address payable _toTransfer, uint256 _quantity)
        public
        payable
    {
        require(_isCorrectOnwer(msg.sender), "User not allowed to transfer!");
        require(balance[admin] >= _quantity, "Balance not sufficient");
        require(admin != _toTransfer, "Don't transfer money to yourself");
        require(_checkIfApprovalExist(), "Everyone need to sign!");
        uint256 previousSenderBalance = balance[admin];
        balance[admin] -= _quantity;
        _toTransfer.transfer(_quantity);
        assert(balance[admin] == previousSenderBalance - _quantity);
    }

    // Check if is approved
    function _checkIfApprovalExist() private view returns (bool) {
        int256 totalApprovals = 0;
        for (uint256 index = 0; index < owners.length; index++) {
            if (ownersApproved[owners[index]] == true) {
                totalApprovals++;
            }
        }

        if (totalApprovals >= approvalLimit) {
            return true;
        }

        return false;
    }

    // Validate owner
    function _isCorrectOnwer(address _ownerToCheck)
        private
        view
        returns (bool)
    {
        bool exist = false;
        for (uint256 index = 0; index < owners.length; index++) {
            if (owners[index] == _ownerToCheck) {
                exist = true;
            }
        }

        return exist;
    }
}
