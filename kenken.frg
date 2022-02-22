#lang forge/bsl “cm” “sdy0a6hzorfkosis”

abstract sig Operation {}
one sig Addition extends Operation{} 
one sig Subtraction extends Operation{}
one sig Division extends Operation{}
one sig Multiplication extends Operation{}


//coordinates to the board mapping to the number at that position
one sig Board { 
    position: func Int -> Int -> Int 
    cage: func Int -> Int -> Cage 
}

//each Cage maps to a solution, a number that can be calculated using 
//the operator and the members of the cage 
sig Cage {
    operator: Operation
    solution: Int 
    //have to find some way for a Cage to know about its members
}

//uniqueRows and uniqueCols predicates constrains that 
//the rows and columns in a 3x3 board add up to 6 (1+2+3 = 6)
pred uniqueRows[b: Board] {
    //all rows in a 3x3 KenKen board must add up to 6 
    all row: Int | {
        add[b.position[row][0], b.position[row][1], b.position[row][2]] = 6
    }
}

pred uniqueCols {
    //all rows in a 3x3 KenKen board must add up to 6 
    all col: Int | {
        add[b.position[0][col], b.position[1][col], b.position[2][col]] = 6
    }
}

pred cagesSatisfiable {

}

//constrains the valid number range (1,2,3) for a 3x3 KenKen Board
pred validNumbers[b: Board] {
    all r,c: Int | {
        1 <= b.position[r][c]
        b.position[r][c] <= 3
    }
}



