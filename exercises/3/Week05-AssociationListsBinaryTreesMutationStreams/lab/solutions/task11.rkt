#lang racket

(define our-cool-tree '(1 (2 () ())
                          (3 (4 () ())
                             (5 () ()))))

(define (root bt) (car bt))
(define (left-subtree bt) (cadr bt))
(define (right-subtree bt) (caddr bt))

; (comparator a b) е #t, когато a трябва да е "преди" b, т.е. a е по-малкото.
(define (min2 comparator a b)
  (if (comparator a b) a b)
  )

(define (min3 comparator a b c)
  (min2 comparator (min2 comparator a b) c)
  )

; Празно поддърво няма най-малък елемент, затова го пропускаме и сравняваме
; корена само с минимумите на непразните поддървета.
(define (min comparator bt)
  (cond
    [(empty? bt) (error "Empty tree")]
    [(and (empty? (left-subtree bt)) (empty? (right-subtree bt))) (root bt)] ; листо
    [(empty? (left-subtree bt)) (min2 comparator (root bt) (min comparator (right-subtree bt)))] ; само дясно поддърво
    [(empty? (right-subtree bt)) (min2 comparator (root bt) (min comparator (left-subtree bt)))] ; само ляво поддърво
    [else (min3 comparator (root bt) (min comparator (left-subtree bt)) (min comparator (right-subtree bt)))]
    )
  )

; Същият компаратор, но връщаме другия елемент.
(define (max2 comparator a b)
  (if (comparator a b) b a)
  )

(define (max3 comparator a b c)
  (max2 comparator (max2 comparator a b) c)
  )

(define (max comparator bt)
  (cond
    [(empty? bt) (error "Empty tree")]
    [(and (empty? (left-subtree bt)) (empty? (right-subtree bt))) (root bt)] ; листо
    [(empty? (left-subtree bt)) (max2 comparator (root bt) (max comparator (right-subtree bt)))] ; само дясно поддърво
    [(empty? (right-subtree bt)) (max2 comparator (root bt) (max comparator (left-subtree bt)))] ; само ляво поддърво
    [else (max3 comparator (root bt) (max comparator (left-subtree bt)) (max comparator (right-subtree bt)))]
    )
  )

; Алтернативно решение: първо събираме елементите на дървото в списък (обхождане ляво-корен-дясно),
; а после ги "свиваме" с foldl, пазейки текущо най-малкия елемент - така не ни трябват
; min2/min3 и отделни случаи за празни поддървета.
(define (elements bt)
  (if (empty? bt)
      '()
      (append (elements (left-subtree bt)) (list (root bt)) (elements (right-subtree bt)))
      )
  )

(define (min-foldl comparator bt)
  (let ([xs (elements bt)])
    (foldl (λ (x acc) (if (comparator x acc) x acc)) (car xs) (cdr xs))
    )
  )

; Алтернативно решение: същата идея с foldl, само че пазим елемента, който е "след" текущия.
(define (max-foldl comparator bt)
  (let ([xs (elements bt)])
    (foldl (λ (x acc) (if (comparator acc x) x acc)) (car xs) (cdr xs))
    )
  )


(= (min < our-cool-tree) 1)
(= (max < our-cool-tree) 5)
(= (min-foldl < our-cool-tree) 1)
(= (max-foldl < our-cool-tree) 5)
