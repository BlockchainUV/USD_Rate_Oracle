pragma solidity >= 0.5.0 < 0.6.0;

import "https://github.com/provable-things/ethereum-api/provableAPI_0.5.sol";

contract USDRate is usingProvable {
    uint256 public price;
    
    event LogUSDRate(string text);
    
    constructor() public payable {
        emit LogUSDRate("USD Rate Contract created !!!");
        update();
    }
    
    function update() public payable {
        emit LogUSDRate("provable things query was sent, waiting for the answer...");
        provable_query("URL", "json(https://min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=USD).USD");
    }
    
    function __callback(bytes32 _myid, string memory _result) public {
        require(msg.sender == provable_cbAddress());
        emit LogUSDRate(_result);
        price = parseInt(_result, 2);
    }
}
