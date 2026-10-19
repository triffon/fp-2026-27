#lang racket

(define (prime? n)
  ; Достатъчно е да проверим делителите до корен от n: ако n = a * b
  ; и a > корен от n, то b < корен от n и вече сме намерили b.
  (define (helper divisor)
    (cond
      [(> (* divisor divisor) n) #t]
      [(zero? (remainder n divisor)) #f]
      [else (helper (add1 divisor))]
      )
    )
  (and (> n 1) (helper 2))
  )

(equal? (prime? 0) #f)
(equal? (prime? 1) #f)
(equal? (prime? 2) #t)
(equal? (prime? 3) #t)
(equal? (prime? 6) #f)
(equal? (prime? 42) #f)
(equal? (prime? 61) #t)