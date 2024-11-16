import express from 'express';
import dotenv from 'dotenv'
import {ethers} from 'ethers'

import { readFile } from 'fs/promises';
const abi = JSON.parse(
  await readFile(
    new URL('../kinto-core/out/KYCApplication.sol/KYCApplication.json', import.meta.url)
  )
);


dotenv.config({path: '/home/alberto/Documents/hackathon/ETHBangkok2024/kinto/kinto-core/.env'})

const app = express();
const port = process.env.PORT || 3000;

const contractAddress = "0x6842E96753155446450A9597A482d446D15d5c30"
const provider = new ethers.JsonRpcProvider(process.env.KINTO_RPC_URL);
const signer = new ethers.Wallet(process.env.PRIVATE_KEY, provider);
const contract = new ethers.Contract(contractAddress, abi.abi, signer);

async function test(){
    // console.log(await contract.challenges("0x7A8E79dE63c29c3ee2375Cd3D2e90FEaA5aAf322"))
}
test()

app.get('/',(req,res)=>{
    res.send('this is homepage')
})

app.get('/submitKYCApplication', (req,res)=>{
    res.send("okay")
})

app.get('/getChallenge', async (req,res) => {
    let addr = req.query.addr || "0x7A8E79dE63c29c3ee2375Cd3D2e90FEaA5aAf322"
    //let chg = await contract.challenges("0x7A8E79dE63c29c3ee2375Cd3D2e90FEaA5aAf322")
    //res.send({challenge: parseInt(chg)})

    let endpoint = `https://explorer.kinto.xyz/api/v2/smart-contracts/${contractAddress}/methods-read?is_custom_abi=false`
    let data = await (await fetch(endpoint)).json()
    let methodId

    for(let el of data){
        if(el.name == "challenges"){
            methodId = el.method_id;
            break
        }
    }

    endpoint = `https://explorer.kinto.xyz/api/v2/smart-contracts/${contractAddress}/query-read-method`
    let body = {
        args: [
            addr
        ],
        method_id: methodId,
        from: addr,
        contract_type: "proxy | regular"
    }
    data = await(await fetch(endpoint, {
        method: "POST",
        body: JSON.stringify(body),
        headers: {
            "Content-Type": "application/json",
        },
    })).json()

    res.send({challenge: data.result.output[0].value})
})

app.get('/addPublicKey', async(req,res) => {
    let p1 = req.query.p1 || 2753
    let p2 = req.query.p2 || 3233

    await contract.addKey([p1,p2])
    res.send("Okay")
})

app.get('/addApplication', async(req,res) => {
    let chg = req.query.chg || 56
    let cpr = req.query.cpr || 1794

    await contract.addApplication(chg, cpr)
    res.send("Okay")
})

app.get('/getApplicationStatus', async (req, res) => {
    let addr = req.query.addr || "0x7A8E79dE63c29c3ee2375Cd3D2e90FEaA5aAf322"

    let status=await contract.applications(addr)
    res.send({status: status})
})

app.listen( port ,()=>{
    console.log('server is running at port number 3000')
});