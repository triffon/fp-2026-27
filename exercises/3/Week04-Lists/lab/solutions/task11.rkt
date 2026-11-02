#lang racket

(define (num-to-xs num)
  ; Откъсваме цифрите отзад напред и ги слагаме в началото на result,
  ; така че накрая те са в правилния ред.
  (define (helper current result)
    (cond
      [(zero? current) result]
      [else (helper (quotient current 10) (cons (remainder current 10) result))]
      )
    )
  (if (zero? num) '(0) (helper num '()))
  )

; Алтернативно решение: цифрите на num са цифрите на (quotient num 10),
; следвани от последната цифра - директна рекурсия без помощна процедура.
; Едноцифреното число е дъното и покрива и случая num = 0.
(define (num-to-xs-append num)
  (if (< num 10)
      (list num)
      (append (num-to-xs-append (quotient num 10)) (list (remainder num 10)))
      )
  )

; Схема на Хорнер: за всяка следваща цифра изместваме натрупаното число
; с един разред наляво и добавяме цифрата: 1 -> 12 -> 123.
(define (xs-to-num xs)
  (foldl (λ (digit acc) (+ (* acc 10) digit)) 0 xs)
  )

(equal? (num-to-xs 123) '(1 2 3))
(equal? (num-to-xs 123456789) '(1 2 3 4 5 6 7 8 9))

(equal? (num-to-xs-append 123) '(1 2 3))
(equal? (num-to-xs-append 123456789) '(1 2 3 4 5 6 7 8 9))

(= (xs-to-num '(1 2 3)) 123)
(= (xs-to-num '(1 2 3 4 5 6 7 8 9)) 123456789)
