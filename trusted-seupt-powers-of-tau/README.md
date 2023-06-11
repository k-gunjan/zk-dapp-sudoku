# Trustest setup  

Powers of tau ceremony to generate a trusted setup for proof generation and verification process  

`circuit_final.zkey` & `verification_key.json` has been generated for `PLONK` proof system.  

## Phase 1  
In following command  we are specifying bn128 curve and supported(max) number of constraints = 2^16  = 65,536   
`snarkjs powersoftau new bn128 16 pot16_000.ptau -v`  
`snarkjs powersoftau contribute pot16_000.ptau pot16_001.ptau --name="first contribution" -v `  

there can more and more contribution here ..  

`snarkjs powersoftau beacon pot16_001.ptau pot16_beacon.ptau 0102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f 10 -n="Final Beacon"`  

Applying beacon is not neccessary but its recommended to apply to increase trust.  

## Phase 2
Start phase 2 and generate pot16_final.ptau  
`snarkjs powersoftau perpare phase2 pot16_beacon.ptau pot16_final.ptau`  

### Setup for PLONK  
Generate `circuit_final.zkey` with following command which will be  used by the prover to generate proof:  
`snarkjs plonk setup ../circuit/sudoku-puzzle.r1cs pot16_final.ptau circuit_final.zkey`  

`note`: because of the file size limitation to upload on github file `circuit_final.zkey` has been split into parts using following command  
`split -b 100M circuit_final.zkey circuit_final.zkey_part_`  
To combine it back run following commannd  
`cat circuit_final.zkey_part_*> circuit_final.zkey`  

Generate verification_key.json which will be used by the  verifier:  

`snarkjs zkey export verificationkey circuit_final.zkey verification_key.json`  