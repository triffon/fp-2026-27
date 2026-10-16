(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1)) (fib (- n 2))))))

(define (fib-iter n)
  (define (iter i fi fi+1) ;; връща fn
    (if (= i n) fi 
        (iter (+ i 1) fi+1 (+ fi fi+1))))
  (iter 0 0 1))