# Steps

## Our KYC

0x6842E96753155446450A9597A482d446D15d5c30

1. `source .env && forge create ./src/ETHBangkok/KYCApplication.sol:KYCApplication --rpc-url $KINTO_RPC_URL --private-key $PRIVATE_KEY --constructor-args "0x2880aB155794e7179c9eE2e38200202908C17B43"`
2. `forge verify-contract --watch 0x6842E96753155446450A9597A482d446D15d5c30 src/ETHBangkok/KYCApplication.sol:KYCApplication   --verifier blockscout --verifier-url https://explorer.kinto.xyz/api`
3. `cast send 0x6842E96753155446450A9597A482d446D15d5c30 "getChallenge()" --rpc-url $KINTO_RPC_URL --private-key $PRIVATE_KEY`
4. Read the challenge `cast call 0x6842E96753155446450A9597A482d446D15d5c30 "challenges(address)(uint256)" 0x7A8E79dE63c29c3ee2375Cd3D2e90FEaA5aAf322 --rpc-url $KINTO_RPC_URL`
5. Add public key `cast send 0x6842E96753155446450A9597A482d446D15d5c30 "addKey((uint256,uint256))" "(2753,3233)" --rpc-url $KINTO_RPC_URL --private-key $PRIVATE_KEY`
6. Check signature and apply for KYC `cast send 0x6842E96753155446450A9597A482d446D15d5c30 "addApplication(uint256,uint256)" 56 1794 --rpc-url $KINTO_RPC_URL --private-key $PRIVATE_KEY`
7. Get application status `cast call 0x6842E96753155446450A9597A482d446D15d5c30 "applications(address)(uint256)" 0x7A8E79dE63c29c3ee2375Cd3D2e90FEaA5aAf322 --rpc-url $KINTO_RPC_URL`

### Read using Blockscout

1. Send request to 
```curl -X 'GET' \
  'https://explorer.kinto.xyz/api/v2/smart-contracts/0xF1a73A2B87449C1EB2BBEeC1628DEf7Cca039cAe/methods-read?is_custom_abi=false' \
  -H 'accept: application/json'```, extract method id for 'applications'
2. Send this 
```curl -X 'POST' \
  'https://explorer.kinto.xyz/api/v2/smart-contracts/0xF1a73A2B87449C1EB2BBEeC1628DEf7Cca039cAe/query-read-method' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
  "args": [
    "0x7A8E79dE63c29c3ee2375Cd3D2e90FEaA5aAf322"
  ],
  "method_id": "7c3bf42d",
  "from": "0x7A8E79dE63c29c3ee2375Cd3D2e90FEaA5aAf322",
  "contract_type": "proxy | regular"
}'
```

## Simple counter
1. Deploy contract `source .env && forge create src/sample/Counter.sol:Counter --rpc-url $KINTO_RPC_URL --private-key $PRIVATE_KEY`
2. Call the method `cast send 0xyouraddress "increment()" --rpc-url $KINTO_RPC_URL --private-key $PRIVATE_KEY`
3. Verify contract `forge verify-contract --watch 0xyouraddress  src/Counter.sol:Counter   --verifier blockscout --verifier-url https://explorer.kinto.xyz/api`
4. Check output `cast call 0xyouraddress "count()" --rpc-url $KINTO_RPC_URL --private-key $PRIVATE_KEY`