(import (rnrs exceptions))
;;the following automaton works on the alphabet {a, b} and accepts every string
;;that starts and ends with the same letter.
;;in the book, the states are numbered/named as s, q1, q2, r1, r2 (with q1 and r1 being
;;accept states). here, i've numbered them 0, 1, 2, 3, 4 respectively (with 1 and 3 being 
;;accept states):

(display "Welcome to M4! This automaton expects a string consisting of the letters a and b and")
(display "\naccepts strings starting and ending with the same letter. Have fun!")

(define (m4-aux string current-state)
    (cond
        ((equal? (string->list string) '())
            (if (or (= current-state 1) (= current-state 3))
                (display "this string has been accepted!")
                (display "this string has been rejected!")))
        ((equal? (car (string->list string)) #\a)
            (cond
                ((or (= current-state 1) (= current-state 2))
                    (m4-aux (list->string (cdr (string->list string))) 1))
                ((or (= current-state 3) (= current-state 4))
                    (m4-aux (list->string (cdr (string->list string))) 3))
                (else ;;we are in the start (a.k.a. 0) state
                    (m4-aux (list->string (cdr (string->list string))) 1))))
        ((equal? (car (string->list string)) #\b)
            (cond
                ((or (= current-state 1) (= current-state 2))
                    (m4-aux (list->string (cdr (string->list string))) 2))
                ((or (= current-state 3) (= current-state 4))
                    (m4-aux (list->string (cdr (string->list string))) 4))
                (else
                    (m4-aux (list->string (cdr (string->list string))) 3))))
        (else
            (raise
                (condition
                    (make-error)
                    (make-message-condition "the string must contain only 1s or 0s!"))))))

(define (m4 string)
    (cond
        ((string? string)
            (m4-aux string 0))
        (else
            (raise
                (condition
                    (make-error)
                    (make-message-condition "this automaton expects a string!"))))))
