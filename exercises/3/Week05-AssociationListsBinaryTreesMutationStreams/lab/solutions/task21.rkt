#lang racket

; Четем 4-байтово число без знак, записано little-endian, от позиция pos.
(define (read-uint32 data pos)
  (integer-bytes->integer (subbytes data pos (+ pos 4)) #f #f)
  )

(define (grayscale r g b)
  (quotient (+ r g b) 3)
  )

; Всеки ред от матрицата е допълнен (padding) до брой байтове, кратен на 4.
(define (row-size width)
  (* 4 (ceiling (/ (* 3 width) 4)))
  )

; Променяме пикселите на място с bytes-set! - метаданните остават същите,
; защото размерът на изображението не се променя.
(define (convert-to-grayscale! data)
  (define pixels-offset (read-uint32 data 10))
  (define width (read-uint32 data 18))
  (define height (read-uint32 data 22))
  (define (convert-pixel! pos)
    (define gray (grayscale (bytes-ref data (+ pos 2)) (bytes-ref data (+ pos 1)) (bytes-ref data pos)))
    (bytes-set! data pos gray)
    (bytes-set! data (+ pos 1) gray)
    (bytes-set! data (+ pos 2) gray)
    )
  (for* ([i (in-range height)]
         [j (in-range width)])
    ; Байтовете в падинга пропускаме - те не са част от нито един пиксел.
    (convert-pixel! (+ pixels-offset (* i (row-size width)) (* 3 j)))
    )
  )

(define (rgb->grayscale input-path output-path)
  (define data (bytes-copy (file->bytes input-path)))
  (convert-to-grayscale! data)
  (define output-port (open-output-file output-path #:exists 'replace))
  (write-bytes data output-port)
  (close-output-port output-port)
  )

; Пример: racket task21.rkt dimitrov.bmp grayscale.bmp
(define args (current-command-line-arguments))
(if (= (vector-length args) 2)
    (rgb->grayscale (vector-ref args 0) (vector-ref args 1))
    (displayln "Usage: racket task21.rkt <input.bmp> <output.bmp>")
    )
