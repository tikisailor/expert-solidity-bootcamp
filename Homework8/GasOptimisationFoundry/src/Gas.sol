// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.0;

contract GasContract {
    mapping(address => uint256) public balances;
    mapping(address => uint8) public whitelist;
    address[5] public administrators;

    bool wasLastOdd = true;
    mapping(address => bool) public isOddWhitelistUser;
    
    struct ImportantStruct {
        uint256 amount;
        bool paymentStatus;
        address sender;
    }
    mapping(address => ImportantStruct) public whiteListStruct;

    event AddedToWhitelist(address userAddress, uint256 tier);

    modifier onlyAdminOrOwner() {
        require(
                checkForAdmin(msg.sender),
                ""
            );
        _;
    }

    modifier checkIfWhiteListed(address sender) {
        require(
            msg.sender == sender,
            ""
        );
        uint8 usersTier = whitelist[sender];
        require(
            usersTier > 0,
            ""
        );
        require(
            usersTier < 4,
            ""
        );
        _;
    }

    event Transfer(address recipient, uint256 amount);
    event WhiteListTransfer(address indexed);

    constructor(address[] memory _admins, uint256 _totalSupply) {

        administrators[0] = _admins[0];
        administrators[1] = _admins[1];
        administrators[2] = _admins[2];
        administrators[3] = _admins[3];
        administrators[4] = _admins[4];
        
        balances[msg.sender] = _totalSupply;
    }

    function checkForAdmin(address _user) public view returns (bool admin_) {
        bool admin = false;
        for (uint256 ii = 0; ii < administrators.length; ii++) {
            if (administrators[ii] == _user) {
                admin = true;
            }
        }
        return admin;
    }

    function balanceOf(address _user) public view returns (uint256 balance_) {
        uint256 balance = balances[_user];
        return balance;
    }

    function transfer(
        address _recipient,
        uint256 _amount,
        string calldata _name
    ) public returns (bool status_) {
        balances[_recipient] += _amount;
        return true;
    }

    function updatePayment(
        address _user,
        uint256 _ID,
        uint256 _amount
    ) public view onlyAdminOrOwner {
        require(
            _ID > 0,
            ""
        );
        require(
            _amount > 0,
            ""
        );
        require(
            _user != address(0),
            ""
        );
    }

    function addToWhitelist(address _userAddrs, uint256 _tier)
        public
        onlyAdminOrOwner
    {
        require(
            _tier < 255,
            ""
        );
        whitelist[_userAddrs] = uint8(_tier);
        if (_tier > 3) {
            whitelist[_userAddrs] -= uint8(_tier);
            whitelist[_userAddrs] = 3;
        } else if (_tier == 1) {
            whitelist[_userAddrs] -= uint8(_tier);
            whitelist[_userAddrs] = 1;
        } else if (_tier > 0 && _tier < 3) {
            whitelist[_userAddrs] -= uint8(_tier);
            whitelist[_userAddrs] = 2;
        }
        bool wasLastAddedOdd = wasLastOdd;
        if (wasLastAddedOdd == true) {
            wasLastOdd = false;
            isOddWhitelistUser[_userAddrs] = wasLastAddedOdd;
        } else if (wasLastAddedOdd == false) {
            wasLastOdd = true;
            isOddWhitelistUser[_userAddrs] = wasLastAddedOdd;
        } else {
            revert();
        }
        emit AddedToWhitelist(_userAddrs, _tier);
    }

    function whiteTransfer(
        address _recipient,
        uint256 _amount
    ) public checkIfWhiteListed(msg.sender) {
        address senderOfTx = msg.sender;
        whiteListStruct[senderOfTx] = ImportantStruct(_amount, true, msg.sender);
        
        require(
            balances[senderOfTx] >= _amount,
            ""
        );
        require(
            _amount > 3,
            ""
        );
        balances[senderOfTx] -= _amount;
        balances[_recipient] += _amount;
        balances[senderOfTx] += whitelist[senderOfTx];
        balances[_recipient] -= whitelist[senderOfTx];
        
        emit WhiteListTransfer(_recipient);
    }


    function getPaymentStatus(address sender) public view returns (bool, uint256) {        
        return (whiteListStruct[sender].paymentStatus, whiteListStruct[sender].amount);
    }
}