# Homework 4, K-State CIS 301, Fall 2017

* **Deadline:** Wednesday, October 18, 2017, 11:59pm US Central 

* **Total Points:** 40 points (**+ 8 bonus points**)

## Assignment Purpose 

- To help you understand natural deduction rules for
  predicate logic.

- To help you understand how to apply the rules for proving
  validity of sequents.

- To help you understand some properties of predicate
  logic quantifiers and how they can be proven using
  natural deduction.

## Notes

- All Homework 4 problems require Logika solutions;
  thus, per our convention, use the file extension ``.logika``
  for your solutions. 
  
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

## Problem Descriptions

1. [6 points] Consider the following syllogism:

   > All rabbits have fur.
   >
   > Some pets are rabbits.
   >
   > Therefore, some pets have fur.

   Translate the above to predicate logic using the predicates ``rabbit(_)``, ``fur(_)``, and ``pet(_)``; 
   then, give a Logika natural deduction proof for it.

2. [6 points] Give a Logika natural deduction proof for the following De Morgan's instance:

   ```logika
   ∃x ¬p(x)  ⊢  ¬∀x p(x)
   ```

3. [6 points] Give a Logika natural deduction proof for exchanging Quantifiers:
   
   ```logika
   ∃y ∀x p(x, y)  ⊢  ∀x ∃y p(x, y)
   ```
   
4. [9 points] 
Give a Logika natural deduction proof for the following sequent:
   
   ```logika
   (∀x p(x)) → (∃x q(x))  ⊢  (∀x ¬q(x)) → (∃x ¬p(x))
   ```
   
5. [13 points] For this problem, consider the connective "if and only if". "p if and only if q" means ``(p → q) ^ (q → p)``.
These means that ``p`` and ``q`` always have the same truth value. This is useful for defining properties (ex. "x is
even if and only if x % 2 == 0 "). Consider two forms of xor, ``(p ∧ ¬q) ∨ (¬p ∧ q)`` and ``(p ∨ q) ∧ (¬p ∨ ¬q)``. These
two definitions imply each other. While both implication can be proven, you are only asked to do one direction.

   ```logika
   ∀p ∀q xor1(p, q) → (p ∧ ¬q) ∨ (¬p ∧ q),
   ∀p ∀q (p ∧ ¬q) ∨ (¬p ∧ q) → xor1(p, q),
   ∀p ∀q xor2(p, q) → (p ∨ q) ∧ (¬p ∨ ¬q),
   ∀p ∀q (p ∨ q) ∧ (¬p ∨ ¬q) → xor2(p, q)
   ⊢
   ∀p ∀q xor1(p, q) → xor2(p, q)
   ```
   
## Bonus Question
   
6. [8 points] For this question, recall the discussion of "if and only if". A [Relation](https://en.wikipedia.org/wiki/Binary_relation)
can be modelled in logika using a predicate. Notice that the relation ``eq`` holds when two booleans have the same value.
This is actually a special kind of relation called a [Equivalence relation](https://en.wikipedia.org/wiki/Equivalence_relation#Definition).
Equivalence Relations are [Reflexive](https://en.wikipedia.org/wiki/Reflexive_relation), [Symmetric](https://en.wikipedia.org/wiki/Symmetric_relation),
[Transitive](https://en.wikipedia.org/wiki/Transitive_relation). Here you are asked to prove that ``eq`` is in fact transitive.
   
   ```logika
   ∀p ∀q eq(p, q) → (p → q) ∧ (q → p),
   ∀p ∀q (p → q) ∧ (q → p) → eq(p, q) ⊢
   ∀p ∀q ∀r eq(p, q) ∧ eq(q, r) → eq(p, r)
   ```
   
