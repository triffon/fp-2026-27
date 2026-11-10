#lang racket

(define (root bt) (car bt))
(define (left-subtree bt) (cadr bt))
(define (right-subtree bt) (caddr bt))

(define (leaf? bt)
  (and (empty? (left-subtree bt)) (empty? (right-subtree bt)))
  )

(define (height bt)
  (if (empty? bt) 0 (add1 (max (height (left-subtree bt)) (height (right-subtree bt)))))
  )

; Двамата са играли помежду си точно когато има вътрешен възел, чиито две деца имат
; корени p1 и p2 (в някакъв ред). Листата са на височина 1, мачовете от кръг 1 - на
; височина 2 и т.н., т.е. номерът на кръга е височината на възела минус 1.
(define (met-in p1 p2 draw)
  (cond
    [(or (empty? draw) (leaf? draw)) #f]
    [(let ([l (root (left-subtree draw))]
           [r (root (right-subtree draw))])
       (or (and (equal? l p1) (equal? r p2))
           (and (equal? l p2) (equal? r p1))))
     (sub1 (height draw))]
    [else (or (met-in p1 p2 (left-subtree draw)) (met-in p1 p2 (right-subtree draw)))]
    )
  )

; Схемата на Rolex Paris Masters 2026 от четвъртфиналите нататък.
(define draw '("Alcaraz" ("Shelton" ("Van Assche" ("Van Assche" () ())
                                                  ("Hijikata" () ()))
                                    ("Shelton" ("Shelton" () ())
                                               ("Paul" () ())))
                         ("Alcaraz" ("Ruud" ("Ruud" () ())
                                            ("Borges" () ()))
                                    ("Alcaraz" ("Fritz" () ())
                                               ("Alcaraz" () ())))))

(equal? (met-in "Van Assche" "Hijikata" draw) 1)
(equal? (met-in "Alcaraz" "Fritz" draw) 1)
(equal? (met-in "Shelton" "Van Assche" draw) 2)
(equal? (met-in "Alcaraz" "Shelton" draw) 3)
(equal? (met-in "Paul" "Alcaraz" draw) #f)
(equal? (met-in "Hijikata" "Paul" draw) #f)
(equal? (met-in "Buse" "Borges" '("Borges" ("Borges" () ()) ("Buse" () ()))) 1)
(equal? (met-in "Alcaraz" "Shelton" '()) #f)
