(display "Welcome to N1! this automaton expects a string consisting of 1s and 0s and")
(display "\naccepts every string representing a binary number that is a multiple of 3. have fun!")

(define (n1-aux string current-state)
    (cond
        ((equal? (string->list string) '())
            (if (= current-state 0)
                (display "this string has been accepted!")
                (display "this string has been rejected.")))
        ((equal? (car (string->list string)) #\0)
            (cond
                ((= current-state 0)
                    (n1-aux (list->string (cdr (string->list string))) 0))
                ((= current-state 1)
                    (n1-aux (list->string (cdr (string->list string))) 2))
                ((= current-state 2)
                    (n1-aux (list->string (cdr (string->list string))) 1))))
        ((equal? (car (string->list string)) #\1)
            (cond
                ((= current-state 0)
                    (n1-aux (list->string (cdr (string->list string))) 1))
                ((= current-state 1)
                    (n1-aux (list->string (cdr (string->list string))) 0))
                ((= current-state 2)
                    (n1-aux (list->string (cdr (string->list string))) 2))))
        (else
            (raise
                (condition
                    (make-error)
                    (make-message-condition "the string must only contain 1s or 0s!"))))))


(define (n1 string)
    (cond
        ((string? string)
            (n1-aux string 0))
        (else
            (raise
                (condition
                    (make-error)
                    (make-message-condition "this automaton expects a string!"))))))