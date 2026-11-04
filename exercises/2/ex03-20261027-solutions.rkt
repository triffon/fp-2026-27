#lang racket

(define head car)
(define tail cdr)

; Зад.0
(define (length* lst)
  (if (null? lst)
      0
      (+ 1 (length* (tail lst)))))

(define (map* f lst)
  (if (null? lst)
      '()
      (cons (f (head lst))
            (map* f (tail lst)))))

; Много от вградените функции биха могли да се имплементират с foldr
(define (map** f lst)
  ; първият аргумент е главата на текущия списък lst
  ; вторият аргумент е резултата от foldr за опашката на lst
  (foldr (lambda (el res) (cons (f el) res))
         '()
         lst))

(define (reverse* lst)
  (foldl cons '() lst)) ; (!)

; Зад.1
(define (take n lst)
  (cond [(= n 0) '()]
        [(null? lst) lst]
        [else (cons (head lst) (take (- n 1) (tail lst)))]))

(define (drop n lst)
  (cond [(= n 0) lst]
        [(null? lst) '()]
        [else (drop (- n 1) (tail lst))]))

; Зад.2
(define (all? p? lst)
  ;(cond [(null? lst) #t]
  ;      [(p? (head lst)) (all? p? (tail lst))]
  ;      [else #f]))
  ; Декларативен стил: "предикатът е изпълнен за всички, ако списъкът е празен
  ; или предикатът е изпълнен и за главата, и за всички от опашката"
  (or (null? lst)
      (and (p? (head lst))
           (all? p? (tail lst)))))

(define (any? p? lst)
  (and (not (null? lst))
       (or (p? (head lst))
           (any? p? (tail lst)))))

; Зад.3
(define (zip lst1 lst2)
  ;(if (or (null? lst1) (null? lst2))
  ;    '()
  ;    (cons (cons (head lst1) (head lst2))
  ;          (zip (tail lst1) (tail lst2)))))
  (zipWith cons lst1 lst2))

; Зад.4
(define (zipWith f lst1 lst2)
  (if (or (null? lst1) (null? lst2))
      '()
      (cons (f (head lst1) (head lst2))
            (zipWith f (tail lst1) (tail lst2)))))

; Зад.5
(define (sorted? lst)
  (or (null? lst)
      (null? (tail lst))
      (and (<= (head lst) (head (tail lst)))
           (sorted? (tail lst)))))

; Зад.6
(define (sorted?* lst)
  (or (null? lst)
      (all? (lambda (p) (<= (car p) (cdr p)))
            (zip lst (tail lst)))))
