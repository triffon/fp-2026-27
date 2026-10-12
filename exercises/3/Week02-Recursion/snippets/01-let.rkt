#lang racket

(define (help-gosho breakfast+lunch)
  (let ([dinner (- 8 breakfast+lunch)])
  (cond
    [(and (>= dinner 5) (<= dinner 8)) "Pizza"]
    [(>= dinner 2.5) "Doner"]
    [(>= dinner 1.5) "University cafeteria"]
    [else "Hungry :'("]
    ))
  )

(equal? (help-gosho 0) "Pizza")
(equal? (help-gosho 4) "Doner")
(equal? (help-gosho 5.6) "University cafeteria")