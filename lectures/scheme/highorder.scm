(define (twice f) (lambda (x) (f (f x))))

(define (square x) (* x x))

(define (n+ n) (lambda (i) (+ i n)))

(define 1+ (n+ 1))

(define (derive f dx)
  (lambda (x)
     (/ (- (f (+ x dx)) (f x)) dx)))

(define (derive-default f . params)
  (let ((dx (if (null? params) 0.0001 (car params))))
    (lambda (x)
      (/ (- (f (+ x dx)) (f x)) dx))))

(define (id x) x)

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (lambda (x)
    (if (= n 0) x
        (f ((repeated f (- n 1)) x)))))

(define (repeated f n)
  (if (= n 0) id
      (compose f (repeated f (- n 1)))))


(define (repeated f n)
  (accumulate compose id 1 n (lambda (i) f) 1+))

(define (derive-n f n dx)
  (if (= n 0) f
      (derive (derive-n f (- n 1) dx) dx)))

(define (derive-n f n dx)
;;  (define (derivedx ff) (derive ff dx))
  ((repeated (lambda (ff) (derive ff dx)) n) f))

(define (accumulate op nv a b term next)
  (if (> a b) nv
      (op (term a) (accumulate op nv (next a) b term next))))

(define (derive-n f n dx)
  ((accumulate compose id 1 n (lambda (i) (lambda (ff) (derive ff dx))) 1+) f))