#lang forge/bsl “cm” “sdy0a6hzorfkosis”

/*
TODO LIST:

How to add up all members' values given a cage (for cagesSatisfiable)
    (use sum[...] ? - Have a "set" of members in Cage sig?)
    OR, 
    Is there a way if we add a cage field to the member class,
    to add up all members associated with a cage?

Is our operation architecture good or is it convoluted?
*/


abstract sig Operation {}
one sig Addition extends Operation{} 
one sig Subtraction extends Operation{}
one sig Division extends Operation{}
one sig Multiplication extends Operation{}

// We have members instead of raw integers to allow for duplicates
sig Member{
    val: one Int // value
}

//coordinates to the board mapping to the number at that position
one sig Board { 
    position: func Int -> Int -> Member 
    cage: func Int -> Int -> Cage 
}

/*
Every member is part of a cage

all row,col : Int | {
    some c : Cage | {
        (Board.cage[row][col] = c) implies {

        }
    }
    
}
*/

//each Cage maps to a solution, a number that can be calculated using 
//the operator and the members of the cage 
sig Cage {
    operator: one Operation
    solution: one Int 
    // Have a set of members associated with a cage

}

// Each member is on the board on exactly one position
pred Singleton {
    all m : Member | {
      // Each member is on the board on exactly one square
      one i, j: Int | { 
        Board.position[i][j] = m
        // The board is 3x3 so Int ranges from 1-3
        // constrains the valid number range (1,2,3) for a 3x3 KenKen Board
        i >= 1 and i<= 3
        j >= 1 and j<= 3
      } 
    }
    // Member positions should not overlap because if i,j are mapped to a specific member, they can't be mapped to anything else
    // This preidcate was adopted from the n-queens lab
}

pred boardInitial { // TODO: maybe remove this?
    /*
    It is a square 3x3 board (hardcoding a 3x3 kenken)
    */
}

//uniqueRows and uniqueCols predicates constrains that 
//the rows and columns in a 3x3 board add up to 6 (1+2+3 = 6)
pred uniqueRows[b: Board] {
    //all rows in a 3x3 KenKen board must add up to 6 
    all row: Int | {
        add[b.position[row][0].val, b.position[row][1].val, b.position[row][2].val] = 6
    }
}

pred uniqueCols {
    //all rows in a 3x3 KenKen board must add up to 6 
    all col: Int | {
        add[b.position[0][col].val, b.position[1][col].val, b.position[2][col].val] = 6
    }
}


pred cagesInitial {
    // Every cage should map to a valid place on the board

    // Cages do not map to places not on the board

    // Cages do not overlap
}

pred cagesSatisfiable {
/*
all c: Cage:
    c.operator = Addition implies
        ...all elements in cage add[] = c.solution
    c.operator = Subtraction implies
        ... all elements in cage subtract[] = c.solution
        // NOTE: For division and subtraction, check all permutations of calculation
        // There has to be SOME ordering that produces solution
    c.operator = ...
        ...
*/

/*
    all m : Member, c: Cage | m.cage = c implies {

    }
*/

}