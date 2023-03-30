#[contract]
mod safeerc20 {
    use starknet::get_caller_address;
    use starknet::get_contract_address;
    use starknet::contract_address_const;
    use starknet::contract_address::ContractAddress;
    use scarbTestingPackage::IERC20::IERC20;
    use zeroable::Zeroable;


    fn transfer(contract_address: felt252, recipient:felt252, amount: u256) {
    let success = IERC20.transfer(contract_address,recipient, amount);
    assert(!success.is_zero(),'SafeERC20');
    }

    fn transferFrom(contract_address: ContractAddress, sender: ContractAddress, recipient: ContractAddress, amount: u256) {
    let success = IERC20::transfer_from(contract_address, sender, recipient, amount);
    assert(!success.is_zero(),'SafeERC20');
    }
}
