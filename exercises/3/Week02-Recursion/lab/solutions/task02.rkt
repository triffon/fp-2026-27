#lang racket

(define (help-galena new-views lost-views desired-views)
  ; Проверяваме всяка вечер, след като гледанията са се увеличили.
  ; days - кой ден е, views - гледанията в края на този ден.
  (define (helper days views)
    (if (>= views desired-views)
        days
        (helper (add1 days) (+ new-views (- views lost-views)))
        )
    )
  ; В края на първия ден клипът има точно new-views гледания.
  (helper 1 new-views)
  )

(= (help-galena 100000 10000 910000) 10)
