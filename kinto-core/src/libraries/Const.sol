// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

library Constants {
    bytes constant safeBeaconProxyCreationCode =
        hex"60806040526040516106ce3803806106ce83398101604081905261002291610424565b818161003082826000610039565b5050505061054e565b610042836100fa565b6040516001600160a01b038416907f1cf3b03a6cf19fa2baba4df148e9dcabedea7f8a5c07840e207e5c089be95d3e90600090a26000825111806100835750805b156100f5576100f3836001600160a01b0316635c60da1b6040518163ffffffff1660e01b8152600401602060405180830381865afa1580156100c9573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906100ed91906104e4565b8361027e565b505b505050565b6001600160a01b0381163b6101645760405162461bcd60e51b815260206004820152602560248201527f455243313936373a206e657720626561636f6e206973206e6f74206120636f6e6044820152641d1c9858dd60da1b60648201526084015b60405180910390fd5b6101d8816001600160a01b0316635c60da1b6040518163ffffffff1660e01b8152600401602060405180830381865afa1580156101a5573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906101c991906104e4565b6001600160a01b03163b151590565b61023d5760405162461bcd60e51b815260206004820152603060248201527f455243313936373a20626561636f6e20696d706c656d656e746174696f6e206960448201526f1cc81b9bdd08184818dbdb9d1c9858dd60821b606482015260840161015b565b7fa3f0ad74e5423aebfd80d3ef4346578335a9a72aeaee59ff6cb3582b35133d5080546001600160a01b0319166001600160a01b0392909216919091179055565b60606102a383836040518060600160405280602781526020016106a7602791396102aa565b9392505050565b6060600080856001600160a01b0316856040516102c791906104ff565b600060405180830381855af49150503d8060008114610302576040519150601f19603f3d011682016040523d82523d6000602084013e610307565b606091505b50909250905061031986838387610323565b9695505050505050565b6060831561039257825160000361038b576001600160a01b0385163b61038b5760405162461bcd60e51b815260206004820152601d60248201527f416464726573733a2063616c6c20746f206e6f6e2d636f6e7472616374000000604482015260640161015b565b508161039c565b61039c83836103a4565b949350505050565b8151156103b45781518083602001fd5b8060405162461bcd60e51b815260040161015b919061051b565b80516001600160a01b03811681146103e557600080fd5b919050565b634e487b7160e01b600052604160045260246000fd5b60005b8381101561041b578181015183820152602001610403565b50506000910152565b6000806040838503121561043757600080fd5b610440836103ce565b60208401519092506001600160401b038082111561045d57600080fd5b818501915085601f83011261047157600080fd5b815181811115610483576104836103ea565b604051601f8201601f19908116603f011681019083821181831017156104ab576104ab6103ea565b816040528281528860208487010111156104c457600080fd5b6104d5836020830160208801610400565b80955050505050509250929050565b6000602082840312156104f657600080fd5b6102a3826103ce565b60008251610511818460208701610400565b9190910192915050565b602081526000825180602084015261053a816040850160208701610400565b601f01601f19169190910160400192915050565b61014a8061055d6000396000f3fe60806040523661000b57005b610013610015565b005b610025610020610027565b6100c0565b565b600061005a7fa3f0ad74e5423aebfd80d3ef4346578335a9a72aeaee59ff6cb3582b35133d50546001600160a01b031690565b6001600160a01b0316635c60da1b6040518163ffffffff1660e01b8152600401602060405180830381865afa158015610097573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906100bb91906100e4565b905090565b3660008037600080366000845af43d6000803e8080156100df573d6000f35b3d6000fd5b6000602082840312156100f657600080fd5b81516001600160a01b038116811461010d57600080fd5b939250505056fea26469706673582212201a80406d2bf44603712b93f004136cd4e1eb4a05629b2b91003117cbc0c038f864736f6c63430008180033416464726573733a206c6f772d6c6576656c2064656c65676174652063616c6c206661696c6564";
}