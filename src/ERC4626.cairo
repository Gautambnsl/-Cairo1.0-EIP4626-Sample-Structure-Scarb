use starknet::ContractAddress;

#[contract]
mod ERC4626 {
    use zeroable::Zeroable;
    use starknet::get_caller_address;
    use starknet::contract_address_const;
    use starknet::ContractAddressZeroable;
    use starknet::contract_address::ContractAddress;
    use scarbTestingPackage::erc20::erc20::ERC20;


trait IERC4646 {
    fn initializer(asset_: felt252, name:felt252, symbol:felt252,decimals:u8,value:u256);
    fn initalize_allones(value: u256);
    fn max_deposit(to: felt252) -> u256;
    fn max_mint(to: felt252) -> u256;
    fn max_redeem(caller: ContractAddress) -> u256;
    }


    struct Storage {
        asset : felt252,
        ALL_ONES: u256,
    }
    // let ALL_ONES: u256 = 2_u256 ** 128_u256 - 1_u256;
    

    #[event]
    fn Deposit(from_: felt252, to:felt252, amount: u256, shares: u256) {}

    #[event]
    fn Withdraw(from_: felt252, to:felt252, amount: u256, shares: u256) {}


    impl erc4646 of IERC4646 {
    
    fn initializer(asset_: felt252, name:felt252, symbol:felt252,decimals:u8,value:u256) {
    ERC20::initializer_ERC(name,symbol);
    initalize_allones(value);
    asset::write(asset_);
    }

    fn initalize_allones(value: u256) {
    ALL_ONES::write(value);
    }

    fn max_deposit(to: felt252) -> u256 {
        let max_deposit = ALL_ONES::read();
        return max_deposit;
    }

    fn max_mint(to: felt252) -> u256 {
        let max_mint = ALL_ONES::read();
        return max_mint;
    }

    fn max_redeem(caller: ContractAddress) -> u256 {
    let balance = ERC20::balance_of(caller);
    return balance;
    }
}

    //internal

    fn ERC20_decrease_allowance_manual(owner: ContractAddress, spender:ContractAddress, subtracted_value: u256) -> () {
    if(spender == owner) {
        return ();
    }

    let current_allowance = ERC20::allowance(owner,spender);
    let new_allowance = current_allowance - subtracted_value;

    ERC20::approve(spender,new_allowance);
    return ();
    }
}
    









