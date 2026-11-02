#lang racket

(define (length l)
  (if (empty? l) 0
      (+ 1 (length (cdr l)))))

(define (reverse l)
  (if (empty? l) l
      (append (reverse (cdr l)) (list (car l)))))


(define (map f l)
  (if (empty? l) l
      (cons (f (car l)) (map f (cdr l)))))

(define (filter p? l)
  (if (empty? l) l
      (if (p? (car l)) (cons (car l) (filter p? (cdr l)))
          (filter p? (cdr l)))))

(define (at l n)
  (cond [(empty? l) (error "undefined")]
        [(= n 0) (car l)]
        [else (at (cdr l) (- n 1))]))


(define (take n l)
  (cond [(empty? l) '()]
        [(= n 0) '()]
        [else (cons (car l) (take (- n 1) (cdr l)))]))

(define (drop n l)
  (cond [(empty? l) l]
        [(= n 0) l]
        [else (drop (- n 1) (cdr l))]))

(define (append l1 l2)
  (if (empty? l1) l2
      (cons (car l1) (append (cdr l1) l2))))


(define (all? p? l)
  (equal? l (filter p? l)))

(define (any? p? l)
  (not (empty? (filter p? l))))

(define (all1? p? l)
  (if (empty? l) #t
      (and (p? (car l)) (all? p? (cdr l)))))

(define (any1? p? l)
  (if (empty? l) #f
      (or (p? (car l)) (any? p? (cdr l)))))

(define (zipWith f l1 l2)
  (cond [(empty? l1) '()]
        [(empty? l2) '()]
        [else (cons (f (car l1) (car l2)) (zipWith f (cdr l1) (cdr l2) ))]))

(define (zip l1 l2)
  (zipWith cons l1 l2))

(define (zipWith2 f l1 l2)
  (map (lambda (x) (f (car x) (cdr x)))  (zip l1 l2)))

(define (sorted? l)
  (cond [(empty? l) #t]
        [(= (length l) 1) #t]
        [else (and (<= (car l) (cadr l)) (sorted? (cdr l)))]))

(define (foldr operation null_value lst)
  (if (null? lst) null_value
      (operation (car lst)
          (foldr operation null_value (cdr lst)))))

(define (foldl operation null_value lst)
  (if (null? lst) null_value
      (foldl operation (operation null_value (car lst)) (cdr lst))))

  
(define (length2 l)
  (foldr (lambda (x y) (+ 1 y)) 0 l))

(define (all2? p? l)
  (foldr (lambda (elem result) (and (p? elem) result)) #t l))

(define (reverse2 l)
  (foldl (lambda (result elem) (cons elem result)) '() l))

(define (map3 f lst) (foldr (lambda (el res) (cons (f el) res)) '() lst))

(define (filter3 p? lst) (foldr (lambda (el res) (if (p? el) (cons el res) res)) '() lst))

(define (append3 l1 l2) (foldr cons l2 l1))


      
