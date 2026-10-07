#lang racket

; Зад.0
; (3 + 5)/2 + sqrt(4^3 - 7*2^2)
(define e1 (+ (/ (+ 3 5) 2)
              (sqrt (- (expt 4 3) (* 7 (expt 2 2))))))
; (5 + 1/4 + (2 - (3 - (6 + 1/5)))) / 3(6 - 2)(2 - 7)
(define e2 (/ (+ 5 (/ 1 4) (- 2 (- 3 (+ 6 (/ 1 5)))))
              (* 3 (- 6 2) (- 2 7))))
; (15 + 21 + (3 / 15) + (7 - (2 * 2))) / 16
(define e3 (/ (+ 15 21 (/ 3 15) (- 7 (* 2 2))) 16))

; Зад.1
(define (f1 x y)
  (if (< y 0)
      ; няма нужда от (if ... #t #f), може просто да върнем резултата от and
      (and (>= x -1) (<= x 1) (>= y -1))
      (< (+ (* x x) (* y y)) 4)))

(define (f2 x y)
  ; "вътрешната" функция вижда аргументите на външната
  (define (is-in-square? sx sy)
    (and (>= x sx) (<= x (+ sx 1))
         (>= y sy) (<= y (+ sy 1))))
  (or (is-in-square? -1 -1)
      (is-in-square? 0 0)
      (is-in-square? 1 1)))

; Зад.2
(define (fact n)
  (if (= n 1) 1
      (* n (fact (- n 1)))))

; Зад.3
(define (fib n)
  (cond ;[(not (integer? n)) #f] ; честа практика е връщане на #f при грешка
        ;[(< n 0) #f]
        [(= n 0) 0]
        [(= n 1) 1]
        [else (+ (fib (- n 1)) (fib (- n 2)))]))

;(define (fib n)
;  (if (< n 2)
;      n
;      (+ (fib (- n 1)) (fib (- n 2)))))

; Зад.4
(define (sum-interval a b)
  ; по-удачно е да изпозлваме празния,
  ; "невалиден" интервал за дъно на рекурсията
  (if (> a b)
      0
      (+ a (sum-interval (+ a 1) b))))

; Зад.5
(define (count-digits n)
  (if (< n 10)
      1 ; дъно - всички едноцифрени числа, не само 0
      (+ 1 (count-digits (quotient n 10)))))

; значително по-неудобно е да взимаме първата цифра на дадено число
(define (first-digit n)
  (quotient n (expt 10 (- (count-digits n) 1))))

; Зад.6
; Проблем: всеки път преизчисляваме броя на цифрите на n,
; когато на всяко следващо извикване той е със сигурност с 1 по-малко
; от броя по време на предишното извикване
(define (reverse-digits n)
  (if (< n 10)
      n
      (+ (reverse-digits (quotient n 10))
         (* (remainder n 10)
            (expt 10 (- (count-digits n) 1))))))

; Решение: "пазим" го като допълнителен аргумент на помощна функция
; Това е "инвариант" на тази функция: count винаги е точно броят цифри на n
; Забележете, че логиката не се е променила.
(define (reverse-digits-helper n count)
  (if (< n 10)
      n
      (+ (reverse-digits-helper (quotient n 10) (- count 1))
         (* (remainder n 10)
            (expt 10 (- count 1))))))

; Новата "основна" функция само смята броя цифри веднъж
; и оставя всичката логика на помощната функция
(define (reverse-digits* n)
  (reverse-digits-helper n (count-digits n)))

; Зад.7 е най-трудната
(define (palindrome? n)
  (= n (reverse-digits* n)))
