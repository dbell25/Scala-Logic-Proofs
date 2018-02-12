# Homework 7, K-State CIS 301, Fall 2017

* **Deadline:** Sunday, December 10, 2017, 11:59pm US Central 

* **Total Points:** 50 points (**+ 30 bonus points**)

## Assignment Purpose 

- To further help you to understand how to formalize English program requirements using logic.

- To further help you to understand how to come up with loop invariants. 

- To help you to understand how to reason about (recursive/non-recursive) function/procedure calls
  and shared data structure.

- To help you to understand how to reason about program termination.

## Notes

- All Homework 7 problems require Logika solutions;
  thus, per our convention, use the file extension ``.logika``
  for your solutions.
  
- Make sure that you use the ``Summarizing SymExe`` checker kind.
  
  **Important:** Once you come up with a solution for a problem, enable 
  ``Check facts and contracts satisfiability`` mode and run Logika to check for 
  unsatisfiable pre/post-conditions.
  If you receive an error, then you have inconsistent pre/post-conditions, which you need to fix.
  On the other hand, if you receive a warning indicating "may or may not satisfiable", 
  then that's generally ok.
  
  Please refer to the Logika documentation on 
  [LIVE Settings](http://logika.sireum.org/doc/02-live/index.html#live-settings)
  to configure Logika preferences in IntelliJ.
  You can choose to enable 
  [Hint Generation](http://logika.sireum.org/doc/02-live/index.html#hint-generation)
  (enable
  [Summoning Incriptions](http://logika.sireum.org/doc/02-live/index.html#summoning-incriptions)
  only if you think it's necessary).

- **Important:** Avoid identifier name clash between program variables and quantified variables.

## Problem Descriptions

1. [17 points] Below is a [bubble sort](https://en.wikipedia.org/wiki/Bubble_sort) 
   implementation that uses the ``swap`` procedure presented in class.
   Your task is to verify that the ``bubbleSort`` procedure correctly sorts the input array non-decreasingly (in-place).
   This involves formalizing its contracts and loop invariants necessary to prove the given test 
   assertions (note that the assertions do not require you to specify/verify that the sorted array is a permutation 
   of the input array).
   
   ```scala
   import org.sireum.logika._
   
   def swap(a: ZS, i: Z, j: Z): Unit = {
     l"""{ requires 0 ≤ i ∧ i < a.size
                    0 ≤ j ∧ j < a.size
           modifies a
           ensures  a(i) == a_in(j) ∧ a(j) == a_in(i)
                    ∀k: (0 ..< a.size)
                      k ≠ i ∧ k ≠ j → a(k) == a_in(k)
                    a.size == a_in.size }"""
     val t: Z = a(i)
     a(i) = a(j)
     a(j) = t
   }
   
   def bubbleSort(a: ZS): Unit = {
     l"""{ modifies a
           ensures  true // FIXME
     }"""
   
     var k: Z = 0
   
     println("Before loop 1: a = ", a, ", k = ", k)
   
     while (k < a.size - 1) {
       l"""{ invariant true // FIXME
             modifies  a, k }"""
   
       println("Loop 1 pre:    a = ", a, ", k = ", k)
   
       var l: Z = 0
   
       println("Before loop 2: a = ", a, ", k = ", k, ", l = ", l)
   
       while (l < a.size - k - 1) {
         l"""{ invariant true // FIXME
               modifies  a, l }"""
   
         println("Loop 2 pre:    a = ", a, ", k = ", k, ", l = ", l)
   
         if (a(l) > a(l + 1)) {
           swap(a, l, l + 1)
         }
   
         l = l + 1
   
         println("Loop 2 post:   a = ", a, ", k = ", k, ", l = ", l)
       }
   
       println("After 2 loop:  a = ", a, ", k = ", k, ", l = ", l)
   
       k = k + 1
   
       println("Loop 1 post:   a = ", a, ", k = ", k)
     }
   
     println("After 1 loop:  a = ", a, ", k = ", k)
   }
   
   // Verified Tests
   
   val test1: ZS = ZS(2, 3, 1)
   bubbleSort(test1)
   /* Trace log:
   Before loop 1: a = [2, 3, 1], k = 0
   Loop 1 pre:    a = [2, 3, 1], k = 0
   Before loop 2: a = [2, 3, 1], k = 0, l = 0
   Loop 2 pre:    a = [2, 3, 1], k = 0, l = 0
   Loop 2 post:   a = [2, 3, 1], k = 0, l = 1
   Loop 2 pre:    a = [2, 3, 1], k = 0, l = 1
   Loop 2 post:   a = [2, 1, 3], k = 0, l = 2
   After 2 loop:  a = [2, 1, 3], k = 0, l = 2
   Loop 1 post:   a = [2, 1, 3], k = 1
   Loop 1 pre:    a = [2, 1, 3], k = 1
   Before loop 2: a = [2, 1, 3], k = 1, l = 0
   Loop 2 pre:    a = [2, 1, 3], k = 1, l = 0
   Loop 2 post:   a = [1, 2, 3], k = 1, l = 1
   After 2 loop:  a = [1, 2, 3], k = 1, l = 1
   Loop 1 post:   a = [1, 2, 3], k = 2
   After 1 loop:  a = [1, 2, 3], k = 2
   */
   assert(test1(0) <= test1(1) & test1(1) <= test1(2))
   
   val test2: ZS = ZS(8, 7, 8)
   bubbleSort(test2)
   /*
   Before loop 1: a = [8, 7, 8], k = 0
   Loop 1 pre:    a = [8, 7, 8], k = 0
   Before loop 2: a = [8, 7, 8], k = 0, l = 0
   Loop 2 pre:    a = [8, 7, 8], k = 0, l = 0
   Loop 2 post:   a = [7, 8, 8], k = 0, l = 1
   Loop 2 pre:    a = [7, 8, 8], k = 0, l = 1
   Loop 2 post:   a = [7, 8, 8], k = 0, l = 2
   After 2 loop:  a = [7, 8, 8], k = 0, l = 2
   Loop 1 post:   a = [7, 8, 8], k = 1
   Loop 1 pre:    a = [7, 8, 8], k = 1
   Before loop 2: a = [7, 8, 8], k = 1, l = 0
   Loop 2 pre:    a = [7, 8, 8], k = 1, l = 0
   Loop 2 post:   a = [7, 8, 8], k = 1, l = 1
   After 2 loop:  a = [7, 8, 8], k = 1, l = 1
   Loop 1 post:   a = [7, 8, 8], k = 2
   After 1 loop:  a = [7, 8, 8], k = 2
   */
   assert(test2(0) <= test2(1) & test2(1) <= test2(2))
   
   val test3: ZS = ZS(8, 7, 9, 5)
   bubbleSort(test3)
   /*
   Before loop 1: a = [8, 7, 9, 5], k = 0
   Loop 1 pre:    a = [8, 7, 9, 5], k = 0
   Before loop 2: a = [8, 7, 9, 5], k = 0, l = 0
   Loop 2 pre:    a = [8, 7, 9, 5], k = 0, l = 0
   Loop 2 post:   a = [7, 8, 9, 5], k = 0, l = 1
   Loop 2 pre:    a = [7, 8, 9, 5], k = 0, l = 1
   Loop 2 post:   a = [7, 8, 9, 5], k = 0, l = 2
   Loop 2 pre:    a = [7, 8, 9, 5], k = 0, l = 2
   Loop 2 post:   a = [7, 8, 5, 9], k = 0, l = 3
   After 2 loop:  a = [7, 8, 5, 9], k = 0, l = 3
   Loop 1 post:   a = [7, 8, 5, 9], k = 1
   Loop 1 pre:    a = [7, 8, 5, 9], k = 1
   Before loop 2: a = [7, 8, 5, 9], k = 1, l = 0
   Loop 2 pre:    a = [7, 8, 5, 9], k = 1, l = 0
   Loop 2 post:   a = [7, 8, 5, 9], k = 1, l = 1
   Loop 2 pre:    a = [7, 8, 5, 9], k = 1, l = 1
   Loop 2 post:   a = [7, 5, 8, 9], k = 1, l = 2
   After 2 loop:  a = [7, 5, 8, 9], k = 1, l = 2
   Loop 1 post:   a = [7, 5, 8, 9], k = 2
   Loop 1 pre:    a = [7, 5, 8, 9], k = 2
   Before loop 2: a = [7, 5, 8, 9], k = 2, l = 0
   Loop 2 pre:    a = [7, 5, 8, 9], k = 2, l = 0
   Loop 2 post:   a = [5, 7, 8, 9], k = 2, l = 1
   After 2 loop:  a = [5, 7, 8, 9], k = 2, l = 1
   Loop 1 post:   a = [5, 7, 8, 9], k = 3
   After 1 loop:  a = [5, 7, 8, 9], k = 3
   */
   assert(test3(0) <= test3(1) & test3(1) <= test3(2) & test3(2) <= test3(3))
   
   val test4: ZS = ZS(5, 2, 3, 1, 4)
   bubbleSort(test4)
   /*
   Before loop 1: a = [5, 2, 3, 1, 4], k = 0
   Loop 1 pre:    a = [5, 2, 3, 1, 4], k = 0
   Before loop 2: a = [5, 2, 3, 1, 4], k = 0, l = 0
   Loop 2 pre:    a = [5, 2, 3, 1, 4], k = 0, l = 0
   Loop 2 post:   a = [2, 5, 3, 1, 4], k = 0, l = 1
   Loop 2 pre:    a = [2, 5, 3, 1, 4], k = 0, l = 1
   Loop 2 post:   a = [2, 3, 5, 1, 4], k = 0, l = 2
   Loop 2 pre:    a = [2, 3, 5, 1, 4], k = 0, l = 2
   Loop 2 post:   a = [2, 3, 1, 5, 4], k = 0, l = 3
   Loop 2 pre:    a = [2, 3, 1, 5, 4], k = 0, l = 3
   Loop 2 post:   a = [2, 3, 1, 4, 5], k = 0, l = 4
   After 2 loop:  a = [2, 3, 1, 4, 5], k = 0, l = 4
   Loop 1 post:   a = [2, 3, 1, 4, 5], k = 1
   Loop 1 pre:    a = [2, 3, 1, 4, 5], k = 1
   Before loop 2: a = [2, 3, 1, 4, 5], k = 1, l = 0
   Loop 2 pre:    a = [2, 3, 1, 4, 5], k = 1, l = 0
   Loop 2 post:   a = [2, 3, 1, 4, 5], k = 1, l = 1
   Loop 2 pre:    a = [2, 3, 1, 4, 5], k = 1, l = 1
   Loop 2 post:   a = [2, 1, 3, 4, 5], k = 1, l = 2
   Loop 2 pre:    a = [2, 1, 3, 4, 5], k = 1, l = 2
   Loop 2 post:   a = [2, 1, 3, 4, 5], k = 1, l = 3
   After 2 loop:  a = [2, 1, 3, 4, 5], k = 1, l = 3
   Loop 1 post:   a = [2, 1, 3, 4, 5], k = 2
   Loop 1 pre:    a = [2, 1, 3, 4, 5], k = 2
   Before loop 2: a = [2, 1, 3, 4, 5], k = 2, l = 0
   Loop 2 pre:    a = [2, 1, 3, 4, 5], k = 2, l = 0
   Loop 2 post:   a = [1, 2, 3, 4, 5], k = 2, l = 1
   Loop 2 pre:    a = [1, 2, 3, 4, 5], k = 2, l = 1
   Loop 2 post:   a = [1, 2, 3, 4, 5], k = 2, l = 2
   After 2 loop:  a = [1, 2, 3, 4, 5], k = 2, l = 2
   Loop 1 post:   a = [1, 2, 3, 4, 5], k = 3
   Loop 1 pre:    a = [1, 2, 3, 4, 5], k = 3
   Before loop 2: a = [1, 2, 3, 4, 5], k = 3, l = 0
   Loop 2 pre:    a = [1, 2, 3, 4, 5], k = 3, l = 0
   Loop 2 post:   a = [1, 2, 3, 4, 5], k = 3, l = 1
   After 2 loop:  a = [1, 2, 3, 4, 5], k = 3, l = 1
   Loop 1 post:   a = [1, 2, 3, 4, 5], k = 4
   After 1 loop:  a = [1, 2, 3, 4, 5], k = 4
   */
   assert(test4(0) <= test4(1) & test4(1) <= test4(2) & test4(2) <= test4(3) & test4(3) <= test4(4))
   ```
   
2. [18 points] Below is a bounded-[queue](https://en.wikipedia.org/wiki/Queue_(abstract_data_type)) 
   shared resource realized using an array, 
   along with a couple of services to add an element to and to take an element from the queue.
   ``MAX`` specifies the ``queue`` bound capacity, and ``numOfElements`` keeps track
   the actual number of elements in the ``queue``.
   Initially, the ``queue`` has no elements.
   It is part of the design intention that all unused ``queue`` slots should be ``0``
   (considered a [good security practice](https://security.stackexchange.com/questions/74280/would-it-be-good-secure-programming-practice-to-overwrite-a-sensitive-variable)
   when applied appropriately).
   The ``add`` procedure stores an element in the first available slot and increases ``numOfElements``. 
   The ``take`` procedure returns the first element of the ``queue``, but before returning the element value, 
   it "shifts" the content of the queue to the left by one (and securely scrub out the stale slot to ``0``), 
   as well updating ``numOfElements`` appropriately.
   
   Your task is to specify global invariants to govern the consistency of the shared resources (involving
   ``MAX``, ``queue``, and ``numOfElements``) and to also specify ``add``'s and ``take``'s contracts
   as well as loop invariants in ``take`` to capture the design intention described above and 
   verify the specified test cases.
     
   ```scala
   import org.sireum.logika._
   
   val MAX: Z = 3
   var queue: ZS = ZS.create(MAX, 0)
   var numOfElements: Z = 0
   
   l"""{ invariant true // FIXME
   }"""
   
   def add(n: Z): Unit = {
     l"""{ requires true // FIXME
           modifies queue, numOfElements
           ensures  true // FIXME
     }"""
   
     println("Add entry:   queue = ", queue, ", numOfElements = ", numOfElements, ", n = ", n)
   
     queue(numOfElements) = n
     numOfElements = numOfElements + 1
   
     println("Add exit:    queue = ", queue, ", numOfElements = ", numOfElements, ", n = ", n)
   }
   
   def take(): Z = {
     l"""{ requires true // FIXME
           modifies queue, numOfElements
           ensures  true // FIXME
     }"""
   
     println("Take entry:  queue = ", queue, ", numOfElements = ", numOfElements)
   
     val r: Z = queue(0)
     var k: Z = 0
   
     println("Before loop: queue = ", queue, ", k = ", k)
   
     while (k < numOfElements - 1) {
       l"""{ invariant true // FIXME
             modifies k, queue }"""
   
       println("Loop pre:    queue = ", queue, ", k = ", k)
   
       queue(k) = queue(k + 1)
       k = k + 1
   
       println("Loop post:   queue = ", queue, ", k = ", k)
     }
   
     println("After loop:  queue = ", queue, ", k = ", k)
   
     numOfElements = numOfElements - 1
     queue(numOfElements) = 0
   
     println("Take exit:   queue = ", queue, ", numOfElements = ", numOfElements, ", r = ", r)
   
     return r
   }
   
   // Verified Tests
   
   def randomN(n: Z): Z = {
     var r: Z = randomInt()
     if (r < 0) {
       r = -r
     }
     return r % n
   }
   
   def test1(): Unit = {
     l"""{ modifies queue, numOfElements }"""
     if (numOfElements == 0) {
       val add1: Z = randomN(10)
       add(add1)
       val take1: Z = take()
       assert(take1 == add1)
     }
   }
   
   def test2(): Unit = {
     l"""{ modifies queue, numOfElements }"""
     if (numOfElements == 0) {
       val add1: Z = randomN(10)
       val add2: Z = randomN(10)
       add(add1)
       add(add2)
       val take1: Z = take()
       val take2: Z = take()
       assert(take1 == add1 & take2 == add2)
     }
   }
   
   def test3(): Unit = {
     l"""{ modifies queue, numOfElements }"""
     if (numOfElements == 0) {
       val add1: Z = randomN(10)
       val add2: Z = randomN(10)
       val add3: Z = randomN(10)
       add(add1)
       add(add2)
       add(add3)
       val take1: Z = take()
       val take2: Z = take()
       val take3: Z = take()
       assert(take1 == add1 & take2 == add2 & take3 == add3)
     }
   }
   
   test1()
   /* Trace log:
   Add entry:   queue = [0, 0, 0], numOfElements = 0, n = 3
   Add exit:    queue = [3, 0, 0], numOfElements = 1, n = 3
   Take entry:  queue = [3, 0, 0], numOfElements = 1
   Before loop: queue = [3, 0, 0], k = 0
   After loop:  queue = [3, 0, 0], k = 0
   Take exit:   queue = [0, 0, 0], numOfElements = 0, r = 3
   */
   
   test2()
   /* Trace log:
   Add entry:   queue = [0, 0, 0], numOfElements = 0, n = 8
   Add exit:    queue = [8, 0, 0], numOfElements = 1, n = 8
   Add entry:   queue = [8, 0, 0], numOfElements = 1, n = 2
   Add exit:    queue = [8, 2, 0], numOfElements = 2, n = 2
   Take entry:  queue = [8, 2, 0], numOfElements = 2
   Before loop: queue = [8, 2, 0], k = 0
   Loop pre:    queue = [8, 2, 0], k = 0
   Loop post:   queue = [2, 2, 0], k = 1
   After loop:  queue = [2, 2, 0], k = 1
   Take exit:   queue = [2, 0, 0], numOfElements = 1, r = 8
   Take entry:  queue = [2, 0, 0], numOfElements = 1
   Before loop: queue = [2, 0, 0], k = 0
   After loop:  queue = [2, 0, 0], k = 0
   Take exit:   queue = [0, 0, 0], numOfElements = 0, r = 2
   */
   
   test3()
   /* Trace log
   Add entry:   queue = [0, 0, 0], numOfElements = 0, n = 4
   Add exit:    queue = [4, 0, 0], numOfElements = 1, n = 4
   Add entry:   queue = [4, 0, 0], numOfElements = 1, n = 1
   Add exit:    queue = [4, 1, 0], numOfElements = 2, n = 1
   Add entry:   queue = [4, 1, 0], numOfElements = 2, n = 4
   Add exit:    queue = [4, 1, 4], numOfElements = 3, n = 4
   Take entry:  queue = [4, 1, 4], numOfElements = 3
   Before loop: queue = [4, 1, 4], k = 0
   Loop pre:    queue = [4, 1, 4], k = 0
   Loop post:   queue = [1, 1, 4], k = 1
   Loop pre:    queue = [1, 1, 4], k = 1
   Loop post:   queue = [1, 4, 4], k = 2
   After loop:  queue = [1, 4, 4], k = 2
   Take exit:   queue = [1, 4, 0], numOfElements = 2, r = 4
   Take entry:  queue = [1, 4, 0], numOfElements = 2
   Before loop: queue = [1, 4, 0], k = 0
   Loop pre:    queue = [1, 4, 0], k = 0
   Loop post:   queue = [4, 4, 0], k = 1
   After loop:  queue = [4, 4, 0], k = 1
   Take exit:   queue = [4, 0, 0], numOfElements = 1, r = 1
   Take entry:  queue = [4, 0, 0], numOfElements = 1
   Before loop: queue = [4, 0, 0], k = 0
   After loop:  queue = [4, 0, 0], k = 0
   Take exit:   queue = [0, 0, 0], numOfElements = 0, r = 4
   */
   ```

3. [15 points] Below is an implementation of a weak substitution cipher -- 
   [ROT5](https://en.wikipedia.org/wiki/ROT13#Variants)
   that uses the ``rotateRight`` function from [Homework 6 #4](../hw6/4.logika).
   Instead of directly implementing ROT5, ``rot5`` calls a more general ``crypt`` 
   procedure that can also be used for implementing, for example, ROT13.
   Given a ``data`` array and integer inputs ``n`` and ``m``,
   ``crypt`` first creates a substitution array ``[0, .., n - 1]`` and
   rotate it to the right by ``m``.   
   It then uses the rotated substitution array to replace any ``data`` element that is
   in between ``0`` and ``n - 1`` (inclusive).
   Thus, ``rot5(data)`` is simply ``crypt(data, 10, 5)``.
   
   Your task is to specify ``crypt``'s and ``rot5``'s contracts and 
   loop invariants in ``crypt`` to verify the provided test cases and the ROT5 
   theorem expressed as the procedure ``rot5Theorem``.

   ```scala
   import org.sireum.logika._
   
   def rotateRight(a: ZS, n: Z): ZS = {
     l"""{ requires true // FIXME
           ensures  true // FIXME
     }"""
   
     var k: Z = 0
     val r: ZS = ZS.create(a.size, 0)
   
     while (k < n) {
       l"""{ invariant true // FIXME
             modifies k, r }"""
   
       r(k) = a(a.size + k - n)
       k = k + 1
     }
   
     while (k < a.size) {
       l"""{ invariant true // FIXME
             modifies k, r
           }"""
   
       r(k) = a(k - n)
       k = k + 1
     }
   
     return r
   }
   
   def initSubstMap(n: Z): ZS = {
     l"""{ requires n ≥ 0
           ensures  ∀i: (0 ..< n) result(i) == i
                    result.size = n }"""
     val r: ZS = ZS.create(n, 0)
   
     var k: Z = 0
     while (k < n) {
       l"""{ invariant 0 ≤ k ∧ k ≤ n
                       ∀i: (0 ..< k) r(i) == i
                       r.size == n
             modifies  k, r }"""
       r(k) = k
       k = k + 1
     }
   
     return r
   }
   
   
   def crypt(data: ZS, n: Z, m: Z): Unit = {
     l"""{ requires true // FIXME
           modifies data
           ensures  true // FIXME
     }"""
   
     val im: ZS = initSubstMap(n)
     val substMap: ZS = rotateRight(im, m)
   
     println("Substitution map: substMap = ", substMap)
   
     var k: Z = 0
   
     println("Before loop: data = ", data, ", k = ", k)
   
     while (k < data.size) {
       l"""{ invariant true // FIXME
             modifies  k, data }"""
   
       println("Loop pre:    data = ", data, ", k = ", k)
   
       val d: Z = data(k)
       if (0 <= d & d < n) {
         data(k) = substMap(data(k))
         l"""{ // hint: the following should be verifiable
               1. data(k) == (n + data_in(k) - m) % n  auto }"""
       }
       k = k + 1
   
       println("Loop post:   data = ", data, ", k = ", k)
     }
   
     println("After loop:  data = ", data, ", k = ", k)
   }
   
   def rot5(data: ZS): Unit = {
     l"""{ modifies data
           ensures  true // FIXME
     }"""
     crypt(data, 10, 5)
   }
   
   // The following ROT5 theorem should be verifiable:
   // Calling rot5 twice does not actually change input data
   // (i.e., the first call encrypts the data, and the second call decrypts it back).
   def rot5Theorem(data: ZS): Unit = {
     l"""{ modifies data
           ensures  data == data_in }"""
     rot5(data) // encrypt
     rot5(data) // decrypt
   }
   
   // The following tests should be verifiable
   
   // Test #1
   val a1: ZS = ZS(0, 1, 2)
   rot5(a1)
   /* Trace log:
   Substitution map: substMap = [5, 6, 7, 8, 9, 0, 1, 2, 3, 4]
   Before loop: data = [0, 1, 2], k = 0
   Loop pre:    data = [0, 1, 2], k = 0
   Loop post:   data = [5, 1, 2], k = 1
   Loop pre:    data = [5, 1, 2], k = 1
   Loop post:   data = [5, 6, 2], k = 2
   Loop pre:    data = [5, 6, 2], k = 2
   Loop post:   data = [5, 6, 7], k = 3
   After loop:  data = [5, 6, 7], k = 3
   */
   assert(a1 == ZS(5, 6, 7))
   rot5(a1)
   /* Trace log:
   Substitution map: substMap = [5, 6, 7, 8, 9, 0, 1, 2, 3, 4]
   Before loop: data = [5, 6, 7], k = 0
   Loop pre:    data = [5, 6, 7], k = 0
   Loop post:   data = [0, 6, 7], k = 1
   Loop pre:    data = [0, 6, 7], k = 1
   Loop post:   data = [0, 1, 7], k = 2
   Loop pre:    data = [0, 1, 7], k = 2
   Loop post:   data = [0, 1, 2], k = 3
   After loop:  data = [0, 1, 2], k = 3
   */
   assert(a1 == ZS(0, 1, 2))
   
   // Test #2
   val a0: ZS = ZS(1, 5, 11, 8)
   rot5(a0)
   /* Trace log:
   Substitution map: substMap = [5, 6, 7, 8, 9, 0, 1, 2, 3, 4]
   Before loop: data = [1, 5, 11, 8], k = 0
   Loop pre:    data = [1, 5, 11, 8], k = 0
   Loop post:   data = [6, 5, 11, 8], k = 1
   Loop pre:    data = [6, 5, 11, 8], k = 1
   Loop post:   data = [6, 0, 11, 8], k = 2
   Loop pre:    data = [6, 0, 11, 8], k = 2
   Loop post:   data = [6, 0, 11, 8], k = 3
   Loop pre:    data = [6, 0, 11, 8], k = 3
   Loop post:   data = [6, 0, 11, 3], k = 4
   After loop:  data = [6, 0, 11, 3], k = 4
   */
   assert(a0 == ZS(6, 0, 11, 3))
   rot5(a0)
   /* Trace log:
   Substitution map: substMap = [5, 6, 7, 8, 9, 0, 1, 2, 3, 4]
   Before loop: data = [6, 0, 11, 3], k = 0
   Loop pre:    data = [6, 0, 11, 3], k = 0
   Loop post:   data = [1, 0, 11, 3], k = 1
   Loop pre:    data = [1, 0, 11, 3], k = 1
   Loop post:   data = [1, 5, 11, 3], k = 2
   Loop pre:    data = [1, 5, 11, 3], k = 2
   Loop post:   data = [1, 5, 11, 3], k = 3
   Loop pre:    data = [1, 5, 11, 3], k = 3
   Loop post:   data = [1, 5, 11, 8], k = 4
   After loop:  data = [1, 5, 11, 8], k = 4
   */
   assert(a0 == ZS(1, 5, 11, 8))
   ```
        
### Bonus Problem
   
4. [30 points] Below is an optimized [fibonacci](https://en.wikipedia.org/wiki/Fibonacci_number) 
   implementation that globally ``cache`` computed results to speed up subsequent execution time 
   but sacrificing memory ([memoization](https://en.wikipedia.org/wiki/Memoization)).
   The cache value ``-1`` is used to indicate that the ``cache`` has not been initialized for a particular 
   ``fibonacci`` input value.
   The ``cache`` is dynamically expanded on-demand by ``ensureCacheCapacity``. 
   The behavior of the memoized recursive ``fibonacci`` procedure is defined by ``Fib`` using a 
   recurrence relation, as typically done in mathematics.
   
   Your tasks are to:
    
   * [20 points] verify that the optimized ``fibonacci`` realized the mathematical ``Fib`` by 
     specifying the necessary consistency property of ``cache`` as a global invariant, as well as describing how 
     ``ensureCacheCapacity`` and ``fibonacci`` update and make use the ``cache`` appropriately by formalizing
     their contracts and loop invariants.
   
   * [10 points] prove that ``ensureCacheCapacity`` and ``fibonacci`` always terminate.
   
   ```scala
   import org.sireum.logika._
   
   l"""{ fact
           def Fib(m: Z): Z
             FZero.      Fib(0) == 0
             FOne.       Fib(1) == 1
             FTwoOrMore. ∀m: Z m > 1 → Fib(m) = Fib(m - 1) + Fib(m - 2) }"""
   
   var cache: ZS = ZS(0, 1)
   
   l"""{ invariant true // FIXME
   }"""
   
   def ensureCacheCapacity(m: Z): Unit = {
     l"""{ modifies cache
           ensures  true // FIXME
     }"""
   
     if (cache.size < m) {
   
       println("Expanding cache...")
   
       val newCache: ZS = ZS.create(m * 3 / 2, -1)
       var k: Z = 0
   
       println("Before loop: cache = ", cache, ", newCache = ", newCache, ", k = ", k)
   
       while (k < cache.size) {
         l"""{ invariant true // FIXME
               modifies  k, newCache }"""
   
         println("Loop pre:    cache = ", cache, ", newCache = ", newCache, ", k = ", k)
   
         newCache(k) = cache(k)
         k = k + 1
   
         println("Loop post:   cache = ", cache, ", newCache = ", newCache, ", k = ", k)
       }
   
       println("After loop:  cache = ", cache, ", newCache = ", newCache, ", k = ", k)
   
       cache = newCache.clone
   
       println("Cache expanded!")
     }
   }
   
   def fibonacci(n: Z): Z = {
     l"""{ requires true // FIXME
           modifies cache
           ensures  true // FIXME
     }"""
   
     println("Entry:       n = ", n, ", cache = ", cache)
   
     var r: Z = n
   
     if (n < 2) {
       return r
     }
   
     ensureCacheCapacity(n + 1)
   
     r = cache(n)
     if (r == -1) {
       val f1: Z = fibonacci(n - 1)
       val f2: Z = fibonacci(n - 2)
       r = f1 + f2
       cache(n) = r
       println("Cache updated! cache(", n, ") = ", r)
     } else {
       println("Cache hit! cache(", n, ") = ", r)
     }
   
     println("Exit:        n = ", n, ", cache = ", cache, ", r = ", r)
     return r
   }
   
   // Verified Tests
   
   val test1: Z = fibonacci(4)
   /* Trace log:
   Entry:       n = 4, cache = [0, 1]
   Expanding cache...
   Before loop: cache = [0, 1], newCache = [-1, -1, -1, -1, -1, -1, -1], k = 0
   Loop pre:    cache = [0, 1], newCache = [-1, -1, -1, -1, -1, -1, -1], k = 0
   Loop post:   cache = [0, 1], newCache = [0, -1, -1, -1, -1, -1, -1], k = 1
   Loop pre:    cache = [0, 1], newCache = [0, -1, -1, -1, -1, -1, -1], k = 1
   Loop post:   cache = [0, 1], newCache = [0, 1, -1, -1, -1, -1, -1], k = 2
   After loop:  cache = [0, 1], newCache = [0, 1, -1, -1, -1, -1, -1], k = 2
   Cache expanded!
   Entry:       n = 3, cache = [0, 1, -1, -1, -1, -1, -1]
   Entry:       n = 2, cache = [0, 1, -1, -1, -1, -1, -1]
   Entry:       n = 1, cache = [0, 1, -1, -1, -1, -1, -1]
   Cache hit! cache(1) = 1
   Exit:        n = 1, cache = [0, 1, -1, -1, -1, -1, -1], r = 1
   Entry:       n = 0, cache = [0, 1, -1, -1, -1, -1, -1]
   Cache hit! cache(0) = 0
   Exit:        n = 0, cache = [0, 1, -1, -1, -1, -1, -1], r = 0
   Cache updated! cache(2) = 1
   Exit:        n = 2, cache = [0, 1, 1, -1, -1, -1, -1], r = 1
   Entry:       n = 1, cache = [0, 1, 1, -1, -1, -1, -1]
   Cache hit! cache(1) = 1
   Exit:        n = 1, cache = [0, 1, 1, -1, -1, -1, -1], r = 1
   Cache updated! cache(3) = 2
   Exit:        n = 3, cache = [0, 1, 1, 2, -1, -1, -1], r = 2
   Entry:       n = 2, cache = [0, 1, 1, 2, -1, -1, -1]
   Cache hit! cache(2) = 1
   Exit:        n = 2, cache = [0, 1, 1, 2, -1, -1, -1], r = 1
   Cache updated! cache(4) = 3
   Exit:        n = 4, cache = [0, 1, 1, 2, 3, -1, -1], r = 3
   */
   assert(test1 == 3)
   
   val test2: Z = fibonacci(9)
   /* Trace log:
   Entry:       n = 9, cache = [0, 1, 1, 2, 3, -1, -1]
   Expanding cache...
   Before loop: cache = [0, 1, 1, 2, 3, -1, -1], newCache = [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1], k = 0
   Loop pre:    cache = [0, 1, 1, 2, 3, -1, -1], newCache = [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1], k = 0
   Loop post:   cache = [0, 1, 1, 2, 3, -1, -1], newCache = [0, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1], k = 1
   Loop pre:    cache = [0, 1, 1, 2, 3, -1, -1], newCache = [0, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1], k = 1
   Loop post:   cache = [0, 1, 1, 2, 3, -1, -1], newCache = [0, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1], k = 2
   Loop pre:    cache = [0, 1, 1, 2, 3, -1, -1], newCache = [0, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1], k = 2
   Loop post:   cache = [0, 1, 1, 2, 3, -1, -1], newCache = [0, 1, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1], k = 3
   Loop pre:    cache = [0, 1, 1, 2, 3, -1, -1], newCache = [0, 1, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1], k = 3
   Loop post:   cache = [0, 1, 1, 2, 3, -1, -1], newCache = [0, 1, 1, 2, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1], k = 4
   Loop pre:    cache = [0, 1, 1, 2, 3, -1, -1], newCache = [0, 1, 1, 2, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1], k = 4
   Loop post:   cache = [0, 1, 1, 2, 3, -1, -1], newCache = [0, 1, 1, 2, 3, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1], k = 5
   Loop pre:    cache = [0, 1, 1, 2, 3, -1, -1], newCache = [0, 1, 1, 2, 3, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1], k = 5
   Loop post:   cache = [0, 1, 1, 2, 3, -1, -1], newCache = [0, 1, 1, 2, 3, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1], k = 6
   Loop pre:    cache = [0, 1, 1, 2, 3, -1, -1], newCache = [0, 1, 1, 2, 3, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1], k = 6
   Loop post:   cache = [0, 1, 1, 2, 3, -1, -1], newCache = [0, 1, 1, 2, 3, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1], k = 7
   After loop:  cache = [0, 1, 1, 2, 3, -1, -1], newCache = [0, 1, 1, 2, 3, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1], k = 7
   Cache expanded!
   Entry:       n = 8, cache = [0, 1, 1, 2, 3, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]
   Entry:       n = 7, cache = [0, 1, 1, 2, 3, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]
   Entry:       n = 6, cache = [0, 1, 1, 2, 3, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]
   Entry:       n = 5, cache = [0, 1, 1, 2, 3, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]
   Entry:       n = 4, cache = [0, 1, 1, 2, 3, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]
   Cache hit! cache(4) = 3
   Exit:        n = 4, cache = [0, 1, 1, 2, 3, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1], r = 3
   Entry:       n = 3, cache = [0, 1, 1, 2, 3, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]
   Cache hit! cache(3) = 2
   Exit:        n = 3, cache = [0, 1, 1, 2, 3, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1], r = 2
   Cache updated! cache(5) = 5
   Exit:        n = 5, cache = [0, 1, 1, 2, 3, 5, -1, -1, -1, -1, -1, -1, -1, -1, -1], r = 5
   Entry:       n = 4, cache = [0, 1, 1, 2, 3, 5, -1, -1, -1, -1, -1, -1, -1, -1, -1]
   Cache hit! cache(4) = 3
   Exit:        n = 4, cache = [0, 1, 1, 2, 3, 5, -1, -1, -1, -1, -1, -1, -1, -1, -1], r = 3
   Cache updated! cache(6) = 8
   Exit:        n = 6, cache = [0, 1, 1, 2, 3, 5, 8, -1, -1, -1, -1, -1, -1, -1, -1], r = 8
   Entry:       n = 5, cache = [0, 1, 1, 2, 3, 5, 8, -1, -1, -1, -1, -1, -1, -1, -1]
   Cache hit! cache(5) = 5
   Exit:        n = 5, cache = [0, 1, 1, 2, 3, 5, 8, -1, -1, -1, -1, -1, -1, -1, -1], r = 5
   Cache updated! cache(7) = 13
   Exit:        n = 7, cache = [0, 1, 1, 2, 3, 5, 8, 13, -1, -1, -1, -1, -1, -1, -1], r = 13
   Entry:       n = 6, cache = [0, 1, 1, 2, 3, 5, 8, 13, -1, -1, -1, -1, -1, -1, -1]
   Cache hit! cache(6) = 8
   Exit:        n = 6, cache = [0, 1, 1, 2, 3, 5, 8, 13, -1, -1, -1, -1, -1, -1, -1], r = 8
   Cache updated! cache(8) = 21
   Exit:        n = 8, cache = [0, 1, 1, 2, 3, 5, 8, 13, 21, -1, -1, -1, -1, -1, -1], r = 21
   Entry:       n = 7, cache = [0, 1, 1, 2, 3, 5, 8, 13, 21, -1, -1, -1, -1, -1, -1]
   Cache hit! cache(7) = 13
   Exit:        n = 7, cache = [0, 1, 1, 2, 3, 5, 8, 13, 21, -1, -1, -1, -1, -1, -1], r = 13
   Cache updated! cache(9) = 34
   Exit:        n = 9, cache = [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, -1, -1, -1, -1, -1], r = 34
   */
   assert(test2 == 34)
   
   val test3: Z = fibonacci(7)
   /* Trace log:
   Entry:       n = 7, cache = [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, -1, -1, -1, -1, -1]
   Cache hit! cache(7) = 13
   Exit:        n = 7, cache = [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, -1, -1, -1, -1, -1], r = 13
   */
   assert(test3 == 13)
   ```
