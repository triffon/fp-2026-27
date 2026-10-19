#lang racket

(define (fib-recursive n)
  (cond
    [(zero? n) 0]
    [(= n 1) 1]
    [else (+ (fib-recursive (sub1 n)) (fib-recursive (- n 2)))]
    )
  )

(define (fib-iterative n)
  ; Пазим двойка последователни числа на Фибоначи (current, next) и на всяка
  ; стъпка я местим с една позиция напред: (F(k), F(k + 1)) -> (F(k + 1), F(k + 2)).
  ; След n стъпки current е F(n).
  (define (helper current next remaining)
    (if (zero? remaining)
        current
        (helper next (+ current next) (sub1 remaining))
        )
    )
  (helper 0 1 n)
  )

(= (fib-recursive 12) 144)

(= (fib-iterative 12) 144)