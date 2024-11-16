# Steps

## Our KYC

0xF1a73A2B87449C1EB2BBEeC1628DEf7Cca039cAe

1. `source .env && forge create ./src/ETHBangkok/KYCApplication.sol:KYCApplication --rpc-url $KINTO_RPC_URL --private-key $PRIVATE_KEY --constructor-args "0x2880aB155794e7179c9eE2e38200202908C17B43"`
2. `forge verify-contract --watch 0xF1a73A2B87449C1EB2BBEeC1628DEf7Cca039cAe src/ETHBangkok/KYCApplication.sol:KYCApplication   --verifier blockscout --verifier-url https://explorer.kinto.xyz/api`
3. `cast send 0xF1a73A2B87449C1EB2BBEeC1628DEf7Cca039cAe "getChallenge()" --rpc-url $KINTO_RPC_URL --private-key $PRIVATE_KEY`
4. Read the challenge `cast call 0xF1a73A2B87449C1EB2BBEeC1628DEf7Cca039cAe "challenges(address)(uint256)" 0x7A8E79dE63c29c3ee2375Cd3D2e90FEaA5aAf322 --rpc-url $KINTO_RPC_URL`
4. 

## Simple counter
1. Deploy contract `source .env && forge create src/sample/Counter.sol:Counter --rpc-url $KINTO_RPC_URL --private-key $PRIVATE_KEY`
2. Call the method `cast send 0xyouraddress "increment()" --rpc-url $KINTO_RPC_URL --private-key $PRIVATE_KEY`
3. Verify contract `forge verify-contract --watch 0xyouraddress  src/Counter.sol:Counter   --verifier blockscout --verifier-url https://explorer.kinto.xyz/api`
4. Check output `cast call 0xyouraddress "count()" --rpc-url $KINTO_RPC_URL --private-key $PRIVATE_KEY`