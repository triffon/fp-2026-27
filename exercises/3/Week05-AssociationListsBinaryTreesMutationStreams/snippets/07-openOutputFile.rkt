#lang racket

; Писане във файл: отваряме изходен порт и го подаваме като втори аргумент на display.
; По подразбиране open-output-file дава грешка, ако файлът вече съществува;
; с #:exists 'replace го презаписваме.
(define output-port (open-output-file "output.txt" #:exists 'replace))

(define content "This is some content that will be written to the file.\nAnother line here.")

(display content output-port)

; Без затваряне на порта част от съдържанието може да не стигне до файла.
(close-output-port output-port)
