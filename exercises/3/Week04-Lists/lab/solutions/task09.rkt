#lang racket

; (range a (add1 b)) дава '(a a+1 ... b), защото горната граница на range не се включва.
(define (tabulate f)
  (λ (a b) (map (λ (x) (cons x (f x))) (range a (add1 b))))
  )

(equal? ((tabulate (λ (x) (* x x))) 1 5) '((1 . 1) (2 . 4) (3 . 9) (4 . 16) (5 . 25)))
