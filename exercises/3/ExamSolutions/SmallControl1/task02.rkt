#lang racket

; Резултатът е функция - затова сравняваме функциите по "резултат" (сумата от стойностите
; им върху xs) и пазим най-добрата досега. Сравнението е строго (>), така че при равенство
; остава по-ранната функция.
(define (best-function fs xs)
  (define (score f) (apply + (map f xs)))
  (foldl (λ (f best) (if (> (score f) (score best)) f best)) (car fs) (cdr fs))
  )

(= ((best-function (list add1 sqr -) '(1 2 3)) 10) 100) ; сумите са 9, 14 и -6
(= ((best-function (list add1 sqr -) '(-1 0 1)) 10) 11) ; сумите са 3, 2 и 0
(= ((best-function (list - abs) '(-5 2)) -7) 7)         ; сумите са 3 и 7
(= ((best-function (list add1 sub1) '()) 0) 1)          ; сумите са 0 и 0
