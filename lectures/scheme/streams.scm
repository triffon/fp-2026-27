(define the-empty-stream '())
;(define (cons-stream h t) (cons h (delay t)))
(define-syntax cons-stream (syntax-rules () ((cons-stream h t) (cons h (delay t)))))
(define head car)
(define (tail s) (force (cdr s)))
(define empty-stream? null?)

(define s (cons-stream 1 (cons-stream 2 (cons-stream 3 the-empty-stream))))
(define s2 (cons-stream 1 (cons-stream b (cons-stream c the-empty-stream))))

(define (from-to a b)
  (if (> a b) '()
      (cons a (from-to (+ a 1) b))))

(define (enum a b)
  (if (> a b) the-empty-stream
      (cons-stream a (enum (+ a 1) b))))

(define (take n s)
  (if (or (empty-stream? s) (= n 0)) '()
      (cons (head s) (take (- n 1) (tail s)))))

(define (search-stream p? s)
  (and (not (empty-stream? s)) (or (and (p? (head s)) s) (search-stream p? (tail s)))))

(define (from n)
  (cons-stream n (from (+ n 1))))

(define nats (from 0))

(define (generate-fibs a b)
  (cons-stream a (generate-fibs b (+ a b))))

(define fibs (generate-fibs 0 1))

(define (map-stream f s)
  (if (empty-stream? s) the-empty-stream
      (cons-stream (f (head s)) (map-stream f (tail s)))))

(define (filter-stream p? s)
  (if (empty-stream? s) the-empty-stream
      (if (p? (head s)) (cons-stream (head s) (filter-stream p? (tail s)))
                                              (filter-stream p? (tail s)))))

(define (zip-streams op s1 s2)
  (if (or (empty-stream? s1) (empty-stream? s2)) the-empty-stream
      (cons-stream (op (head s1) (head s2)) (zip-streams op (tail s1) (tail s2)))))

(define ones (cons-stream 1 ones))

;; !!! (define (tail nats) (zip-streams + ones nats))
(define nats (cons-stream 0 (zip-streams + ones nats)))

(define fibs (cons-stream 0 (cons-stream 1 (zip-streams + fibs (tail fibs)))))

;; (define primes (filter-stream prime? nats))

(define (notdivides k)
   (lambda (x) (not (= 0 (remainder x k)))))

(define (sieve s)
  (cons-stream (head s) (sieve (filter-stream (notdivides (head s)) (tail s)))))

(define primes (sieve (from 2)))

(define (sieve2 s)
  (cons-stream (head s) (filter-stream (notdivides (head s)) (sieve2 (tail s)))))

(define primes2 (sieve2 (from 2)))

