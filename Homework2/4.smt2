(declare-const p Bool)
(declare-const q Bool)
(declare-const r Bool)

(assert (=> p q r))  
(check-sat)  
(get-model)

(assert (not(and(= r true)(= q false)(= p true))))
(check-sat)
(get-model)

(assert (not(and(= r false)(= q false))))
(check-sat)
(get-model)

(reset)
(declare-const p Bool)
(declare-const q Bool)
(declare-const r Bool)

(assert (= (and(= r false)(= q false)) (and(= r true)(= q false)(= p true))))
(check-sat)
(get-model)
;The statements are equivalent