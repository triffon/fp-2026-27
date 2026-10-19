#lang racket

(define (count-of-digits n)
  (if (< n 10)
      1
      (add1 (count-of-digits (quotient n 10)))
      )
  )

(define (get-last-n-digits-of number n)
  (remainder number (expt 10 n))
  )

(define (subnumber? x y)
  (define x-length (count-of-digits x))
  ; Сравняваме x с последните x-length цифри на current
  ; и "плъзгаме" наляво, като махаме последната цифра.
  (define (helper current)
    (cond
      [(= x (get-last-n-digits-of current x-length)) #t]
      ; current вече е не по-дълго от x - няма какво
      ; повече да проверяваме
      [(< current (expt 10 x-length)) #f]
      [else (helper (quotient current 10))]
      )
    )
  (helper y)
  )

(equal? (subnumber? 123 5123783) #t)
(equal? (subnumber? 0 0) #t)
(equal? (subnumber? 10 101) #t)
(equal? (subnumber? 101 101) #t)
(equal? (subnumber? 10 0) #f)
(equal? (subnumber? 1253 5123783) #f)
(equal? (subnumber? 12 0) #f)
(equal? (subnumber? 0 5) #f)
(equal? (subnumber? 0 105) #t)
(equal? (subnumber? 23 2003) #f)
