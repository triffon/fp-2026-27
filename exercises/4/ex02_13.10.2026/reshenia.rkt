#lang racket

(define (5+ x)
  (+ x 5))

(define (3* x)
  (* x 3))

(define (id x) x)

(define (fake-compose f g x)
  (f (g x)))

(define (compose f g) (lambda (x) (f (g x))))

(define (flip f)
  (lambda (x y) (f y x)))

(define (repeat f n)
  (if (zero? n) id
      (compose f ((repeat f (- n 1))))))

(define (++ x) (+ x 1))
(define (sq x) (* x x))

(define (twist k f g)
  (if (zero? k) id
      (compose f (compose g (twist (- k 2) f g)))))

(define foo (twist 4 ++ sq))
; това ще смята ((((x^2)+1)^2)+1)
(define bar (twist 2 ++ sq))
; това ще смята ((x^2)+1)

(define (twist2 k f g)
  (repeat (compose f g) (/ k 2)))

(define (twist3 k f g)
    (if (= k 0) id
      (compose f (repeat f (- k 1)))))


(define (curry f)
  (lambda (x) (lambda (y) (f x y))))


(define (accumulate operation null-value begin end term next)
  (if (> begin end) null-value
      (operation (term begin)
                 (accumulate operation null-value (next begin) end term next))))


(define (!! n)
  (accumulate * 1 (if (odd? n) 1 2) n id (lambda (x) (+ x 2))))

(define (fact-acc n)
  (accumulate * 1 1 n id (lambda (x) (+ x 1))))

(define (sum-odd-squares a b)
  (accumulate + 0 a b (lambda (x) (if (odd? x) (* x x) 0)) ++))

(define (binomial-fact n k)
  (/ (fact-acc n) (* (fact-acc k) (fact-acc (- n k)))))

(define (binomial n k)
  (accumulate * 1 1 k (lambda (x) (/ (- (+ n 1) x) x )) ++))

(define (argmax f a b)
  (accumulate (lambda (curr rest) (if (> (f curr) (f rest)) curr rest)) a a b id ++))

(define (all? p? a b)
  (accumulate (lambda (curr rest) (and curr rest)) #t a b p? ++))

(define (any? p? a b)
  (accumulate (lambda (x y) (or x y)) #f a b p? ++))

(define (prime? n)
  (if (< n 2) #f
  (not (any? (lambda (x) (= (remainder n x) 0)) 2 (- n 1)))))

(define (count-digits n)
  (if (zero? n) 1
  (accumulate + 0 1 n (lambda (x) 1) (lambda (x) (* x 10)))))

