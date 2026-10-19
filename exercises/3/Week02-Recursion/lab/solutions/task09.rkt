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

(define (contains-digit? n d)
  (define (helper current)
    (cond
      [(= current 0) #f]
      [(= d (remainder current 10)) #t]
      [else (helper (quotient current 10))]
      )
    )
  (helper n)
  )

(define (sum-first-special-numbers n d)
  (define (helper sum count candidate)
    (cond
      [(= count n) sum]
      [(and (prime? candidate) (contains-digit? candidate d))
       (helper (+ sum candidate) (add1 count) (add1 candidate))]
      [else (helper sum count (add1 candidate))]
      )
    )
  (helper 0 0 2)
  )

(= (sum-first-special-numbers 5 2) 392)
(= (sum-first-special-numbers 5 3) 107)
(= (sum-first-special-numbers 10 3) 462)