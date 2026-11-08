#lang racket

; "Обект" в стил message passing: make-scoreboard връща процедура dispatch, която затваря
; (closure) вътрешната променлива points. Отвън до points не може да се стигне - единственият
; начин да я прочетем или променим е през съобщенията, които dispatch разбира.
(define (make-scoreboard)
  (define points '())

  (define (get name)
    (let ([pair (assoc name points)])
      (if pair (cdr pair) 0)
      )
    )

  ; Асоциативният списък е неизменим, затова строим нов - без старата двойка на пилота
  ; (remove на #f не прави нищо, ако го няма) и с новата отпред - и го записваме със set!.
  (define (add name n)
    (set! points (cons (cons name (+ (get name) n)) (remove (assoc name points) points)))
    )

  (define (standings)
    (sort points (λ (a b) (> (cdr a) (cdr b))))
    )

  (define (leader)
    (if (empty? points) #f (car (car (standings))))
    )

  (define (reset)
    (set! points '())
    )

  (define (dispatch message)
    (cond
      [(eq? message 'add) add]
      [(eq? message 'get) get]
      [(eq? message 'leader) leader]
      [(eq? message 'standings) standings]
      [(eq? message 'reset) reset]
      [else (error "make-scoreboard: unknown message" message)]
      )
    )

  dispatch
  )

(define board (make-scoreboard))

(equal? ((board 'leader)) #f)
(equal? ((board 'standings)) '())
(begin ((board 'add) "Verstappen" 25) (= ((board 'get) "Verstappen") 25))
(begin ((board 'add) "Verstappen" 18) ((board 'add) "Norris" 25) (= ((board 'get) "Verstappen") 43))
(= ((board 'get) "Norris") 25)
(= ((board 'get) "Hamilton") 0)
(equal? ((board 'leader)) "Verstappen")
(equal? ((board 'standings)) '(("Verstappen" . 43) ("Norris" . 25)))
(begin ((board 'add) "Norris" 25) (equal? ((board 'leader)) "Norris"))

; Всяко извикване на make-scoreboard създава нова, независима променлива points.
(define board-2 (make-scoreboard))

(begin ((board-2 'add) "Leclerc" 10) (and (= ((board-2 'get) "Leclerc") 10) (= ((board 'get) "Leclerc") 0)))
(= ((board-2 'get) "Verstappen") 0)

(begin ((board 'reset)) (equal? ((board 'leader)) #f))
(= ((board 'get) "Verstappen") 0)
(= ((board-2 'get) "Leclerc") 10)
