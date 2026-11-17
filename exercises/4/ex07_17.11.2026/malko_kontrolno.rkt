#lang racket

(define (get-list-digits n)
  (if (< n 10) (list n)
      (cons (remainder n 10) (get-list-digits (quotient n 10)))))


(define (get-sorted-digits n)
  (sort (get-list-digits n) <))


(define (have-same-digits n1 n2)
  (equal? (get-sorted-digits n1) (get-sorted-digits n2)))

(define (number-length n)
  (if (< n 10) 1
      (+ 1 (number-length (quotient n 10)))))

;; натрупване от по-висок ред
(define (accumulate op nv a b term next)
  (if (> a b) nv
      (op (term a) (accumulate op nv (next a) b term next))))



(define (get-all-with-same-digits n)
  (let ([upper-bound (expt 10 (number-length n))]
        [lower-bound (expt 10 (- (number-length n) 1))])
    (accumulate (lambda (el res) (if (have-same-digits n el) (cons el res) res)) '() lower-bound upper-bound (lambda (x) x) (lambda (x) (+ x 1)))))

;; функции за дървета
(define empty-tree '())
(define (leaf x) (list x empty-tree empty-tree))
(define make-tree list)

(define empty-tree? null?)
(define root-tree car)
(define left-tree cadr)
(define right-tree caddr)

(define (tree? x)
  (or (null? x) (and (list? x) (= (length x) 3) (tree? (cadr x)) (tree? (caddr x)))))


(define (f n)
  (apply string-append (map number->string (get-sorted-digits n))))

(define (sorted-digits-tree t)
  (if (empty-tree? t) t
      (list (f (root-tree t)) (sorted-digits-tree (left-tree t)) (sorted-digits-tree (right-tree t)))))

(define simple-tree '(21 (311 (428 () ()) (5 () ())) (60 () ())))




