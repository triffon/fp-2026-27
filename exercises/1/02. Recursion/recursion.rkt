#lang racket

; Локални дефиниции

; let - независими локални дефиниции,
; т.е. не можем да използваме локална
; дефиниция в дефиницията на друга такава

(define let-example
  (let ([a 15]
        [b (+ 30 12)]
        [c (expt 2 5)])
    (+ a b c)))

; let* - локална дефиниция може да се направи
; и чрез предишна такава

(define let*-example
  (let* ([a 15]
        [b (+ a 83)])
    (/ a b)))

; letrec - можем да имаме взаимно рекурсивни дефинции

; забележка: горното не означава, че просто можем да използваме
; символ, който е по-късно дефиниран от този, който дефинираме сега.
; не сме говорили за ламбда-функции, но ето един пример за две
; взаимно рекурсивни локални дефиниции

(define (odd-or-even? x)
  (letrec ([odd? (lambda (y) (if (= y 0) #f (even? (- y 1))))]
           [even? (lambda (y) (if (= y 0) #t (odd? (- y 1))))])
  (cond [(< x 0) 'undefined]
         [(even? x) "even"]
         [else "odd"])))

; define - като letrec, има примери по-надолу :)

; Примитивна рекурсия

(define (fact n)
  (if (<= n 1)
      1
      (* n (fact (- n 1)))))

(define (fib n)
  (if (<= n 1)
      n
      (+ (fib (- n 1)) (fib (- n 2)))))

(define (power x n)
  (cond ((< n 0) (power (/ 1 x) (abs n)))
        ((= n 0) 1)
        (else (* x (power x (- n 1))))))

; Опашкова рекурсия - рекурсивното извикване е последно
; (т.е. няма други операции след него)
; спомага за оптимизация на пространствената сложност,
; тъй като не се създават излишни стекови рамки при рекурсията

(define (fact-tail-rec n)
  (define (go acc n)
    (if (<= n 1)
        acc
        (go (* n acc) (- n 1))))
  (go 1 n))

(define (fib-tail n)
  (define (go prev curr n)
    (if (= n 0)
        prev
        (go curr (+ prev curr) (- n 1))))
  (go 0 1 n))

(define (power-tail-rec x n)
  (define (go acc x n)
    (cond ((< n 0) (go acc (/ 1 x) (abs n)))
          ((= n 0) acc)
          (else (go (* x acc) x (- n 1)))))
  (go 1 x n))
