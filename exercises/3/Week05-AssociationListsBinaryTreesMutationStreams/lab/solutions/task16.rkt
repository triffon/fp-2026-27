#lang racket

; Схемата на турнира е двоично дърво: листата са играчите, всеки вътрешен възел е
; победителят от мача между двете си деца, а коренът е шампионът.
(define draw '("Sinner" ("Sinner" ("Sinner" ("Sinner" () ())
                                            ("Medvedev" () ()))
                                  ("Dimitrov" ("Dimitrov" () ())
                                              ("Zverev" () ())))
                        ("Alcaraz" ("Alcaraz" ("Alcaraz" () ())
                                              ("Rune" () ()))
                                   ("Djokovic" ("Djokovic" () ())
                                               ("Tsitsipas" () ())))))

; Невалидна схема: в корена е "Sinner", но нито едно от децата му не е "Sinner".
(define invalid-draw '("Sinner" ("Medvedev" () ())
                                ("Alcaraz" () ())))

(define (root bt) (car bt))
(define (left-subtree bt) (cadr bt))
(define (right-subtree bt) (caddr bt))

(define (leaf? bt)
  (and (not (empty? bt)) (empty? (left-subtree bt)) (empty? (right-subtree bt)))
  )

(define (champion draw) (root draw))

; Играчите са листата на дървото (отляво надясно) - точно както в Задача 12.
(define (players draw)
  (cond
    [(empty? draw) '()]
    [(leaf? draw) (list (root draw))]
    [else (append (players (left-subtree draw)) (players (right-subtree draw)))]
    )
  )

; Всеки вътрешен възел трябва да има две непразни деца и стойността му да съвпада
; с тази на едно от тях (победителят идва от някой от двата мача под него).
(define (valid-draw? draw)
  (or (empty? draw)
      (leaf? draw)
      (and (not (empty? (left-subtree draw)))
           (not (empty? (right-subtree draw)))
           (or (equal? (root draw) (root (left-subtree draw)))
               (equal? (root draw) (root (right-subtree draw))))
           (valid-draw? (left-subtree draw))
           (valid-draw? (right-subtree draw)))
      )
  )

; Ако коренът е player и възелът не е листо, player е спечелил този мач срещу корена на
; детето, в което НЕ е той. По-ранните му победи са в детето, чийто корен Е той.
; Ако коренът не е player, търсим го надолу - той е само в едно от двете поддървета,
; така че append-ът на двата резултата е просто списъкът от това поддърво.
(define (opponents player draw)
  (cond
    [(empty? draw) '()]
    [(leaf? draw) '()]
    [(equal? (root draw) player)
     (let* (
            [left (left-subtree draw)]
            [right (right-subtree draw)]
            [winner-side (if (equal? (root left) player) left right)]
            [loser-side (if (equal? (root left) player) right left)]
            )
       (append (opponents player winner-side) (list (root loser-side)))
       )]
    [else (append (opponents player (left-subtree draw)) (opponents player (right-subtree draw)))]
    )
  )

; Търсим вътрешен възел, чийто корен не е player, но едно от децата му има корен player -
; това е мачът, който player е загубил. За шампиона такъв възел няма и стигаме до #f.
(define (eliminated-by player draw)
  (cond
    [(or (empty? draw) (leaf? draw)) #f]
    [(and (not (equal? (root draw) player))
          (or (equal? (root (left-subtree draw)) player)
              (equal? (root (right-subtree draw)) player)))
     (root draw)]
    [else (or (eliminated-by player (left-subtree draw))
              (eliminated-by player (right-subtree draw)))]
    )
  )

(equal? (champion draw) "Sinner")
(equal? (players draw) '("Sinner" "Medvedev" "Dimitrov" "Zverev" "Alcaraz" "Rune" "Djokovic" "Tsitsipas"))
(equal? (valid-draw? draw) #t)
(equal? (valid-draw? invalid-draw) #f)
(equal? (valid-draw? '("Sinner" ("Sinner" () ()) ())) #f)
(equal? (valid-draw? '()) #t)
(equal? (opponents "Sinner" draw) '("Medvedev" "Dimitrov" "Alcaraz"))
(equal? (opponents "Dimitrov" draw) '("Zverev"))
(equal? (opponents "Alcaraz" draw) '("Rune" "Djokovic"))
(equal? (opponents "Tsitsipas" draw) '())
(equal? (eliminated-by "Dimitrov" draw) "Sinner")
(equal? (eliminated-by "Alcaraz" draw) "Sinner")
(equal? (eliminated-by "Tsitsipas" draw) "Djokovic")
(equal? (eliminated-by "Sinner" draw) #f)
