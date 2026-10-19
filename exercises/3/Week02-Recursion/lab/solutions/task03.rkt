#lang racket

; Последната стъпка е или 1, или 2 стъпала, затова:
;   ways(n) = ways(n - 1) + ways(n - 2)
; Това са числата на Фибоначи (отместени с 1), така че и тук може да се
; напише линеен итеративен процес, както в Задача 1.
(define (road-to-logprog stairs-count)
  (if (<= stairs-count 1)
      1
      (+ (road-to-logprog (sub1 stairs-count)) (road-to-logprog (- stairs-count 2)))
      )
  )

(= (road-to-logprog 4) 5)
(= (road-to-logprog 5) 8)
(= (road-to-logprog 10) 89)
