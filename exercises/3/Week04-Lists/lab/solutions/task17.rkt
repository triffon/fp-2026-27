#lang racket

(define (divides? x y)
  (zero? (remainder y x))
  )

(define (factorise n)
  ; Пробваме делителите 2, 3, 4, ... подред. Докато current-divisor дели left-over,
  ; го добавяме към result (може и няколко пъти); иначе минаваме към следващия.
  ; Съставните делители никога не делят left-over, защото простите им множители
  ; вече са извадени - затова няма нужда от проверка за простота.
  (define (helper left-over result current-divisor)
    (cond
      [(= left-over 1) result]
      [(divides? current-divisor left-over) (helper (quotient left-over current-divisor) (cons current-divisor result) current-divisor)]
      [else (helper left-over result (add1 current-divisor))]
      )
    )
  (reverse (helper n '() 2))
  )

(equal? (factorise 2) '(2))
(equal? (factorise 6) '(2 3))
(equal? (factorise 13) '(13))
(equal? (factorise 123) '(3 41))
(equal? (factorise 152) '(2 2 2 19))
(equal? (factorise 12356498) '(2 7 11 19 41 103))
