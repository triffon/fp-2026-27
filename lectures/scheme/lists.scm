(define (length l)
  (if (null? l) 0
      (+ 1 (length (cdr l)))))


(define (length l)
  (foldr (lambda (x r) (+ r 1)) 0 l))

(define (append l1 l2)
  (if (null? l1) l2
      (cons (car l1) (append (cdr l1) l2))))

(define (append l1 l2)
  (foldr cons l2 l1))

(define (reverse l)
  (if (null? l) l
      (append (reverse (cdr l)) (list (car l)))))

(define (foldr op nv l)
  (if (null? l) nv
      (op (car l) (foldr op nv (cdr l)))))

(define (snoc x l)
  (append l (list x)))

(define (reverse l)
;;  (foldr (lambda (x r) (append r (list x))) '() l))
  (foldr snoc '() l))

(define (reverse l)
  (foldl (lambda (r x) (cons x r)) '() l))

(define (from-to a b)
  (if (> a b) '()
      (cons a (from-to (+ a 1) b))))

(define (list-tail l n)
  (cond ((< n 0) "Отрицателна стойност!")
        ((= n 0) l)
        (else (cdr (list-tail l (- n 1))))))

(define (list-ref l n)
  (cond ((< n 0) "Отрицателна стойност!")
        ((= n 0) (car l))
        (else (list-ref (cdr l) (- n 1)))))

(define (member x l)
  (if (null? l) #f
      (if (equal? x (car l)) l
          (member x (cdr l)))))

(define (member? x l)
  (foldr (lambda (y r) (or (equal? x y) r)) #f l))

(define (member? x l)
  (and (not (null? l))
       (or (equal? x (car l)) (member? x (cdr l)))))

(define (member x l)
  (and (not (null? l))
       (or (and (equal? x (car l)) l) (member x (cdr l)))))

;;;(define (member x l)
;;;  (foldr (lambda (y r) (or (and (equal? x y) ????) r)) #f l))


(define (member-with equality? x l)
  (and (not (null? l))
       (or (and (equality? x (car l)) l) (member-with equality? x (cdr l)))))

(define (member x l)
  (member-with equal? x l))

(define (memv x l)
  (member-with eqv? x l))

(define (1+ x) (+ x 1))

(define (map f l)
  (if (null? l) l
      (cons (f (car l)) (map f (cdr l)))))

(define (map f l)
  (foldr (lambda (x r) (cons (f x) r)) '() l))

(define (filter p? l)
  (if (null? l) l
      (if (p? (car l)) (cons (car l) (filter p? (cdr l)))
          (filter p? (cdr l)))))

(define (filter p? l)
  (foldr (lambda (x r) (if (p? x) (cons x r) r)) '() l))

(define (foldr op nv l)
  (if (null? l) nv
      (op (car l) (foldr op nv (cdr l)))))

(define (foldl op nv l)
  (if (null? l) nv
      (foldl op (op nv (car l)) (cdr l))))

(define (maximum l)
  (foldr max (car l) l))