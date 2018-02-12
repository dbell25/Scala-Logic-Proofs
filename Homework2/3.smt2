(declare-const p Bool)
(declare-const q Bool)
(declare-const r Bool)
(declare-const s Bool)
(declare-const t Bool)

(assert (or(=> (and p (not q))r)(=> (and p (not q))s)))
(assert(=> s t))
(assert (=>(and(not r)(not s)p)q))
(check-sat)
(get-model)
;The above requirements are satisfiabale

(assert (and p(not q)(not t)))
(check-sat)
(get-model)
 ;it is possible
 
(assert (not(and(= p true)(= q true)(= s false)(= t false)(= r false))))
(check-sat)
(get-model)

(assert (not(and(= p true)(= q false)(= s false)(= t false)(= r true))))
(check-sat)
(get-model)

;unsat
;Z3(25, 10): ERROR: model is not available
;The first two statements are satisfiable
;The thrid statement proves there isn'y any others