#lang racket

; delay създава "обещание" (promise) - отложено пресмятане на израза (* 2 3).
(delay (* 2 3))

; force пресмята обещанието и връща стойността му; резултатът се запомня,
; така че при повторно force изразът не се пресмята отново.
(force (delay (* 2 3)))

(define empty-stream '())

; Поток: двойка от глава (вече пресметната) и опашка, която е обещание.
; cons-stream трябва да е макрос, а не процедура - иначе опашката t би се
; пресметнала още при извикването, преди да стигне до delay.
(define-syntax cons-stream
  (syntax-rules ()
    ((cons-stream h t) (cons h (delay t)))
  ))

(define s (cons-stream 1 (cons-stream 2 (cons-stream 3 empty-stream))))
s ; '(1 . #<promise>) - вторият елемент още не е пресметнат

; Безкраен поток от стойността v - рекурсията не зацикля, защото
; рекурсивното извикване е вътре в delay и се прави само при поискване.
(define (repeat v)
  (cons-stream v (repeat v)))

(repeat 5) ; '(5 . #<promise>) - само първият елемент е пресметнат

(define head car)

; tail "отваря" обещанието и ни мести с един елемент напред в потока.
(define (tail s)
  (force (cdr s)))

(head (repeat 5)) ; 5

; Първите n елемента на потока като обикновен списък. Всяко tail
; пресмята точно по един следващ елемент - затова работи и за безкрайни потоци.
(define (stream-take n stream)
  (if (or (zero? n) (empty? stream))
      '()
      (cons (head stream) (stream-take (sub1 n) (tail stream)))))

(stream-take 5 (repeat 5)) ; '(5 5 5 5 5)

; force запомня резултата: изразът вътре в delay се пресмята само при първото force.
(define p (delay (begin (displayln "computing...") 42)))
(force p) ; отпечатва "computing..." и връща 42
(force p) ; 42 - без "computing..." - стойността е взета от паметта

; Защо cons-stream не може да е процедура: аргументите на процедура се оценяват
; ПРЕДИ тялото ѝ, така че (bad-repeat 5) би оценило (bad-repeat 5) отново, и отново...
; - безкрайна рекурсия, без изобщо да се стигне до delay.
(define (bad-cons-stream h t) (cons h (delay t)))
(define (bad-repeat v) (bad-cons-stream v (bad-repeat v)))
; (bad-repeat 5) ; никога не приключва - затова е коментирано
