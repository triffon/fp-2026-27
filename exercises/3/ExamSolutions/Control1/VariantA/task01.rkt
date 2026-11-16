#lang racket

(define (accumulate op nv a b term next)
  (if (> a b) nv
      (op (term a) (accumulate op nv (next a) b term next))))

(define (prime? n)
  ; Достатъчно е да проверим делителите до корен от n.
  (define (helper divisor)
    (cond
      [(> (* divisor divisor) n) #t]
      [(zero? (remainder n divisor)) #f]
      [else (helper (add1 divisor))]
      )
    )
  (and (> n 1) (helper 2))
  )

; Вмъкваме 1 точно пред позиция p = 1, 10, 100, ...: n се разделя на "висока" част (quotient n p)
; и "ниска" част (remainder n p), а между тях застава новата цифра, т.е. high * 10p + 1 * p + low.
(define (insert-one n p)
  (+ (* (quotient n p) 10 p) p (remainder n p))
  )

; Последната позиция е най-малката степен на 10, по-голяма от n - тогава 1 става водеща цифра.
; Тя винаги е <= 10n, а следващата е > 10n, затова обхождаме p = 1, 10, ... докато p <= 10n.
; Числото е твърде съставно, ако нито едно вмъкване не дава просто число.
(define (too-composite? n)
  (zero? (accumulate + 0 1 (* 10 n) (λ (p) (if (prime? (insert-one n p)) 1 0)) (λ (p) (* p 10))))
  )

(define (too-composite a b)
  (accumulate + 0 a b (λ (n) (if (too-composite? n) 1 0)) add1)
  )

; Алтернативно решение: генерираме интервала с range, оставяме твърде съставните с filter и ги броим.
(define (too-composite-range a b)
  (length (filter too-composite? (range a (add1 b))))
  )

(equal? (insert-one 8 1) 81)
(equal? (insert-one 8 10) 18)
(equal? (insert-one 10 1) 101)

(= (too-composite 8 12) 3)      ; 8, 11, 12
(= (too-composite 1 1000) 586)
(= (too-composite 9 10) 0)      ; 19 и 101 са прости

(= (too-composite-range 8 12) 3)
(= (too-composite-range 1 1000) 586)
