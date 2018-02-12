# Homework 2, K-State CIS 301, Fall 2017

* **Deadline:** Monday, September 18, 2017, 11:59pm US Central 

* **Total Points:** 25 (**+ 5 bonus points**)

## Assignment Purpose 

- To help you understand how to translate natural language
  requirements into propositional logic

- To help you understand how to use an SMT solver to automatically 
  reason about propositional logic, and in a very simple fashion,
  to illustrate a few of the benefits of SMT solvers

## Notes

- All Homework 2 problems require solutions in Z3;
  thus, per our convention, use the file extension ``.smt2``
  for your solutions. 
  The files can be edited using a text editor, IntelliJ, or
  [Z3 online](http://rise4fun.com/z3).
  
- For all the problems, use only propositional logic 
  operators *and*, *or (inclusive)*, 
  *implies*, and *negation* to express logical formula.
  
- Check you solutions using the following command-line:
 
  - OS X or Linux:
  
    ```
    <SIREUM_HOME>/apps/z3/bin/z3 -smt2 <input>
    ```
    
  - Windows:
  
    ```
    <SIREUM_HOME>\apps\z3\bin\z3 -smt2 <input>
    ```
    
  where:
  
  - ``<SIREUM_HOME>`` is the path to the Sireum v3
    directory 
    
    If you are using CS labs/machines, simply use ``z3``.
    
  - ``<input>`` is the input script file.
  
  For example, to run Z3 in ``remote.cs.win.ksu.edu``,
  ``remote-mac.cs.win.ksu.edu``, or ``cslinux.cs.ksu.edu``:
  
  ```
  z3 -smt2 <input>
  ```

## Problem Descriptions

1. [4 points]
   Give a Z3 script to check validity of:
    
   ``p ∨ q, q → r, ¬p ⊢ r``.  
   
2. [6 points]
   Give a Z3 script that repeatedly use Z3 ``check-sat`` and 
   ``get-model`` commands as outlined in the lecture to find 
   **all** satisfying truth assignments for the following formula:
   
   ``((p → q) ∨ (q → p)) ∧ ¬((p → q) ∧ (q → p))``

3. [15 points]
   Give a Z3 script that expresses the following slightly modified requirements 
   from the [Java Virtual Machine (JVM) Specification Section 4.7.8](http://docs.oracle.com/javase/specs/jvms/se8/html/jvms-4.html#jvms-4.7.8) 
   (using Z3's ``assert``):
   
   - [3 points]
     If a member is an implementation artifact then if it does not appear 
     in the source code then either it is marked using a Synthetic attribute or 
     its ACC_SYNTHETIC flag is set.

   - [3 points]
     If a member is marked using a Synthetic attribute then 'Synthetic' appears 
     in the constant pool.

   - [3 points]
     If a member is not marked using a Synthetic attribute and its ACC_SYNTHETIC is
     unset and it is an implementation artifact,  then it appears in the code.
     
   When writing the script, use the following propositional
   variables to represent the member's state:
   
   - ``p`` = "The member is an implementation artifact."
   
   - ``q`` = "The member appears in the source code."

   - ``r`` = "The member is marked using a Synthetic attribute."
   
   - ``s`` = "The member has its ACC_SYNTHETIC flag set."
   
   - ``t`` = "'Synthetic' appears in the constant pool."
   
   Continuing on:
   
   - [1 points]
     Check that the above requirements as a whole are satisfiable.
     
   - [5 points] 
     Automatic reasoning tools like SMT solvers allow us to pose "what if?" 
     questions about our system to gain an understanding of the implications
     of system requirements.
     
     For the above requirements, consider the following "what if" question
     about a member's state:
     
     *What if a member is an implementation artifact that does not appear in the 
     code, is it possible that "Synthetic" does not appear in the constant pool?*
     
     Intuitively, the "what if" question corresponds to an additional
     propositional logic assertion.

     Check whether the requirements and the new assertion is satisfiable using Z3,
     and if so, get all truth assignments/models from Z3 
     (and think about how the result maps to the members's state as specified above).

### Bonus Problem 
     
4. [5 points]
   The logical operators ``and``, ``or``, ``xor`` are convenient as they are commutative and associative. 
   Z3 will let you use any of these operators with more than 2 arguments, e.g., 
   ``(and p q r)`` is equivalent to ``(and (and p q) r)``, which can be shown as: 
   
   ```smt2  
   (declare-const p Bool)  
   (declare-const q Bool)  
   (declare-const r Bool)  
   (assert (not (= (and p q r) (and (and p q) r))))
   (check-sat)
   ```  
   
   Implication does not have the same properties. 
   Use the technique from problem #2 to find all the cases to ``(implies p q r)`` 
   and from those produce an expression with only two operators that is 
   equivalent.
   Then, prove that they are equivalent (Z3 has an equality operator ``=``). 
   
   Your solution will look like the following:
   
   ```smt2
   ; ... declarations  
   (assert (implies p q r))  
   (check-sat)  
   (get-model)  
   ; ... find all truth assignments of (implies p q r)
   (reset)
   ; ... declarations  
   ; ... check equivalence 
   ```
