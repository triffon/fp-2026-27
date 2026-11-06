(define (make-alist f keys)
  (map (lambda (key) (cons key (f key))) keys))

  
(define (square x) (* x x))

(define (from-to a b)
  (if (> a b) '()
      (cons a (from-to (+ a 1) b))))

(define al (make-alist square (from-to 1 5)))

(define (filter p? l)
  (if (null? l) l
      (if (p? (car l)) (cons (car l) (filter p? (cdr l)))
          (filter p? (cdr l)))))

(define (assoc key al)
  (safe-car (filter (lambda (kv) (equal? (car kv) key)) al)))

(define (safe-car l)
  (and (pair? l) (car l)))

(define (make-safe f p?)
  (lambda (x)
    (and (p? x) (f x))))

(define safe-car (make-safe car pair?))

(define (del-assoc key al)
  (filter (lambda (kv) (not (equal? (car kv) key))) al))

(define (add-assoc key value al)
  (cons (cons key value) (del-assoc key al)))

(define (search p? l)
  (safe-car (filter p? l)))

(define (exists? p? l)
  (pair? (filter p? l)))

(define (exists? p? l)
  (if (null? l) #f
      (if (p? (car l)) #t
          (exists? p? (cdr l)))))

(define (search p l)
  (and (not (null? l)) (or (p (car l)) (search p (cdr l)))))

(define (assoc key al)
  (search (lambda (kv) (and (equal? (car kv) key) kv)) al))


(define (forall? p? l)
  (not (exists? (lambda (x) (not (p? x))) l)))