#lang racket

; Четене от файл: отваряме входен порт, четем ред по ред с read-line, докато
; не получим eof (проверяваме с eof-object?), и накрая задължително затваряме порта.
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

(display-file-content "test.txt") ; пътят е спрямо текущата директория
