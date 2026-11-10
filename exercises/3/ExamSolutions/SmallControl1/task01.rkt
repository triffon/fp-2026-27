#lang racket

(define (accumulate op nv a b term next)
  (if (> a b) nv
      (op (term a) (accumulate op nv (next a) b term next))))

; Обхождаме цифрите на n чрез степените на 10: p = 1, 10, 100, ... (докато p <= n),
; а цифрата на позиция p е (remainder (quotient n p) 10).
; Числото 0 има една цифра, но accumulate от 1 до 0 не обхожда нищо - затова е отделен случай.
(define (count-digit-in-number d n)
  (if (zero? n)
      (if (zero? d) 1 0)
      (accumulate + 0 1 n (λ (p) (if (= (remainder (quotient n p) 10) d) 1 0)) (λ (p) (* p 10)))
      )
  )

(define (count-digit d a b)
  (accumulate + 0 a b (λ (n) (count-digit-in-number d n)) add1)
  )

(= (count-digit 1 1 12) 5)   ; 1, 10, 11, 12
(= (count-digit 0 1 100) 11) ; 10, 20, ..., 90, 100
(= (count-digit 3 30 33) 5)  ; 30, 31, 32, 33
(= (count-digit 7 1 6) 0)
