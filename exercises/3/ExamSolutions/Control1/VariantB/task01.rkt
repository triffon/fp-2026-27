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

; Премахваме цифрата на позиция p = 1, 10, 100, ...: "високата" част е над нея (quotient n 10p),
; а "ниската" - под нея (remainder n p), т.е. новото число е high * p + low.
; Водещите нули изчезват сами, защото работим с числа, а не с низове: 103 -> 03 = 3.
(define (remove-digit n p)
  (+ (* (quotient n (* 10 p)) p) (remainder n p))
  )

; Както при броенето на цифри, обхождаме степените на 10 докато p <= n.
; Числото е почти просто, ако поне едно премахване дава просто число.
(define (almost-prime? n)
  (and (>= n 10)
       (positive? (accumulate + 0 1 n (λ (p) (if (prime? (remove-digit n p)) 1 0)) (λ (p) (* p 10)))))
  )

(define (almost-primes a b)
  (accumulate + 0 a b (λ (n) (if (almost-prime? n) 1 0)) add1)
  )

; Алтернативно решение: генерираме интервала с range, оставяме почти простите с filter и ги броим.
(define (almost-primes-range a b)
  (length (filter almost-prime? (range a (add1 b))))
  )

(equal? (remove-digit 123 1) 12)
(equal? (remove-digit 123 10) 13)
(equal? (remove-digit 123 100) 23)
(equal? (almost-prime? 103) #t)  ; 103 -> 03 = 3
(equal? (almost-prime? 7) #f)    ; n < 10

(= (almost-primes 5 15) 3)       ; 12, 13, 15
(= (almost-primes 1 1000) 503)

(= (almost-primes-range 5 15) 3)
(= (almost-primes-range 1 1000) 503)
