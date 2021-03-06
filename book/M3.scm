(import (rnrs exceptions))

(display "Welcome to M3! This automaton expects a string consisting of 1s and 0s, and\n")
(display "accepts all the strings ending with a 0 OR the empty string. Have fun!")

(define (m3-aux string current-state)
    (cond
        ((equal? (string->list string) '())
            (if (equal? current-state 0)
                (display "this string has been accepted!")
                (display "this string has been rejected.")))
        ((equal? (car (string->list string)) #\0)
            ;;the output state of the state transition function doesn't change if
            ;;we're in state 0 rather than state 1, so considered the fact that i
            ;;call the exact same function with the exact same input arguments 
            ;;in both cases i can just skip the conditional operator:
            (m3-aux (list->string (cdr (string->list string))) 0))
        ((equal? (car (string->list string)) #\1)
            ;;the exact same thing happens here:
            (m3-aux (list->string (cdr (string->list string))) 1))
        (else
            (raise 
                (condition
                    (make-error)
                    (make-message-condition "the string must contain only 1s or 0s!"))))))

(define (m3 string)
    (cond
        ((string? string)
            (m3-aux string 0))
        (else
            (raise 
                (condition
                    (make-error)
                    (make-message-condition "this automaton expects a string!"))))))