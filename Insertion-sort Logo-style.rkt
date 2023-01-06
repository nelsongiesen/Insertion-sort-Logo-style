; How to use the sorter.
; We start with a Scheme dialect REPL.
; A REPL is the same type of instant interpretter that Python uses. But we need the one for Scheme dialect.
; Any of them will work, but I use the Dr.Racket REPL from the PLT team at Northeastern University and Brown University.
; We copy these definitions into the definitions window and hit run.
; We are ready to run the sorter in the interactions window.
; But the sorter wants a list: so we activate it like this (quick-sort (list 3 2 1 6 5 4 9 8 7)).
; The inside parentheses create a list and the outside parentheses run the sorter on that list.
; You can have much fun testing and tinkering with it.

               ; Insert is a program that takes an item and a sorted list. It puts the item into the list where it fits.
               ; We use a helper program with two lists:
               ; A list that tracks the part-before the item.
               ; And a list that tracks the part-after the item.
               ; If the item is less than the first item of the part-after, then it is in the right spot.
               ; We just put the lists back together with the item in the middle and we are done. 
               ; Otherwise, we move the first item of part-after to the end of part-before and try again.
               ; The other way we will know we are done is if the part-after is empty. That means everything was less than the item.
               ; We just add the item to the end of the part-before and we are done.
(define insert 
  (lambda (item sorted-ls) 
    (letrec ((helper 
              (lambda (part-before part-after) 
                       (if (empty? part-after) 
                           (add-to-end part-before item) ; If the answer is yes, we return part-before with item added to its end. Done. EXIT.
                           (let ((firsty (first part-after))) 
                             (if (less-than? item firsty) 
                                 (combine (add-to-end part-before item) ; If the answer is yes, we add item to the end of part-before,
                                          part-after) ; and we combine that with part after and we return that. And we are done. EXIT.
                                 (helper (add-to-end part-before firsty) 
                                         (without-first part-after)))))))) 
      (helper empty-list sorted-ls)))) ; This is the initialization line. We start helper with its original inputs.
                                       ; We start part-before as an empty-list.
                                       ; And we start part-after starts as sorted-ls.

                       ; Insertion-sort takes an unsorted list and returns a sorted list.
                       ; We use the Insert program to sort the items, one at a time.
                       ; We make a helper program to keep track of the part that has already been sorted.
                       ; The helper program moves the items one at a time from the unsorted-list to the sorted-list.
                       ; We know we are done when the unsorted-list is empty.
(define insertion-sort 
  (lambda (input-ls) 
    (letrec ((helper 
              (lambda (unsorted-list sorted-list) 
                (if (empty? unsorted-list) 
                    sorted-list ; If the answer is yes, we return sorted-list and we are done. EXIT.
                    (let ((item (first unsorted-list))) 
                     (helper 
                       (without-first unsorted-list) 
                       (insert item sorted-list)))))))
      (helper input-ls empty-list)))) ; This is the initialization line, it starts helper with its original inputs,
                                      ; We start unsorted-list as input-ls.
                                      ; And we start sorted-list as an empty-list.

; These are the Scheme-dialect programs that are renamed in Logo-style.
; They do the exact same thing in Scheme-dialect, we just thought Logo-style names were closer to natural English: and funnier for a beginner.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define first car)
(define without-first cdr)
(define add-to-end
  (lambda (ls item)
    (combine ls (listify item))))
(define combine append)
(define listify list)
(define empty? null?)
(define less-than? <)
(define more-than? >)
(define empty-list '())

; These next ones are alternate spelling of the previous ones.
(define first-item first)
(define frist first)
(define without-first-item without-first)
(define remove-first without-first)
(define remove-first-item without-first)
(define without-frist-item without-first)
(define remove-frist-item without-first)
(define combine-lists combine)
(define add-item-to-end-of-list add-to-end)






























