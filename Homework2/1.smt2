(declare-const r Bool)
(declare-const p Bool)
(declare-const q Bool)
(assert (=> (and (or p q)(=> q r)(not p)) r))
(check-sat)
(get-model)
;Yes the formula is satisfiable.