# ZK-DAPP
The puspose of this repo is to develope and maintain various Zero Knowledge based projects for ref  

## Verify the sudoku puzzle using PLONK proof system.

### Pre-requisites 
`RUST`  
`NODE`  
  
Install snarkjs globaly   
`npm install -g snarkjs`  
  
Install circom  
-- snip --  
  
## Flow
  
1. Go the circuit dirctory. Follow the instruction to define the circuit, compile, define inputs and then generate the witness.  
2. Go to trusted setup directory and follow the instruction to generate prover and verifier keys
3. Follow following steps to generate and verify proof on local system using node/snarkjs  

 `snarkjs plonk prove ./trusted-seupt-powers-of-tau/circuit_final.zkey ./circuit/inputs/witness.wtns ./circuit/inputs/proof.json ./circuit/inputs/public.json`  
 `snarkjs plonk verify ./trusted-seupt-powers-of-tau/verification_key.json ./circuit/inputs/public.json ./circuit/inputs/proof.json`

4. Go to smartcontract directory and follow the instructions to generate a verifier contract and test

