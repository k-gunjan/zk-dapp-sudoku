# Circuit & witness generation

Sudoku puzzle checker is written in sudoku-puzzle.circom  

## Compile the circuit
Compile it with circom compiler and generate r1cs contraint file and other files needed  
to generate the witness

`circom sudoku-puzzle.circom --wasm --r1cs`  
<pre>
    `--r1cs`: it generates the file multiplier2.r1cs that contains the R1CS constraint system of the circuit in binary format.
    `--wasm`: it generates the directory multiplier2_js that contains the Wasm code (multiplier2.wasm) and other files needed to generate the witness.
</pre>

## Prepare the input file
Save the input data into a file called input.json in the input directory. refer input/input_1.json for reference.  

## Computing the witness with WebAssembly

Following is the syntax of the witness generation command. We can generate witness for input without the need of any trusted setup files.  
`node <generate_witness.js> <circuit.wasm> <input.json> <witness.wtns>`  

In our case we are in circuit directory and will run following command as per our directory structure.  
`node sudoku-puzzle_js/generate_witness.js sudoku-puzzle_js/sudoku-puzzle.wasm inputs/input.json inputs/witness.wtns`  
This will generate witness file witness_1.wtns in the inputs directory.  

