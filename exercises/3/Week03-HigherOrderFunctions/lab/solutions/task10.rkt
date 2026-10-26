#lang racket

(define (accumulate op nv a b term next)
    (if (> a b) nv
        (op (term a) (accumulate op nv (next a) b term next))))

; Обхождаме степените на 10 - 1, 10, 100, ..., които не надвишават n,
; и броим по 1 за всяка. Число с k цифри има точно k такива степени.
; 0 е специален случай - няма степен на 10, която е <= 0.
(define (count-digits n)
  (if (zero? n)
      1
      (accumulate + 0 1 n (λ (x) 1) (λ (x) (* x 10)))
      )
  )

(= (count-digits 12345) 5)
(= (count-digits 5) 1)
(= (count-digits 10) 2)
(= (count-digits 99) 2)
(= (count-digits 100) 3)
(= (count-digits 0) 1)
