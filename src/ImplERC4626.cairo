#[contract]
mod ImplERC4626 {
    use zeroable::Zeroable;
    use starknet::get_caller_address;
    use starknet::get_contract_address;
    use starknet::contract_address_const;
    use starknet::ContractAddressZeroable;
    use starknet::contract_address::ContractAddress;
    use scarbTestingPackage::erc20::erc20::ERC20;
    use scarbTestingPackage::ERC4626::ERC4626::erc4646;

#[constructor]
fn constructor(asset: felt252, name: felt252, symbol:felt252){
    erc4646.initializer(asset,name,symbol);
}

#[view]
fn asset() -> (asset:felt252) {
    return erc4646::asset::read();
}

#[external]
fn deposit(assets: u256, receiver: felt252) -> (shares: u256) {
     let shares = previewDeposit(assets);
     //few assert conditions

     let asset = erc4646::asset::read();
     let msg_sender = get_caller_address();
     let this = get_contract_address();
     ERC20.transfer_from(sender, this, assets);
     ERC20._mint(receiver,shares);
    //  ERC20::Deposit
     return shares;
}

#[external]
fn mint(shares: u256, receiver:felt252) -> (assets: u256) {

let assets = previewMint(shares);

let asset = ERC4626::asset::read();
let msg_sender = get_caller_address();
let this = get_contract_address();
ERC20.transfer_from(msg_sender,this,assets);
ERC20._mint(receiver,shares);

return assets;
}

#[external]
fn withdraw(assets: u256, receiver: felt252, owner:felt252) ->(shares:u256) {

let shares = previewWithdraw(assets);
let msg_sender = get_caller_address();
ERC4626::ERC20_decrease_allowance_manual(owner,msg_sender,shares);

ERC20._burn(owner, receiver, assets, shares);

let asset = ERC4626::asset::read();
ERC20.transfer(asset, receiver, amount


