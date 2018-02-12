# Homework 6, K-State CIS 301, Fall 2016

* **Deadline:** Friday, November 17, 2017, 11:59pm US Central 

* **Total Points:** 48 points (**+ 8 bonus points**)

## Assignment Purpose 

- To further help you to understand how to formalize English program requirements using logic.

- To further help you to understand how to come up with loop invariants. 

- To help you understand how to verify programs automatically.

## Notes

- All Homework 6 problems require Logika solutions;
  thus, per our convention, use the file extension ``.logika``
  for your solutions.
  
- Open ``SBT`` tool window (on the right side of IDE) and press refresh button to re-sync Sbt.

  ![sbt-refresh.png](sbt-refresh.png)

  If you get the following error when syncing Sbt:
  
  ```
  Error:Error while importing SBT project:<br/>...<br/><pre>at sbt.MainLoop$$anonfun$runWithNewLog$1.apply(MainLoop.scala:68)
  at sbt.MainLoop$$anonfun$runWithNewLog$1.apply(MainLoop.scala:63)
  at sbt.Using.apply(Using.scala:24)
  at sbt.MainLoop$.runWithNewLog(MainLoop.scala:63)
  at sbt.MainLoop$.runAndClearLast(MainLoop.scala:46)
  at sbt.MainLoop$.runLoggedLoop(MainLoop.scala:30)
  at sbt.MainLoop$.runLogged(MainLoop.scala:22)
  at sbt.StandardMain$.runManaged(Main.scala:61)
  at sbt.xMain.run(Main.scala:35)
  at xsbt.boot.Launch$$anonfun$run$1.apply(Launch.scala:109)
  at xsbt.boot.Launch$.withContextLoader(Launch.scala:128)
  at xsbt.boot.Launch$.run(Launch.scala:109)
  at xsbt.boot.Launch$$anonfun$apply$1.apply(Launch.scala:35)
  at xsbt.boot.Launch$.launch(Launch.scala:117)
  at xsbt.boot.Launch$.apply(Launch.scala:18)
  at xsbt.boot.Boot$.runImpl(Boot.scala:41)
  at xsbt.boot.Boot$.main(Boot.scala:17)
  at xsbt.boot.Boot.main(Boot.scala)
  [error] Some keys were defined with the same name but different types: 'ssExtractBuild' (sbt.Task[org.jetbrains.sbt.structure.BuildData], sbt.Task[org.jetbrains.sbt.structure.BuildData]), 'settingData' (sbt.Task[scala.collection.Seq[org.jetbrains.sbt.structure.SettingData]], sbt.Task[scala.collection.Seq[org.jetbrains.sbt.structure.SettingData]]), 'taskData' (sbt.Task[scala.collection.Seq[org.jetbrains.sbt.structure.TaskData]], sbt.Task[scala.collection.Seq[org.jetbrains.sbt.structure.TaskData]]), 'extractStructure' (sbt.Task[org.jetbrains.sbt.structure.StructureData], sbt.Task[org.jetbrains.sbt.structure.StructureData]), 'ssExtractDependencies' (sbt.Task[org.jetbrains.sbt.structure.DependencyData], sbt.Task[org.jetbrains.sbt.structure.DependencyData]), 'ssExtractProjects' (sbt.Task[scala.collection.Seq[org.jetbrains.sbt.structure.ProjectData]], sbt.Task[scala.collection.Seq[org.jetbrains.sbt.structure.ProjectData]]), 'ssExtractAndroid' (sbt.Task[scala.Option[org.jetbrains.sbt.structure.AndroidData]], sbt.Task[scala.Option[org.jetbrains.sbt.structure.AndroidData]]), 'ssExtractRepository' (sbt.Task[scala.Option[org.jetbrains.sbt.structure.RepositoryData]], sbt.Task[scala.Option[org.jetbrains.sbt.structure.RepositoryData]]), 'ssOptions' (org.jetbrains.sbt.Options, org.jetbrains.sbt.Options), 'commandData' (sbt.Task[scala.collection.Seq[org.jetbrains.sbt.structure.CommandData]], sbt.Task[scala.collection.Seq[org.jetbrains.sbt.structure.CommandData]]), 'ssExtractProject' (sbt.Task[scala.collection.Seq[org.jetbrains.sbt.structure.ProjectData]], sbt.Task[scala.collection.Seq[org.jetbrains.sbt.structure.ProjectData]]), 'ssExtractPlay2' (sbt.Task[scala.Option[org.jetbrains.sbt.structure.Play2Data]], sbt.Task[scala.Option[org.jetbrains.sbt.structure.Play2Data]])
  [error] Use 'last' for the full log.</pre><br/>See complete log in <a href=".../sbt.last.log">.../sbt.last.log</a>
  ```  
  
  You encountered a [bug in sbt/IntelliJ](https://youtrack.jetbrains.com/issue/SCL-12372).
  
  To fix this, delete the local directory ``301f17-<eid>/project/target`` and re-sync Sbt
  per instruction above.
  
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

* **Important:** Avoid identifier name clash between program variables and quantified variables.

## Problem Descriptions

1. [10 points] Below is a function that determines whether an integer sequence is a 
   [palindrome](https://en.wikipedia.org/wiki/Palindrome).
   
   ```scala
   import org.sireum.logika._
   
   def isPalindrome(a: ZS): B = {
     l"""{ ensures ??? // FIXME
     }"""
   
     var j: Z = 0
     var r: B = true
   
     println("Before loop: a = ", a, ", j = ", j, ", r = ", r)
   
     while (j < a.size / 2) {
       l"""{ invariant ??? // FIXME
             modifies  j, r }"""
   
       println("Loop pre:    a = ", a, ", j = ", j, ", r = ", r)
   
       if (a(j) != a(a.size - j - 1)) {
         r = false
       }
       j = j + 1
   
       println("Loop post:   a = ", a, ", j = ", j, ", r = ", r)
     }
   
     println("After loop:  a = ", a, ", j = ", j, ", r = ", r)
   
     return r
   }
   ```
   
   Your tasks are to:
   
   a. Formalize the post-condition:
   
      * ``result`` is true if and only if the array is a palindrome.
      
      You can use equality (``==``) for expressing "if and only if", but make sure that 
      you parenthesized the claim expressions appropriately.
      
   b. Verify the code by first adding the necessary loop invariants to prove the post-condition.
   
   To help you think about the loop invariants, below are example trace logs of the program:
   
   * Example trace for ``isPalindrome(ZS(1, 1))``:
   
     ```
     Before loop: a = [1, 1], j = 0, r = true
     Loop pre:    a = [1, 1], j = 0, r = true
     Loop post:   a = [1, 1], j = 1, r = true
     After loop:  a = [1, 1], j = 1, r = true
     ```
   
   * Example trace for ``isPalindrome(ZS(1, 2, 1))``:
   
     ```
     Before loop: a = [1, 2, 1], j = 0, r = true
     Loop pre:    a = [1, 2, 1], j = 0, r = true
     Loop post:   a = [1, 2, 1], j = 1, r = true
     After loop:  a = [1, 2, 1], j = 1, r = true
     ```
   
   * Example trace for ``isPalindrome(ZS(9, 8, 7, 9))``:
   
     ```
     Before loop: a = [9, 8, 7, 9], j = 0, r = true
     Loop pre:    a = [9, 8, 7, 9], j = 0, r = true
     Loop post:   a = [9, 8, 7, 9], j = 1, r = true
     Loop pre:    a = [9, 8, 7, 9], j = 1, r = true
     Loop post:   a = [9, 8, 7, 9], j = 2, r = false
     After loop:  a = [9, 8, 7, 9], j = 2, r = false
     ```
   
   * Example trace for ``isPalindrome(ZS(3, 4, 5, 4, 3))``:
   
     ```
     Before loop: a = [3, 4, 5, 4, 3], j = 0, r = true
     Loop pre:    a = [3, 4, 5, 4, 3], j = 0, r = true
     Loop post:   a = [3, 4, 5, 4, 3], j = 1, r = true
     Loop pre:    a = [3, 4, 5, 4, 3], j = 1, r = true
     Loop post:   a = [3, 4, 5, 4, 3], j = 2, r = true
     After loop:  a = [3, 4, 5, 4, 3], j = 2, r = true
     ```
     
2. [10 points with **8 bonus points**] Below is a function that implements 
   an integer set member addition, where the set is realized using an integer sequence.
   
   ```scala
   import org.sireum.logika._
   
   def add(set: ZS, element: Z): ZS = {
     l"""{ requires ??? // FIXME
           ensures  ??? // FIXME
     }"""
     var k: Z = 0
   
     println("Before loop: set = ", set, ", k = ", k)
   
     while (k < set.size) {
       l"""{ invariant ??? // FIXME
             modifies  k }"""
   
       println("Loop pre:    set = ", set, ", k = ", k)
   
       if (set(k) == element) {
         val r: ZS = set.clone
         return r
       }
       k = k + 1
   
       println("Loop post:   set = ", set, ", k = ", k)
   
     }
   
     println("After loop:  set = ", set, ", k = ", k)
   
     return set :+ element
   }
   ```
   
   Your tasks are to:
      
   a. Formalize the pre-/post-conditions:
   
      * all elements of ``set`` should be unique (pre-condition).
      
      * all elements of the ``result``-ing sequence should be unique (post-condition).
      
      * (bonus) all elements in ``set`` should be in the ``result``-ing sequence (post-condition).
      
      * (bonus) all elements in the ``result``-ing sequence should either be ``element`` or in ``set`` (post-condition). 
                  
   b. Verify the code by first adding the necessary loop invariants to prove the post-conditions.
   
   To help you think about the loop invariants, below are example trace logs of the program:
   
   * Example trace for ``add(ZS(1, 2, 3), 4)``:
   
     ```
     Before loop: set = [1, 2, 3], k = 0
     Loop pre:    set = [1, 2, 3], k = 0
     Loop post:   set = [1, 2, 3], k = 1
     Loop pre:    set = [1, 2, 3], k = 1
     Loop post:   set = [1, 2, 3], k = 2
     Loop pre:    set = [1, 2, 3], k = 2
     Loop post:   set = [1, 2, 3], k = 3
     After loop:  set = [1, 2, 3], k = 3
     ```
   
   * Example trace for ``add(ZS(1, 2, 3), 2)``:
   
     ```
     Before loop: set = [1, 2, 3], k = 0
     Loop pre:    set = [1, 2, 3], k = 0
     Loop post:   set = [1, 2, 3], k = 1
     Loop pre:    set = [1, 2, 3], k = 1
     ```
   
   * Example trace for ``add(ZS(1, 2, 3, 4), 0)``:
   
     ```
     Before loop: set = [1, 2, 3, 4], k = 0
     Loop pre:    set = [1, 2, 3, 4], k = 0
     Loop post:   set = [1, 2, 3, 4], k = 1
     Loop pre:    set = [1, 2, 3, 4], k = 1
     Loop post:   set = [1, 2, 3, 4], k = 2
     Loop pre:    set = [1, 2, 3, 4], k = 2
     Loop post:   set = [1, 2, 3, 4], k = 3
     Loop pre:    set = [1, 2, 3, 4], k = 3
     Loop post:   set = [1, 2, 3, 4], k = 4
     After loop:  set = [1, 2, 3, 4], k = 4
     ```
   
   * Example trace for ``add(ZS(1, 2, 3, 4), 4)``:
   
     ```
     Before loop: set = [1, 2, 3, 4], k = 0
     Loop pre:    set = [1, 2, 3, 4], k = 0
     Loop post:   set = [1, 2, 3, 4], k = 1
     Loop pre:    set = [1, 2, 3, 4], k = 1
     Loop post:   set = [1, 2, 3, 4], k = 2
     Loop pre:    set = [1, 2, 3, 4], k = 2
     Loop post:   set = [1, 2, 3, 4], k = 3
     Loop pre:    set = [1, 2, 3, 4], k = 3
     ```

3. [14 points] Below is a procedure that reverses all elements of an input integer sequence in place.
   
   ```scala
   import org.sireum.logika._
   
   def reverse(a: ZS): Unit = {
     l"""{ modifies a
           ensures  ??? // FIXME
     }"""
     var j: Z = 0
   
     println("Before loop: a = ", a, ", j = ", j)
   
     while (j < a.size / 2) {
       l"""{ invariant ??? // FIXME
             modifies  j, a }"""
   
       println("Loop pre:    a = ", a, ", j = ", j)
   
       val t: Z = a(j)
       a(j) = a(a.size - j - 1)
       a(a.size - j - 1) = t
       j = j + 1
   
       println("Loop post:   a = ", a, ", j = ", j)
     }
   
     println("After loop:  a = ", a, ", j = ", j)
   }
   ```
   
   Your tasks are to:
   
   a. Formalize the post-condition:
   
      * the ``result``-ing sequence is a reversed sequence of ``a``.
      
   b. Verify the code by first adding the necessary loop invariants to prove the post-condition.
   
   To help you think about the loop invariants, below are example trace logs of the program:
   
   * Example trace for ``reverse(ZS(1, 2, 3))``:
   
     ```
     Before loop: a = [1, 2, 3], j = 0
     Loop pre:    a = [1, 2, 3], j = 0
     Loop post:   a = [3, 2, 1], j = 1
     After loop:  a = [3, 2, 1], j = 1
     ```
   
   * Example trace for ``reverse(ZS(1, 2, 3, 4))``:
   
     ```
     Before loop: a = [1, 2, 3, 4], j = 0
     Loop pre:    a = [1, 2, 3, 4], j = 0
     Loop post:   a = [4, 2, 3, 1], j = 1
     Loop pre:    a = [4, 2, 3, 1], j = 1
     Loop post:   a = [4, 3, 2, 1], j = 2
     After loop:  a = [4, 3, 2, 1], j = 2
     ```
   
   * Example trace for ``reverse(ZS(1, 2, 3, 2, 1))``:
   
     ```
     Before loop: a = [1, 2, 3, 2, 1], j = 0
     Loop pre:    a = [1, 2, 3, 2, 1], j = 0
     Loop post:   a = [1, 2, 3, 2, 1], j = 1
     Loop pre:    a = [1, 2, 3, 2, 1], j = 1
     Loop post:   a = [1, 2, 3, 2, 1], j = 2
     After loop:  a = [1, 2, 3, 2, 1], j = 2
     ```
   
   * Example trace for ``reverse(ZS(0, 1, 2, 3, 4, 5, 6, 7, 8, 9))``:
   
     ```
     Before loop: a = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], j = 0
     Loop pre:    a = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], j = 0
     Loop post:   a = [9, 1, 2, 3, 4, 5, 6, 7, 8, 0], j = 1
     Loop pre:    a = [9, 1, 2, 3, 4, 5, 6, 7, 8, 0], j = 1
     Loop post:   a = [9, 8, 2, 3, 4, 5, 6, 7, 1, 0], j = 2
     Loop pre:    a = [9, 8, 2, 3, 4, 5, 6, 7, 1, 0], j = 2
     Loop post:   a = [9, 8, 7, 3, 4, 5, 6, 2, 1, 0], j = 3
     Loop pre:    a = [9, 8, 7, 3, 4, 5, 6, 2, 1, 0], j = 3
     Loop post:   a = [9, 8, 7, 6, 4, 5, 3, 2, 1, 0], j = 4
     Loop pre:    a = [9, 8, 7, 6, 4, 5, 3, 2, 1, 0], j = 4
     Loop post:   a = [9, 8, 7, 6, 5, 4, 3, 2, 1, 0], j = 5
     After loop:  a = [9, 8, 7, 6, 5, 4, 3, 2, 1, 0], j = 5
     ```

4. [14 points] Below is a function that rotate an input sequence ``a`` to the right 
   by ``n`` steps (see [circular shift](https://en.wikipedia.org/wiki/Circular_shift)
   and example traces below). 
   
   ```scala
   import org.sireum.logika._
   
   def rotateRight(a: ZS, n: Z): ZS = {
     l"""{ requires ??? // FIXME
           ensures  ??? // FIXME
     }"""
   
     var k: Z = 0
     var r: ZS = ZS.create(a.size, 0)
   
     println("Before loop 1: a = ", a, ", n = ", n, ", k = ", k, ", r = ", r)
   
     while (k < n) {
       l"""{ invariant ??? // FIXME
             modifies k, r }"""
   
       println("Loop 1 pre:    a = ", a, ", n = ", n, ", k = ", k, ", r = ", r)
   
       r(k) = a(a.size + k - n)
       k = k + 1
   
       println("Loop 1 post:   a = ", a, ", n = ", n, ", k = ", k, ", r = ", r)
     }
   
     println("After loop 1:  a = ", a, ", n = ", n, ", k = ", k, ", r = ", r, " (Before loop 2)")
   
     while (k < a.size) {
       l"""{ invariant ??? // FIXME
             modifies k, r
           }"""
   
       println("Loop 2 pre:    a = ", a, ", n = ", n, ", k = ", k, ", r = ", r)
   
       r(k) = a(k - n)
       k = k + 1
   
       println("Loop 2 post:   a = ", a, ", n = ", n, ", k = ", k, ", r = ", r)
     }
   
     println("After loop 2:  a = ", a, ", n = ", n, ", k = ", k, ", r = ", r)
   
     return r
   }
   ```
   
   Your tasks are to:
      
   a. Formalize the pre-/post-conditions:
   
      * ``n`` should be at least 0 (pre-condition).
      
      * ``n`` cannot be greater than ``a``'s size (pre-condition).
      
      * the ``result``-ing sequence is ``a`` rotated right by ``n`` steps (post-condition). 
                  
   b. Verify the code by first adding the necessary loop invariants to prove the post-conditions.
   
   To help you think about the loop invariants, below are example trace logs of the program:

   * Example trace for ``rotateRight(ZS(1, 2, 3), 1)``:
   
     ```
     Before loop 1: a = [1, 2, 3], n = 1, k = 0, r = [0, 0, 0]
     Loop 1 pre:    a = [1, 2, 3], n = 1, k = 0, r = [0, 0, 0]
     Loop 1 post:   a = [1, 2, 3], n = 1, k = 1, r = [3, 0, 0]
     After loop 1:  a = [1, 2, 3], n = 1, k = 1, r = [3, 0, 0] (Before loop 2)
     Loop 2 pre:    a = [1, 2, 3], n = 1, k = 1, r = [3, 0, 0]
     Loop 2 post:   a = [1, 2, 3], n = 1, k = 2, r = [3, 1, 0]
     Loop 2 pre:    a = [1, 2, 3], n = 1, k = 2, r = [3, 1, 0]
     Loop 2 post:   a = [1, 2, 3], n = 1, k = 3, r = [3, 1, 2]
     After loop 2:  a = [1, 2, 3], n = 1, k = 3, r = [3, 1, 2]
     ```
   
   * Example trace for ``rotateRight(ZS(1, 2, 3), 2)``:
   
     ```
     Before loop 1: a = [1, 2, 3], n = 2, k = 0, r = [0, 0, 0]
     Loop 1 pre:    a = [1, 2, 3], n = 2, k = 0, r = [0, 0, 0]
     Loop 1 post:   a = [1, 2, 3], n = 2, k = 1, r = [2, 0, 0]
     Loop 1 pre:    a = [1, 2, 3], n = 2, k = 1, r = [2, 0, 0]
     Loop 1 post:   a = [1, 2, 3], n = 2, k = 2, r = [2, 3, 0]
     After loop 1:  a = [1, 2, 3], n = 2, k = 2, r = [2, 3, 0] (Before loop 2)
     Loop 2 pre:    a = [1, 2, 3], n = 2, k = 2, r = [2, 3, 0]
     Loop 2 post:   a = [1, 2, 3], n = 2, k = 3, r = [2, 3, 1]
     After loop 2:  a = [1, 2, 3], n = 2, k = 3, r = [2, 3, 1]
     ```
   
   * Example trace for ``rotateRight(ZS(1, 2, 3, 4, 5), 3)``:
   
     ```
     Before loop 1: a = [1, 2, 3, 4, 5], n = 3, k = 0, r = [0, 0, 0, 0, 0]
     Loop 1 pre:    a = [1, 2, 3, 4, 5], n = 3, k = 0, r = [0, 0, 0, 0, 0]
     Loop 1 post:   a = [1, 2, 3, 4, 5], n = 3, k = 1, r = [3, 0, 0, 0, 0]
     Loop 1 pre:    a = [1, 2, 3, 4, 5], n = 3, k = 1, r = [3, 0, 0, 0, 0]
     Loop 1 post:   a = [1, 2, 3, 4, 5], n = 3, k = 2, r = [3, 4, 0, 0, 0]
     Loop 1 pre:    a = [1, 2, 3, 4, 5], n = 3, k = 2, r = [3, 4, 0, 0, 0]
     Loop 1 post:   a = [1, 2, 3, 4, 5], n = 3, k = 3, r = [3, 4, 5, 0, 0]
     After loop 1:  a = [1, 2, 3, 4, 5], n = 3, k = 3, r = [3, 4, 5, 0, 0] (Before loop 2)
     Loop 2 pre:    a = [1, 2, 3, 4, 5], n = 3, k = 3, r = [3, 4, 5, 0, 0]
     Loop 2 post:   a = [1, 2, 3, 4, 5], n = 3, k = 4, r = [3, 4, 5, 1, 0]
     Loop 2 pre:    a = [1, 2, 3, 4, 5], n = 3, k = 4, r = [3, 4, 5, 1, 0]
     Loop 2 post:   a = [1, 2, 3, 4, 5], n = 3, k = 5, r = [3, 4, 5, 1, 2]
     After loop 2:  a = [1, 2, 3, 4, 5], n = 3, k = 5, r = [3, 4, 5, 1, 2]
     ```
   
   * Example trace for ``rotateRight(ZS(0, 1, 2, 3, 4, 5, 6, 7, 8, 9), 5)``:
   
     ```
     Before loop 1: a = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], n = 5, k = 0, r = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
     Loop 1 pre:    a = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], n = 5, k = 0, r = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
     Loop 1 post:   a = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], n = 5, k = 1, r = [5, 0, 0, 0, 0, 0, 0, 0, 0, 0]
     Loop 1 pre:    a = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], n = 5, k = 1, r = [5, 0, 0, 0, 0, 0, 0, 0, 0, 0]
     Loop 1 post:   a = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], n = 5, k = 2, r = [5, 6, 0, 0, 0, 0, 0, 0, 0, 0]
     Loop 1 pre:    a = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], n = 5, k = 2, r = [5, 6, 0, 0, 0, 0, 0, 0, 0, 0]
     Loop 1 post:   a = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], n = 5, k = 3, r = [5, 6, 7, 0, 0, 0, 0, 0, 0, 0]
     Loop 1 pre:    a = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], n = 5, k = 3, r = [5, 6, 7, 0, 0, 0, 0, 0, 0, 0]
     Loop 1 post:   a = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], n = 5, k = 4, r = [5, 6, 7, 8, 0, 0, 0, 0, 0, 0]
     Loop 1 pre:    a = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], n = 5, k = 4, r = [5, 6, 7, 8, 0, 0, 0, 0, 0, 0]
     Loop 1 post:   a = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], n = 5, k = 5, r = [5, 6, 7, 8, 9, 0, 0, 0, 0, 0]
     After loop 1:  a = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], n = 5, k = 5, r = [5, 6, 7, 8, 9, 0, 0, 0, 0, 0] (Before loop 2)
     Loop 2 pre:    a = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], n = 5, k = 5, r = [5, 6, 7, 8, 9, 0, 0, 0, 0, 0]
     Loop 2 post:   a = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], n = 5, k = 6, r = [5, 6, 7, 8, 9, 0, 0, 0, 0, 0]
     Loop 2 pre:    a = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], n = 5, k = 6, r = [5, 6, 7, 8, 9, 0, 0, 0, 0, 0]
     Loop 2 post:   a = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], n = 5, k = 7, r = [5, 6, 7, 8, 9, 0, 1, 0, 0, 0]
     Loop 2 pre:    a = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], n = 5, k = 7, r = [5, 6, 7, 8, 9, 0, 1, 0, 0, 0]
     Loop 2 post:   a = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], n = 5, k = 8, r = [5, 6, 7, 8, 9, 0, 1, 2, 0, 0]
     Loop 2 pre:    a = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], n = 5, k = 8, r = [5, 6, 7, 8, 9, 0, 1, 2, 0, 0]
     Loop 2 post:   a = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], n = 5, k = 9, r = [5, 6, 7, 8, 9, 0, 1, 2, 3, 0]
     Loop 2 pre:    a = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], n = 5, k = 9, r = [5, 6, 7, 8, 9, 0, 1, 2, 3, 0]
     Loop 2 post:   a = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], n = 5, k = 10, r = [5, 6, 7, 8, 9, 0, 1, 2, 3, 4]
     After loop 2:  a = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], n = 5, k = 10, r = [5, 6, 7, 8, 9, 0, 1, 2, 3, 4]
     ```
