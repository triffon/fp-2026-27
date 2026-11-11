#lang racket

; помощни функции

(define empty-tree '())
(define empty-tree? null?)

(define (mk-tree root left right) (list root left right))
(define (mk-leaf root) (mk-tree root empty-tree empty-tree))

(define get-root car)
(define get-left-subtree cadr)
(define get-right-subtree caddr)

(define (tree? t)
  (or (empty-tree? t)
      (and (list? t)
           (= (length t) 3)
           (tree? (get-left-subtree t))
           (tree? (get-right-subtree t)))))

(define tree1 (mk-leaf 10))

(define tree2
  (mk-tree 2
           (mk-leaf 1)
           (mk-leaf 3)))

(define tree3
  (mk-tree 10
           (mk-tree 5
                    (mk-leaf 2)
                    empty-tree)
           (mk-leaf 15)))

(define tree4
    (mk-tree 20
             (mk-tree 10
                      (mk-leaf 5)
                      (mk-leaf 15))
             (mk-tree 30
                      (mk-leaf 25)
                      (mk-leaf 35))))

(define matrix1
  (list
    (list 1 2 3)
    (list 4 5 6)
    (list 7 8 9)))

(define matrix2
  (list
    (list 1 2)
    (list 3 4)))

(define the-empty-stream '())

(define-syntax cons-stream
  (syntax-rules () ((cons-stream h t) (cons h (delay t)))))

(define head car)

(define (tail s) (force (cdr s)))

(define empty-stream? null?)

(define (map-stream f s)
  (cons-stream (f (head s)) (map-stream f (tail s))))

(define (filter-stream p? s)
  (if (p? (head s))
      (cons-stream (head s) (filter-stream p? (tail s)))
      (filter-stream p? (tail s))))

(define (zip-streams op s1 s2)
  (cons-stream (op (head s1) (head s2)) (zip-streams op (tail s1) (tail s2))))

; =============================================================
;                    двоични дървета
; =============================================================

; 01. Да се дефинира функция, която намира броя листа в дърво.

; Пример: (count-leaves tree2) ~> 2
(define (count-leaves tree) 'undefined)

; 02. Да се дефинира функция, която намира височината на дърво.

; Пример: (tree-height tree2) ~> 2
(define (tree-height tree) 'undefined)

; 03. Да се дефинира функция, която проверява дали дърво е огледално.

; Пример: (symmetric-tree? tree2) ~> #t
(define (symmetric-tree? tree) 'undefined)

; 04. Да се дефинира функция, която проверява дали елемент съществува
; като възел в дърво. Ако да, да се върне свидетел за това (както на лекции).

; Пример: (tree-member? 3 tree2) ~> (3)
(define (tree-member? x tree) 'undefined)

; 05. Да се дефинира функция, която намира елементите на n-тото
; ниво на дърво.

; Пример: (level 1 tree2) ~> (1 3)
(define (level n tree) 'undefined)

; 06. Да се дефинира функция, която връща списък от елементите
; на всяко ниво в дърво.

; Пример: (levels tree2) ~> ((2) (1 3))
(define (levels tree) 'undefined)

; 07. Да се дефинира функция, която обхожда дърво, използвайки стратегиите:
; - ляво, корен, дясно;
; - корен, ляво, дясно.

; Пример: (traverse-infix tree2) ~> (1 2 3)
(define (traverse-infix tree) 'undefined)
(define (traverse-prefix tree) 'undefined)

; 08. Да се дефинира функция, която намира всички пътища в дърво.
; Разгледайте два варианта:
; - път завършва в листо;
; - път може и да не завършва в листо.

; Пример: (paths tree2) ~> ((2 1) (2 3))
(define (paths tree) 'undefined)

; 09. Да се дефинира функция, която намира най-дългия път в дърво.

; Пример: (longest-path tree3) ~> (10 5 2)
(define (longest-path tree) 'undefined)

; 10. (взета от Анди) Да се дефинира функция, която заменя
; стойностите във всеки възел на дадено дърво със
; средноаритметичното на минималната и максималната стойност
; в поддървото с корен съотвения възел.

; Пример: (avg tree2) ~> ...
(define (avg tree) 'undefined)

; =============================================================
;                         матрици
; =============================================================

; 11. Да се дефинира предикат, който проверява дали
; списък от списъци е матрица.

; Пример: (matrix? matrix1) ~> #t
(define (matrix? m) 'undefined)

; 12. Да се дефинира функция, която събира две матрици.

; Пример: (matrix-add matrix2 matrix2) ~> ((2 4) (6 8))
(define (matrix-add m1 m2) 'undefined)

; 13. Да се дефинира функция, която умножава две матрици.

; Пример: (matrix-multiply matrix2 matrix2) ~> ...
(define (matrix-multiply m1 m2) 'undefined)

; 14. Да се дефинира функция, която приема едноместна функция
; f и матрица от числа m и намира най-голямата функционална
; стойност f(x), където x е елемент на m.

; Пример: (max-functional-value sqr matrix1) ~> 81
(define (max-functional-value f m) 'undefined)

; 15. Да се дефинира функция, която приема едноместна функция
; f и матрица от числа m и намира стойност x от m, така че
; функционалната стойност f(x) е максимална.

; Пример: (element-with-max-functional-value sqr matrix1) ~> 9
(define (element-with-max-functional-value f m) 'undefined)

; 16. (взета от Ангел) Да се дефинира функция (apply-kernel kernel mat),
; която използва дадената функция kernel, за да направи нова матрица от дадената:
; - функцията kernel приема матрица 3x3 и връща число;
; - елементът на позиция (i, j) в новата матрица трябва да е стойността,
;   получена при прилагане на kernel върху подматрицата,
;   включваща елемента (i, j) и осемте му съседи;
; - за да може да се изчислят и стойностите по ръбовете,
;   може да приемете, че елементите извън границите
;   на дадената матрица имат стойност 0.

; Пример: (apply-kernel (lambda (m) 0) matrix1) ~> ((0 0 0) (0 0 0) (0 0 0))
(define (apply-kernel kernel mat) 'undefined)


; =============================================================
;                            потоци
; =============================================================

; 17. Да се дефинира функция, която конкатенира два потока.
; Пример: (stream-append s1 s2) ~> ...
(define (stream-append s1 s2) 'undefined)

; 18. Да се дефинира функция, която взима първите n елемента от поток.
; Пример: (stream-take 3 s) ~> ...
(define (stream-take n s) 'undefined)

; 19. Да се дефинира безкраен поток от всички естествени числа.

; Пример: (stream-take 3 naturals) ~> '(1 2 3)
(define naturals 'undefined)

; 20. Да се дефинира безкраен поток от всички цели числа.
; Пример: (stream-take 3 integers) ~> '(0 1 -1)
(define integers 'undefined)

; 21. Да се дефинира безкраен поток от всички наредени двойки.
; Пример: (stream-take 3 pairs) ~> '((0 . 0) (0 . 1) (1 . 0))
(define pairs 'undefined)

; 22. Да се дефинира безкраен поток от всички числа близнаци.
; Казваме, че две числа са близнаци, ако са прости и разликата
; между тях е 2.
; Пример: (stream-take 2 twin-primes) ~> '((3 . 5) (5 . 7))
(define twin-primes 'undefined)

; 23. Да се дефинира безкраен поток от всички степени на двойката.
; Пример: (stream-take 3 powers-of-two) ~> '(1 2 4)
(define powers-of-two 'undefined)

; 24. Да се дефинира безкраен поток от всички триъгълни числа.
; n-тото подред число е сумата на първите n естествени числа.
; Пример: (stream-take 4 triangulars) ~> '(1 3 6)
(define triangulars 'undefined)

; Бонус: Използвайте zip-streams.
