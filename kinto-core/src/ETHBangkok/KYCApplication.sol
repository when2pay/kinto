// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IEntropyConsumer } from "@pythnetwork/entropy-sdk-solidity/IEntropyConsumer.sol";
import { IEntropy } from "@pythnetwork/entropy-sdk-solidity/IEntropy.sol";

contract KYCApplication {
    struct Key {
        uint256 exponent;
        uint256 modulus;
    }

    /**
     * Generate public and private keys given two prime numbers.
     * For simplicity, primes should be provided by the caller.
     */
    function generateKeypair(uint256 p, uint256 q) 
        public 
        pure 
        returns (Key memory publicKey, Key memory privateKey) 
    {
        uint256 n = p * q;
        uint256 phi = (p - 1) * (q - 1);
        uint256 e = 65537; // Common public exponent

        uint256 d = multiplicativeInverse(e, phi);

        publicKey = Key(e, n);
        privateKey = Key(d, n);
    }

    /**
     * Encrypt a message using the public key.
     */
    function encrypt(uint256 message, Key memory publicKey) 
        public 
        pure 
        returns (uint256) 
    {
        return modExp(message, publicKey.exponent, publicKey.modulus);
    }

    /**
     * Decrypt a cipher using the private key.
     */
    function decrypt(uint256 cipher, Key memory privateKey) 
        public 
        pure 
        returns (uint256) 
    {
        return modExp(cipher, privateKey.exponent, privateKey.modulus);
    }

    /**
     * Calculate modular exponentiation using the "exponentiation by squaring" method.
     */
    function modExp(uint256 base, uint256 exp, uint256 mod) 
        public 
        pure 
        returns (uint256 result) 
    {
        result = 1;
        base = base % mod;

        while (exp > 0) {
            if (exp % 2 == 1) {
                result = (result * base) % mod;
            }
            exp = exp >> 1;
            base = (base * base) % mod;
        }
    }

    /**
     * Calculate the modular multiplicative inverse using the Extended Euclidean Algorithm.
     */
    function multiplicativeInverse(uint256 e, uint256 phi) 
        public 
        pure 
        returns (uint256) 
    {
        (uint256 gcd, int256 x, ) = extendedGCD(int256(e), int256(phi));
        require(gcd == 1, "Inverse does not exist");
        return uint256((x % int256(phi) + int256(phi)) % int256(phi));
    }

    /**
     * Extended Euclidean Algorithm to calculate gcd and coefficients.
     */
    function extendedGCD(int256 a, int256 b) 
        public 
        pure 
        returns (uint256 gcd, int256 x, int256 y) 
    {
        if (a == 0) {
            return (uint256(b), 0, 1);
        }

        (uint256 gcd_, int256 x1, int256 y1) = extendedGCD(b % a, a);
        x = y1 - (b / a) * x1;
        y = x1;
        return (gcd_, x, y);
    }


    mapping(address => Key) public publicKeys; // key used for decryption

    function addKey(Key memory pubKey) public{
        publicKeys[msg.sender] = pubKey;
    }

    mapping(address => bool) public applications;

    function addApplication(uint256 value, uint256 cipher) public{
        // require(publicKeys[msg.sender] != Key(0,0), "No public key set");
        require(decrypt(cipher, publicKeys[msg.sender]) == value, "Unable to verify signature");
        applications[msg.sender] = true;
    }

    mapping(address => uint256) public challenges;

    function mapRandomNumber(
        bytes32 randomNumber,
        uint256 minRange,
        uint256 maxRange
    ) internal returns (uint256) {
        uint256 range = uint256(maxRange - minRange + 1);
        return minRange + (uint256(randomNumber) % range);
    }


    function requestRandomNumber(bytes32 userRandomNumber) external payable {
        uint256 fee = entropy.getFee(entropyProvider);
        
        uint64 sequenceNumber = entropy.requestWithCallback{ value: fee }(
            entropyProvider,
            userRandomNumber
        );
    }


    // @param sequenceNumber The sequence number of the request.
    // @param provider The address of the provider that generated the random number. If your app uses multiple providers, you can use this argument to distinguish which one is calling the app back.
    // @param randomNumber The generated random number.
    // This method is called by the entropy contract when a random number is generated.
    function entropyCallback(
        uint64 sequenceNumber,
        address provider,
        bytes32 randomNumber
    ) internal {
        // Implement your callback logic here.
    }

    // This method is required by the IEntropyConsumer interface.
    // It returns the address of the entropy contract which will call the callback.
    function getEntropy() internal view returns (address) {
        return address(entropy);
    }


    function getChallenge() public {
        challenges[msg.sender] = mapRandomNumber(0x1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef,1,100);
    }

    function reset() public {
        applications[msg.sender] = false;
    }

    IEntropy public entropy;
    address public entropyProvider;

    constructor(address entropyAddress) {
        entropy = IEntropy(entropyAddress);
        // entropyProvider = entropy.getDefaultProvider();
    }

}
