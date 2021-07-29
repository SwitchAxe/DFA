(import (rnrs exceptions))
(display "Welcome to M5! this automaton expects a string consisting of nonnegative integers")
(display "\n 0, 1, 2 and the 'r' (reset) symbol.")
(display "\nIt accepts the string if the sum of its digits is a multiple of 3. Every time")
(display "\nit meets the 'r' symbol the automaton resets the count to 0. Have fun!")


(define (m5-aux string current-state)
    (cond
        ((equal? (string->list string) '())
            (if (= current-state 0)
                (display "this string has been accepted!")
                (display "this string has been rejected.")))
        ((equal? (car (string->list string)) #\0)
            (m5-aux (list->string (cdr (string->list string))) current-state))
        ((equal? (car (string->list string)) #\1)
            (if (= current-state 2)
                (m5-aux (list->string (cdr (string->list string))) 0)
                (m5-aux (list->string (cdr (string->list string))) (+ current-state 1))))
        ((equal? (car (string->list string)) #\2)
            (if (= current-state 0)
                (m5-aux (list->string (cdr (string->list string))) 2)
                (m5-aux (list->string (cdr (string->list string))) (- current-state 1))))
        ((equal? (car (string->list string)) #\r)
            (m5-aux (list->string (cdr (string->list string))) 0))
        (else
            (raise
                (condition
                    (make-error)
                    (make-message-condition "pay close attention to the permitted symbols!"))))))


(define (m5 string)
    (cond
        ((string? string)
            (m5-aux string 0))
        (else
            (raise
                (condition
                    (make-message)
                    (make-message-condition "this automaton expects a string!"))))))