pragma circom 2.0.0;

include "../node_modules/circomlib/circuits/comparators.circom";

// takes puzzle and the solution boards
template Sudoku () {
    // puzzle is a 2D array [row, col]
    // 0 value in a square indicates a blank square 
    signal input challengeBoard[9][9];
    // solution is same execpt no squre is 0
    signal input solutionBoard[9][9];

    // check if every number in the solutionBoard is in the range 1 to 9(inclusive)
    component checkLowerLimit[9][9];
    component checkUpperLimit[9][9];

    for ( var i = 0; i < 9; i++ ) {
        for ( var j = 0; j < 9; j++ ) {
            checkLowerLimit[i][j] = GreaterEqThan(32);
            checkLowerLimit[i][j].in[0] <== solutionBoard[i][j]; 
            checkLowerLimit[i][j].in[1] <== 1; 

            checkUpperLimit[i][j] = LessEqThan(32);
            checkUpperLimit[i][j].in[0] <== solutionBoard[i][j];
            checkUpperLimit[i][j].in[1] <== 9;

            checkLowerLimit[i][j].out === checkUpperLimit[i][j].out;

            // check if the solutionBoard is the solution of challengeBoard
            // for this every non-zero square of the challege should be same as
            // solution. And for every zero square solution will be non-zero
            challengeBoard[i][j] * ( challengeBoard[i][j] - solutionBoard[i][j] ) === 0;
        }
    }

    // check that every square in a row contains distinct numbers
    component checkRow[324];
    var rowIndex = 0;

    for (var i = 0; i < 9; i++) {
       for (var j = 0; j < 9; j++) {
            for (var k = 0; k < j; k++) {
                checkRow[rowIndex] = IsEqual();
                checkRow[rowIndex].in[0] <== solutionBoard[i][k];
                checkRow[rowIndex].in[1] <== solutionBoard[i][j];
                checkRow[rowIndex].out === 0;
                rowIndex ++;
            }
        }
    }

    // check that every square in a col contains distinct numbers
    component checkCol[324];
    var colIndex = 0;

    for (var i = 0; i < 9; i++) {
       for (var j = 0; j < 9; j++) {
            for (var k = 0; k < j; k++) {
                checkCol[colIndex] = IsEqual();
                checkCol[colIndex].in[0] <== solutionBoard[k][i];
                checkCol[colIndex].in[1] <== solutionBoard[j][i];
                checkCol[colIndex].out === 0;
                colIndex ++;
            }
        }
    }

    // check that every 3×3 square contains distinct numbers
    component checkSmallGrid[324];
    var smallGridIndex = 0;

    for (var i = 0; i < 9; i+=3) {
       for (var j = 0; j < 9; j+=3) {
            for (var k = i; k < i+3; k++) {
                for (var l = j; l < j+3; l++) {
                    for (var m = i; m <= k; m++) {
                        for (var n = j; n < l; n++){
                            checkSmallGrid[smallGridIndex] = IsEqual();
                            checkSmallGrid[smallGridIndex].in[0] <== solutionBoard[m][n];
                            checkSmallGrid[smallGridIndex].in[1] <== solutionBoard[k][l];
                            checkSmallGrid[smallGridIndex].out === 0;
                            smallGridIndex ++;
                        }
                    }
                }
            }
        }
    }

}

component main {public[challengeBoard]} = Sudoku();