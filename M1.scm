(define (m1-aux string current-state)
    (cond 
        ((equal? (string->list string) '())
            (if (= current-state 1)
                (display "this string has been accepted!")
                (display "this string has been rejected.")))
        ((equal? (car (string->list string)) #\0)
        ;;the first character in the remaining string is a '0', and 
        ;;we need to check for the state the automaton is currently in:
            (cond 
                ((= current-state 0) 
                    (m1-aux (list->string (cdr (string->list string))) 0))
                ((= current-state 1)
                    (m1-aux (list->string (cdr (string->list string))) 2))
                ((= current-state 2)
                    (m1-aux (list->string (cdr (string->list string))) 1))))   
        ((equal? (car (string->list string)) #\1)
            ;;the first character in the remaining string is a '1', and
            ;;we need to check for the state the automaton is currently in:
            (cond
                ((= current-state 0)
                    (m1-aux (list->string (cdr (string->list string))) 1))
                ((= current-state 1)
                    (m1-aux (list->string (cdr (string->list string))) 1))
                ((= current-state 2)
                    (m1-aux (list->string (cdr (string->list string))) 1))))
        (else
            (raise 
				(condition
					(make-error)
					(make-message-condition
						"the string must only contain 1s or 0s!")))))

(define (m1 string)
    (m1-aux string 0))
