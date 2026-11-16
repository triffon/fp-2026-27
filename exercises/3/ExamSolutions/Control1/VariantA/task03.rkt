#lang racket

(define (leaf? draw) (string? draw))
(define (left-subtree draw) (car draw))
(define (right-subtree draw) (cdr draw))

(define (height draw)
  (if (leaf? draw) 0 (add1 (max (height (left-subtree draw)) (height (right-subtree draw)))))
  )

(define (participates? p draw)
  (if (leaf? draw)
      (equal? p draw)
      (or (participates? p (left-subtree draw)) (participates? p (right-subtree draw)))
      )
  )

; Двамата играчи се срещат във възела, в който "се разделят" - единият е в лявото поддърво,
; а другият в дясното. Слизаме натам, където са и двамата, и броим дълбочината.
; Срещите между най-дълбоките листа (дълбочина height - 1) са кръг 1, а финалът (дълбочина 0)
; е кръг height, т.е. среща на дълбочина d е в кръг height - d.
(define (would-meet-in p1 p2 draw)
  (define (helper draw depth)
    (define left (left-subtree draw))
    (cond
      [(and (participates? p1 left) (participates? p2 left)) (helper left (add1 depth))]
      [(or (participates? p1 left) (participates? p2 left)) depth]
      [else (helper (right-subtree draw) (add1 depth))]
      )
    )
  (and (participates? p1 draw)
       (participates? p2 draw)
       (- (height draw) (helper draw 0)))
  )

; Бонус
(define (players draw)
  (if (leaf? draw)
      (list draw)
      (append (players (left-subtree draw)) (players (right-subtree draw)))
      )
  )

; Самият p не е свой съперник, затова го изключваме преди да викнем would-meet-in.
(define (opponents-in-round p n draw)
  (filter (λ (q) (and (not (equal? p q)) (equal? (would-meet-in p q draw) n))) (players draw))
  )

(define draw '((("Federer" . "Dimitrov") . ("Nadal" . "Murray")) .
               (("Djokovic" . "Medvedev") . ("Alcaraz" . "Sinner"))))

(equal? (would-meet-in "Nadal" "Dimitrov" draw) 2)
(equal? (would-meet-in "Dimitrov" "Sinner" draw) 3)
(equal? (would-meet-in "Federer" "Dimitrov" draw) 1)
(equal? (would-meet-in "Dimitrov" "Thiem" draw) #f)
(equal? (would-meet-in "A" "B" '("A" . ("B" . "C"))) 2) ; "A" почива в кръг 1

(equal? (opponents-in-round "Nadal" 1 draw) '("Murray"))
(equal? (opponents-in-round "Nadal" 2 draw) '("Federer" "Dimitrov"))
(equal? (opponents-in-round "Nadal" 3 draw) '("Djokovic" "Medvedev" "Alcaraz" "Sinner"))
(equal? (opponents-in-round "Thiem" 1 draw) '())
