pragma solidity ^0.5.0;

/**
 * @title Roles
 * @dev Library for managing addresses assigned to a Role.
 */
library Roles {
    struct Role {
        mapping (address => bool) bearer;
        mapping (address => uint) amount;
    }

    /**
     * @dev Give an account access to this role.
     */
    function add(Role storage role, address account,uint _amount) internal {
        require(!has(role, account), "Roles: account already has role");
        role.bearer[account] = true;
        role.amount[account]=_amount;
    }
     /**
     * @dev Give an account access to this role.
     */
    function add(Role storage role, address account) internal {
        require(!has(role, account), "Roles: account already has role");
        role.bearer[account] = true;
        
    }

    /**
     * @dev Remove an account's access to this role.
     */
    function remove(Role storage role, address account) internal {
        require(has(role, account), "Roles: account does not have role");
        role.bearer[account] = false;
        role.amount[account]=0;
    }

    /**
     * @dev Check if an account has this role.
     * @return bool
     */
    function has(Role storage role, address account) internal view returns (bool) {
        require(account != address(0), "Roles: account is the zero address");
        return role.bearer[account];
    }
    
    function hasAmount(Role storage role, address account ) internal view returns(uint){
        require(account != address(0), "Roles: account is the zero address");
         return role.amount[account];
    }

    function increaseAmount(Role storage role, address account,uint _amount) internal{
        require(has(role, account), "Roles: account does not have role");
        require(role.amount[account]+_amount>role.amount[account],"invalid amount");
        role.amount[account]+=_amount;
    }

     function decreaseAmount(Role storage role, address account,uint _amount) internal{
        require(has(role, account), "Roles: account does not have role");
        require(role.amount[account]-_amount<role.amount[account],"invalid amount");
        role.amount[account]-=_amount;
    }
}