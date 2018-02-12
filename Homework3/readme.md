# Homework 3, K-State CIS 301, Fall 2017

* **Deadline:** Friday, September 27, 2017, 11:59pm US Central 

* **Total Points:** 30 (**+ 5 bonus points**)

## Assignment Purpose 

- To help you understand natural deduction rules for
  propositional logic.

- To help you understand how to apply the rules for proving
  validity of sequents.

- To help you understand some properties of propositional
  logic connectives and how they can be proven using
  natural deduction.

## Hints

- If you get stuck in a proof, take a look at the tactics
  given in the lecture slides associated with the operators 
  involved in the formulae.

- Remember, try ``pbc`` as the last resort!

## Notes

- All Homework 3 problems require Logika solutions;
  thus, per our convention, use the file extension ``.logika``
  for your solutions. 
  
- You can use either the ASCII or the Unicode
  symbols for the operators *and* (``∧``, or ``^``), 
  *inclusive-or* (``∨``, or ``V``), 
  *negation* (``¬``, or ``~``),
  *implication* (``→``, or ``->``),
  *sequent* (``⊢``, or ``|-``), and 
  *bottom* (``⊥``, or ``_|_``);
  the Logika IntelliJ (LIVE) plugin features
  [Key Shortcuts](http://logika.sireum.org/doc/02-live/index.html#shortcuts)
  for inserting Logika Unicode operators.
  Note that if you use Unicode, it is best to use 
  [fixed-width font (even for Unicode characters)](http://logika.sireum.org/doc/02-live/index.html#using-a-fixed-width-font)
  when editing your solutions. 

## Problem Descriptions

1. [7 points]
   The *inclusive-or* connective is associative; that is,
   ``(p ∨ q) ∨ r`` is equivalent to ``p ∨ (q ∨ r)``.
   
   Give a Logika natural deduction proof for
   (one direction of the equivalence): ``(p ∨ q) ∨ r  ⊢  p ∨ (q ∨ r)``.

2. [5 points]
   Consider the following claim:
   
   "If supplied with a number, then the function *abs* returns a non-negative number."
   
   Given such claim as a premise, give a Logika natural deduction proof for
   the claim below:
   
   "If supplied with a number and the number is negative, then the function *abs* returns a non-negative number."

   In your proof, use the following propositional symbols:
   
   - ``p`` = "The function *abs* is supplied with a number."
   
   - ``q`` = "The supplied number to function *abs* is negative."
   
   - ``r`` = "The function *abs* returns a non-negative number."
   
3. [5 points] 
   Similar to the previous question, consider:
   
   "If supplied with a positive number *i*, the function *fibAt* returns the *i*-th number in a pre-defined sequence, and the number is a [Fibonacci number](https://en.wikipedia.org/wiki/Fibonacci_number)
   ."

   Given such claim as a premise, give a Logika natural deduction proof for
   the claim below:
   
   "If supplied with a positive number *i*, the function *fibAt* returns the *i*-th number in a pre-defined sequence."

   In your proof, use the following propositional symbols:
      
   - ``p`` = "The function *fibAt* is supplied with a positive number *i*."
      
   - ``q`` = "The function *fibAt* returns the *i*-th number in a pre-defined sequence."

   - ``r`` = "The function *fibAt* returns a prime number."   

4. [7 points] Recall that in [problem #3 of the second homework](../hw2/readme.md),
   you were asked to express the following Logika requirement in Z3:
   
   "If the member is an implementation artifact then 
   if it does not appear in the source code then 
   either it is marked using a Synthetic attribute or its ACC_SYNTHETIC flag is set."
    
   Given the above as the (first) premise with the following 
   two additional premises:
   
   - "the member is an implementation artifact and it does not appear in the source code." (second premise)
   
   - "the member's ACC_SYNTHETIC flag is unset." (third premise)
   
   give a Logika natural deduction proof to conclude that:
   
   "The member is marked using a Synthetic attribute."
   
   Similar to the second homework, use the following propositional symbols:
   
   - ``p`` = "The member is an implementation artifact."
   
   - ``q`` = "The member appears in the source code."
   
   - ``r`` = "The member is marked using a Synthetic attribute."

   - ``s`` = "The member's ACC_SYNTHETIC flag is set."

5. [6 points]
   Recall that in [problem #5 of the first homework](../hw1/5.logika),
   you were asked to give a Logika truth table for
   ``¬(p ∨ s) ∧ (q ∨ ¬r) → r → q``, which corresponds to the sequent:
   ``¬(p ∨ s), q ∨ ¬r  ⊢  r → q``.
   
   Give a corresponding Logika natural deduction proof for the sequent.

### Bonus Question

6. [5 points]
   Prove ``¬(p ∧ q) ⊢ ¬p ∨ ¬q``.
