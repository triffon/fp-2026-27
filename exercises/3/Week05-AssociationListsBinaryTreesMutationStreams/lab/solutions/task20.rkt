#lang racket

(require racket/runtime-path)

; Пътят се определя спрямо файла, в който е написан, а не спрямо текущата директория.
(define-runtime-path this-file "task20.rkt")

(define (display-file-content path)
  (define input-port (open-input-file path))
  (define (helper current-line)
    (if (eof-object? current-line)
        (begin
          (close-input-port input-port)
          (displayln "<EOF>")
          )
        (begin
          (displayln current-line)
          (helper (read-line input-port))
          ))
    )
  (helper (read-line input-port))
  )

(display-file-content this-file)
