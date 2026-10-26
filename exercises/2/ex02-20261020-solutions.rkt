#lang racket

(define (const c)
  (lambda (x) c))

(define (flip f)
  (lambda (x y) (f y x)))

(define (compose f g)
  (lambda (x) (f (g x))))

(define (++ x) (+ x 1))
(define (sq x) (* x x))
(define (id x) x)

; Зад.1
(define (repeat n f)
  (if (= n 0) id
      ;(lambda (x) (f ((repeat (- n 1) f) x)))))
      ; не е по-различно от (+ x (repeat (- n 1) x)) за числа, напр.
      (compose f (repeat (- n 1) f))))

; Итеративно решение
(define (repeat* n f)
  (define (loop i res)
    (if (= i n) res
        (loop (+ i 1) (compose f res))))
  (loop 0 id))

; Зад.2
(define (twist k f g)
  (repeat (/ k 2) (compose f g)))

; Бонус: работи и за нечетни k
(define (twist* k f g)
  (if (= 0 k) id
      (compose f (twist* (- k 1) g f))))

(define (accumulate op nv a b term next)
  (if (> a b) nv
      (op (term a)
          (accumulate op nv (next a) b term next))))

; Зад.3
(define (!! n)
  (accumulate * 1
              (if (odd? n) 1 2) n
              id
              (lambda (i) (+ i 2))))

; Зад.4
(define (fact n)
  (accumulate * 1
              1 n
              id
              ++))

(define (nchk n k)
  (/ (fact n) (fact k) (fact (- n k))))

(define (nchk* n k)
  (accumulate * 1
              1 k
              (lambda (i) (/ (+ n (- k) i) i))
              ++))

; Зад.5
(define (2^ n)
  (accumulate * 1 1 n (const 2) ++))


; Зад.6
(define (all? p? a b)
  (accumulate (lambda (x y) (and x y)) #t
              a b
              p?
              ++))
; по ДеМорган
(define (complement p?)
  (lambda (x) (not (p? x))))
(define (any? p? a b)
  (not (all? (complement p?) a b)))

; Зад.7
(define (sum-powers k n)
  (accumulate + 0
              1 n
              id
              (lambda (i) (* k i))))

; Зад.8
(define (divisors-sum n)
  (accumulate + 0
              1 n
              (lambda (i) (if (zero? (remainder n i)) i 0))
              ++))

; Зад.9
(define (count p? a b)
  (accumulate + 0
              a b
              (lambda (i) (if (p? i) 1 0))
              ++))

; Зад.10
(define (prime? n)
  (and (> n 1)
       (all? (lambda (i) (> (remainder n i) 0)) 2 (sqrt n))))

; Зад.11
(define (repeat** n f)
  (accumulate compose id
              1 n
              (const f)
              ++))

; Зад.12
(define (twist** k f g)
  (accumulate compose id
              1 k
              (lambda (i) (if (odd? i) f g))
              ++))
   
(define (twist*** k f g)
  (repeat** (/ k 2) (compose f g)))

; Зад.13
; Когато нямаме очевиден неутрален елемент, си взимаме първия от редицата
; и обхождаме само останалите
(define (argmax f a b)
  (accumulate (lambda (x y) (if (>= (f x) (f y)) x y))
              a
              (+ a 1) b
              id ++))

; Зад.14
; Същата идея от зад.7 - правим floor(log10(n)) итерации
(define (count-digits n)
  (accumulate + 0 1 n (const 1) (lambda (i) (* i 10))))
