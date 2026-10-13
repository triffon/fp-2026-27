(define (fact n)
  (if (= n 0) 1
      (* n (fact (- n 1)))))

(fact 4)

(define (fact-i n)
  (for n 1 1))

(define (for n r i)
  (if (<= i n)
      (for n (* r i) (+ i 1))
      r))