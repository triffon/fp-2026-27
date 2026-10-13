
(define (sign n)
  (cond ((= n 0) "zero")
        ((< n 0) "negative")
        ("positive")))

(define (sign2 n)
  (if (= n 0)
      "zero"
      (if (< n 0)
          "negative"
          "positive")))

(define (devisable-by? n k)
  (if (= (remainder n k ) 0) #t #f))

(define (leap? n)
  (if (devisable-by? n 400)
      #t
      (if (devisable-by? n 100)
          #f
          (if (devisable-by? n 4)
              #t
              #f))))

(define (fact n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fact (- n 1)) (fact (- n 2))))))

(define (fib n)
  (if (< n 2) n
      (+ (fib (- n 1)) (fib (- n 2))) 
  ))

(define (sum-interval a b)
  (if (> a b)
      0
      (+ a (sum-interval (+ a 1) b))))

(define (sum-interval2 a b)
  (if (> (+ 2 a) b)
      0
      (+ (+ a 1) (sum-interval2 (+ a 1) b))))

(define (sum-interval3 a b)
  (if (> (ceiling a) (floor b))
      0
      (+ (ceiling a) (sum-interval3 (+ a 1) b))))


(define (count-digit d n)
  (if (< n 10) (if (= d n) 1 0)
  (+ (if (= (remainder n 10) d)  1 0) (count-digit d (quotient n 10)))))

(define (count-digit-interval d a b)
  (if (> a b)
      0
      (+ (count-digit d a) (count-digit-interval d (+ a 1) b))))

(define (number-length n)
  (if (< n 10) 1
      (+ 1 (number-length (quotient n 10)))))

(define (reverse-digits n)
  (if (< n 10) n
      (+ (* (expt 10 (number-length (quotient n 10))) (remainder n 10))   (reverse-digits (quotient n 10)))))




  
