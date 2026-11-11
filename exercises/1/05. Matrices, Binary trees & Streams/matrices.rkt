#lang racket

; Матрица в Scheme ще представяме
; като списък от списъци. Например:

(define matrix
  (list
    (list 1 2 3)
    (list 4 5 6)
    (list 7 8 9)))

; Не всеки списък от списъци обаче е матрица.
; Например:

(define not-a-matrix
  (list
    (list 1 2)
    (list 3)))

; не е матрица, защото първият и вторият
; ред имат различен брой елементи.

; Тогава можем да напишем предикат,
; който да проверява дали списък от списъци
; е валидна матрица:

(define (forall? p? lst)
  (if (null? lst) #t (and (p? (car lst)) (forall? p? (cdr lst)))))

(define (matrix? m)
  (and (list? m)
       (not (null? m))
       (forall? (lambda (row)
                  (and
                    (list? row)
                    (not (null? row))))
                m)
       (let ([size (length (car m))])
         (forall? (lambda (row)
                    (= (length row) size))
                  (cdr m)))))

(matrix? matrix)
(matrix? not-a-matrix)

; Някои операции с матрици стават сравнително
; просто в Scheme, като например транспониране
; и събиране:

; - транспониране:
(define (transpose m)
  (and (matrix? m) (apply map list m)))

(transpose matrix)

; Горното работи, защото map е вариадична функция,
; тоест, може да приема множество списъци.
; Това означава, че ако подаваме n на брой списъка,
; трябва да подадем n-местна функция f:

(map (λ (x) (+ x 1)) '(1 2 3)) ; (2 3 4)
(map + '(1 2 3) '(4 5 6)) ; ~> '(5 7 9) ; събира ги поелементно

; и т.н.

; - събиране на матрици:
(define (matrix-dimensions m)
  (and (matrix? m)
       (cons (length m)
             (length (car m)))))

(define (eq-dimensions? m1 m2)
  (define dim1 (matrix-dimensions m1))
  (define dim2 (matrix-dimensions m2))
  ; това е заради изродения случай,
  ; където и двете не са матрици
  ; и сравняваме #f и #f
  (and dim1
       dim2
       (equal? m1 m2)))

(define (sum-matrices m1 m2)
  (and (eq-dimensions? m1 m2)
       (map (λ (row1 row2)
              (map + row1 row2))
            m1
            m2)))

; - умножение:
(define (multiply-matrices m1 m2)
  (define m2-transposed (transpose m2))
  (define dim1 (matrix-dimensions m1))
  (define dim2 (matrix-dimensions m2))
  (and dim1
       dim2
       (= (cdr dim1) (car dim2))
       (map (λ (row1)
              (map (λ (row2)
                     (apply + (map * row1 row2)))
                   m2-transposed))
            m1)))
