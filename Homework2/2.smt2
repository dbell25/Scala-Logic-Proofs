(declare-const p Bool)
(declare-const q Bool)
(assert (and(or(=> p q)(=> q p))(not(and(=> p q)(=> q p)))))
(check-sat)
(get-model)

(assert (not(and(= p false)(= q true))))
(check-sat)
(get-model)

(assert (not(and(= p true)(= q false))))
(check-sat)
(get-model)

;unsat
;Z3(13, 10): ERROR: model is not available
;The first two are satisfying truth statemenst
;The thrid is to prove there isn't any others