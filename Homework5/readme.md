# Homework 5, K-State CIS 301, Fall 2017

* **Deadline:** Wednesday, November 1, 2017, 11:59pm US Central 

* **Total Points:** 40 points (**+ 8 bonus points**)

## Assignment Purpose 

- To help you understand deduction rules for programming logic.

- To help you understand how to **manually** apply the rules for verifying
  programs.

## Notes

- All Homework 5 problems require Logika solutions;
  thus, per our convention, use the file extension ``.logika``
  for your solutions.
  
- Make sure that you use the ``Forward`` checker kind and ``Auto`` mode **disabled**.
  Please refer to the Logika documentation on 
  [LIVE Settings](http://logika.sireum.org/doc/02-live/index.html#live-settings)
  to configure Logika preferences in IntelliJ.
  You can choose to enable 
  [Hint Generation](http://logika.sireum.org/doc/02-live/index.html#hint-generation)
  and
  [Summoning Incriptions](http://logika.sireum.org/doc/02-live/index.html#summoning-incriptions)
  
- You can use either the ASCII or the Unicode
  symbols for the operators *and* (``∧``, or ``^``), 
  *inclusive-or* (``∨``, or ``V``), 
  *negation* (``¬``, or ``~``),
  *implication* (``→``, or ``->``),
  *sequent* (``⊢``, or ``|-``), 
  *bottom* (``⊥``, or ``_|_``),
  *universal quantifier* (``∀``, ``A``, ``all``, or ``forall``), and
  *existential quantifier* (``∃``, ``E``, ``some``, or ``exists``);
  the Logika IntelliJ (LIVE) plugin features
  [Key Shortcuts](http://logika.sireum.org/doc/02-live/index.html#shortcuts)
  for inserting Logika Unicode operators.
  Note that if you use Unicode, it is best to use 
  [fixed-width font (even for Unicode characters)](http://logika.sireum.org/doc/02-live/index.html#using-a-fixed-width-font)
  when editing your solutions. 

* All fresh and quantified variables have to be typed in programming logic.
  For example, the ``∀i`` rule is now (``T`` is a type, such as ``Z``):
  
  ```
       { a: T // fresh 
         ... P(a)      }
  ∀i: -------------------
         ∀x: T  P(x)

  ```
  
* You can use ``∨e`` on ``x ≤ y`` (as if it's ``x < y ∨ x == y``), and similarly for ``x ≥ y`` (as if it's 
  ``x > y ∨ x == y``). 

## Problem Descriptions

1. [8 **bonus** points] Prove the assertion (by inserting proof steps inside 
   ``l"""{ ... }"""`` after statements) in the Logika program below
   which swaps two input integers by ways of arithmetic manipulations.
   
   ```scala
   import org.sireum.logika._
   
   var x: Z = readInt()
   var y: Z = readInt()
   
   val xIn: Z = x
   val yIn: Z = y
   
   x = x + y
   y = x - y
   x = x - y
   
   assert(x == yIn & y == xIn)
   ```

2. [12 points] Prove the specified assertion in the following Logika program which determines 
   less-than (``r`` is ``-1``), equality (``r`` is ``0``), or greater-than (``r`` is ``1``) 
   relationship between two input integers ``x`` and ``y``:
   
   ```scala
   import org.sireum.logika._
   
   val x: Z = readInt()
   val y: Z = readInt()
   
   var r: Z = 0
   
   if (x < y) {
     r = -1
   } else {
     if (x > y) {
       r = 1
     } else {
     }
   }
   
   assert(r >= -1 & r <= 1 & (r != 0 | x == y))
   ```
 
3. [13 points] Prove the specified assertion in the following program 
   which determines whether a non-negative input integer is even 
   (``r`` is ``0`` if the input ``x`` is even, otherwise ``r`` is ``1``):

   ```scala
   import org.sireum.logika._
   
   val x: Z = readInt()
   
   assume(x >= 0)
   
   var r: Z = x
   
   l"""{ 1. (x % 2 == 0) == (x % 2 == 0)    algebra }"""
   
   while (r >= 2) {
     l"""{ invariant r ≥ 0
                     (r % 2 == 0) == (x % 2 == 0)
           modifies  r }"""
   
     r = r - 2
   
   }
   
   l"""{ 1. 2 ≠ 0    algebra }"""
   
   assert((r == 0) == (x % 2 == 0) & (r == 1) == (x % 2 == 1))
   ```

4. [15 points] Complete the proof for the ``allPos`` method below
   (which was discussed in the Quantifications & Predicates by Example lecture) 
   by fixing incorrect justifications as indicated in comments
   (note: each justification fix is worth 0.5 point):
    
   ```scala
   import org.sireum.logika._
   
   def allPos(a: ZS): B = {
     l"""{ ensures result → ∀j: Z  0 ≤ j ∧ j < a.size → a(j) > 0 }"""
   
     var i: Z = 0
   
     l"""{ 1. i = 0                                                   premise }"""
   
     var r: B = true
   
     l"""{ 1. i = 0                                                   premise
           2. r = true                                                premise
           3. 0 ≤ i                                                   premise // 1 ... fix justification
           4. i ≤ a.size                                              algebra 1 // note: each sequence in Logika has zero or more elements
           5. {
                6. r                                                  assume
                7. {
                     8. k: Z
                     9. {
                         10. 0 ≤ k ∧ k < i                            assume
                         11. 0 ≤ k                                    premise // 2 ... fix justification
                         12. k < i                                    premise // 3 ... fix justification
                         13. ⊥                                        premise // 4 ... fix justification
                         14. a(k) > 0                                 premise // 5 ... fix justification
                        }
                    15. 0 ≤ k ∧ k < i → a(k) > 0                      premise // 6 ... fix justification
                   }
               16. ∀j: Z  0 ≤ j ∧ j < i → a(j) > 0                    premise // 7 ... fix justification
              }
          17. r → ∀j: Z  0 ≤ j ∧ j < i → a(j) > 0                     premise // 8 ... fix justification
         }"""
   
     while (i < a.size) {
       l"""{ invariant 0 ≤ i
                       i ≤ a.size
                       r → ∀j: Z  0 ≤ j ∧ j < i → a(j) > 0
             modifies i, r }"""
   
       if (a(i) <= 0) {
   
         r = false
   
         l"""{ 1. 0 ≤ i                                               premise
               2. i < a.size                                          premise
               3. r = false                                           premise
               4. ¬r                                                  algebra 3 // note: algebra can be used on ¬ and boolean (but not on ∧, ∨, →, ∀, or ∃)
               5. {
                    6. r                                              assume
                    7. ⊥                                              premise //  9 ... fix justification
                    8. ∀j: Z  0 ≤ j ∧ j ≤ i → a(j) > 0                premise // 10 ... fix justification
                  }
               9. r → ∀j: Z  0 ≤ j ∧ j ≤ i → a(j) > 0                 premise // 11 ... fix justification
             }"""
              
       } else {
   
         l"""{ 1. 0 ≤ i                                               premise
               2. i < a.size                                          premise
               3. ¬(a(i) ≤ 0)                                         premise
               4. r → ∀j: Z  0 ≤ j ∧ j < i → a(j) > 0                 premise
               5. a(i) > 0                                            premise // 12 ... fix justification
               6. {
                    7. r                                              assume
                    8. ∀j: Z  0 ≤ j ∧ j < i → a(j) > 0                premise // 13 ... fix justification
                    9. {
                        10. k: Z
                        11. {
                             12. 0 ≤ k ∧ k ≤ i                        assume
                             13. 0 ≤ k                                premise // 14 ... fix justification
                             14. k ≤ i                                premise // 15 ... fix justification
                             15. {
                                  16. k < i                           assume
                                  17. 0 ≤ k ∧ k < i                   premise // 16 ... fix justification
                                  18. 0 ≤ k ∧ k < i → a(k) > 0        premise // 17 ... fix justification
                                  19. a(k) > 0                        premise // 18 ... fix justification
                                 }
                             20. {
                                  21. k = i                           assume
                                  22. a(k) > 0                        premise // 19 ... fix justification
                                 }
                             23. a(k) > 0                             premise // 20 ... fix justification (hint: see last bullet point in the hw notes)
                            }
                        24. 0 ≤ k ∧ k ≤ i → a(k) > 0                  →i 11
                       }
                   25. ∀j: Z  0 ≤ j ∧ j ≤ i → a(j) > 0                ∀i 9
                  }
              26. r → ∀j: Z  0 ≤ j ∧ j ≤ i → a(j) > 0                 →i 6
             }"""
   
       }
   
       l"""{ 1. 0 ≤ i                                                 premise
             2. i < a.size                                            premise
             3. r → ∀j: Z  0 ≤ j ∧ j ≤ i → a(j) > 0                   premise
           }"""
   
       i = i + 1
   
       l"""{ 1. 0 ≤ i_old                                             premise
             2. i_old < a.size                                        premise
             3. r → ∀j: Z  0 ≤ j ∧ j ≤ i_old → a(j) > 0               premise 
             4. i = i_old + 1                                         premise
             5. i_old = i - 1                                         algebra 4
             6. r → ∀j: Z  0 ≤ j ∧ j ≤ i - 1 → a(j) > 0               premise // 21 ... fix justification
             7. {
                  8. r                                                assume
                  9. ∀j: Z  0 ≤ j ∧ j ≤ i - 1 → a(j) > 0              premise // 22 ... fix justification
                 10. {
                      11. k: Z
                      12. 0 ≤ k ∧ k ≤ i - 1 → a(k) > 0                premise // 23 ... fix justification
                      13. {
                           14. 0 ≤ k ∧ k < i                          assume
                           15. 0 ≤ k                                  ∧e1 14
                           16. k < i                                  ∧e2 14
                           17. k ≤ i - 1                              premise // 24 ... fix justification
                           18. 0 ≤ k ∧ k ≤ i - 1                      premise // 25 ... fix justification
                           19. a(k) > 0                               premise // 26 ... fix justification
                          }
                      20. 0 ≤ k ∧ k < i → a(k) > 0                    →i 13
                     }
                 21. ∀j: Z  0 ≤ j ∧ j < i → a(j) > 0                  ∀i 10
                }
              22. r → ∀j: Z  0 ≤ j ∧ j < i → a(j) > 0                 →i 7
              23. 0 ≤ i                                               premise // 27 ... fix justification
              24. i ≤ a.size                                          premise // 28 ... fix justification
           }"""
       
     }
     
     l"""{ 1. i ≤ a.size                                              premise
           2. ¬(i < a.size)                                           premise
           3. r → ∀j: Z  0 ≤ j ∧ j < i → a(j) > 0                     premise
           4. i = a.size                                              premise // 29 ... fix justification
           5. r → ∀j: Z  0 ≤ j ∧ j < a.size → a(j) > 0                premise // 30 ... fix justification
         }"""
   
     return r
   }
   ```