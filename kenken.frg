#lang forge/bsl "cm" "sdy0a6hzorfkosis"

/*
TODO LIST:

How to add up all members' values given a cage (for cagesSatisfiable)
    (use sum[...] ? - Have a "set" of members in Cage sig?)
    OR, 
    Is there a way if we add a cage field to the member class,
    to add up all members associated with a cage?

Is our operation architecture good or is it convoluted?

Check constraints for other types of cage-operations

EDPOST: How to set global fields, BOARD_ROW_NUM global variable, etc...
    MAX_BOUNDS, etc...
*/

// Board is BOARD_ROW_NUM by BOARD_ROW_NUM. This is ALSO the maximum integer val of each member & max_add_cagesize
fun BOARD_ROW_NUM: one Int { 3 }
// The minimum integer value of each member
fun MIN_MEMBER_VAL: one Int {1}
// The max integer value of each member
fun MAX_MEMBER_VAL: one Int {BOARD_ROW_NUM}
// The maximum number of tiles a single cage can have
fun MAX_CAGE_SIZE: one Int { 9 } //max size cage rules? 


// The minimum number of tiles a single cage can have
fun MIN_CAGE_SIZE: one Int { 1 } 
// The maximum size of a non-addition cage
fun MAX_NONADD_CAGESIZE: one Int { 2 }
// For the purposes of curiosity modeling, we simplify the problem such that addition cages
// are the only cages that can be of size >2
fun MAX_ADD_CAGESIZE: one Int { BOARD_ROW_NUM }


abstract sig Operation {}
one sig Addition extends Operation{} 
one sig Subtraction extends Operation{}
one sig Division extends Operation{}
one sig Multiplication extends Operation{}

// We have members instead of raw integers to allow for duplicates
sig Member{
    val: one Int // value
    // c : one Cage
}

//coordinates to the board mapping to the number at that position
one sig Board {  
    position: func Int -> Int -> Member,
    cage: func Int -> Int -> Cage
}


one sig Yes {}

//each Cage maps to a solution, a number that can be calculated using 
//the operator and the members of the cage 
sig Cage {
    operator: one Operation,
    solution: one Int,
    // Have a set of members associated with a cage
    members: pfunc Member -> Yes
}



// run {

// } for exactly 9 Member, 1 Cage, 1 Board 

/*
Every member is part of a cage

all row,col : Int | {
    some c : Cage | {
        (Board.cage[row][col] = c) implies {

        }
    }
    
}
*/


// Each member is on the board on exactly one position
pred Singleton {
    all m : Member | {
      // Each member is on the board on exactly one square
      one i, j: Int | { 
        // The board is BOARD_ROW_NUMxBOARD_ROW_NUM so Int ranges from MIN_MEMBER_VAL to BOARD_ROW_NUM
        // e.g. constrains the valid number range (1,2,3) for a 3x3 KenKen Board
        i >= MIN_MEMBER_VAL and i <= MAX_MEMBER_VAL
        j >= MIN_MEMBER_VAL and j <= MAX_MEMBER_VAL

        Board.position[i][j] = m

        // no k,l: Int | {
        //     (k != i or l != j implies Board.position[k][l] = m)
        // }
      } 
    //   // No members exist outside the board bounds
    //   no i,j: Int | { // Currently unsat
    //     ((i < MIN_MEMBER_VAL or i > MAX_MEMBER_VAL or
    //     j < MIN_MEMBER_VAL or j > MAX_MEMBER_VAL)
    //     implies
    //     Board.position[i][j] = m)
    //   }
    }
    // Member positions should not overlap because if i,j are mapped to a specific member, they can't be mapped to anything else
    // This preidcate was adopted from the n-queens lab

    // Check cage doesn't overlap
    // Check members unique between cages
    // All members belong to a cage
    
}

pred membersValidValues {
    all m: Member | {
        m.val >= MIN_MEMBER_VAL and m.val <= MAX_MEMBER_VAL
    }
}

//uniqueRows and uniqueCols predicates constrains that 
//the rows and columns in a 3x3 board add up to 6 (1+2+3 = 6)
pred uniqueRows {
    //all rows in a 3x3 KenKen board must add up to 6 
    all row: Int | {
        // add[b.position[row][0].val, b.position[row][1].val, b.position[row][2].val] = 6
        no disj col1,col2: Int | {
            all m1,m2: Member | Board.position[row][col1] = m1 and Board.position[row][col2] = m2 implies {
                m1.val = m2.val
            }
            // Board.position[row][col1].val = Board.position[row][col2].val
        }
    }
}

// pred uniqueCols {
//     //all rows in a 3x3 KenKen board must add up to 6 
//     all col: Int | {
//         // add[b.position[0][col].val, b.position[1][col].val, b.position[2][col].val] = 6
//         no disj row1,row2: Int | {
//             Board.position[row1][col].val = Board.position[row2][col].val
//         }
//     }
// }

pred wellformed {
    // Rows unique member values
// uniqueRows
    // Columns unique member values
// uniqueCols
    // Members have properly constrained values
    membersValidValues
}




pred cagesInitial {
    // Every cage should map to a valid place on the board

    // Cages do not map to places not on the board

    // Cages do not overlap

    // Subtraction cages should have a maximum of two members
    // (TODO: Check constraints for other types of cage-operations)

    // Cages must be connected veritcally/horizontally
}

pred cagesSatisfiable {
/*
all c: Cage:
    c.operator = Addition implies
        all c: Cage | {
        (sum m: Member | c.member[m] = Yes implies m.val else 0) = c.solution
        }
    c.operator = Subtraction implies
        ... all elements in cage subtract[] = c.solution
        // NOTE: For division and subtraction, check all permutations of calculation
        // There has to be SOME ordering that produces solution
    c.operator = ...
        ...
*/

/*

Sequence library: Every cage contains a sequence of Members,
follow seq in constraint & use an aggregator. Member's "soFar" val
is itself, every other Members' soFar is itself (operation) predecesso`r

In this version, consider addition is only type of operation allowed
to have a cage of >2 cells

           // sum[c.members.val]
*/
}

run {
    // wellformed
    Singleton
} for exactly 9 Member, 1 Board