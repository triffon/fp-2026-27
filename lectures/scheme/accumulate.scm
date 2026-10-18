(define (accumulate op nv a b term next)
  (if (> a b) nv
      (op (term a) (accumulate op nv (next a) b term next))))

(define (id i) i)
(define (1+ i) (+ i 1))

(define (fact n)
;;  (accumulate * 1 1 n (lambda (i) i) (lambda (i) (+ i 1))))
  (accumulate * 1 1 n id 1+))

(define (constx i) x)

(define (pow x n)
  (accumulate * 1 1 n (lambda (i) x) 1+))
;; !!!   (accumulate * 1 1 n constx 1+))
