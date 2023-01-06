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
(define insert ; We use define to create a program, in this case we name it insert.
  (lambda (item sorted-ls) ; We use lambda to name our inputs: in this case we have two named item and sorted-ls.
    (letrec ((helper ; We use letrec to create helper programs. In this case we have one named helper.
              (lambda (part-before part-after) ; We use lambda to name helper's inputs, in this case we have two part-before and part-after.
                       (if ; We use if to set up a fork in the road.
                        (empty? part-after) ; We use empty? to ask if part-after is empty.
                           (add-to-end part-before item) ; If the answer is yes, we return part-before with item added to its end. Done. EXIT.
                           (let ; If the answer is no, we use let to create local variables. In this case we have one named firsty.
                               ((firsty (first part-after))) ; We assign firsty to the first item of part-after.
                             (if ; We use another if to set up another fork in the road.
                              (less-than? item firsty) ; We use less-than? to ask if item is less than firsty.
                                 (combine (add-to-end part-before item) ; If the answer is yes, we add item to the end of part-before,
                                          part-after) ; and we combine that with part after and we return that. And we are done. EXIT.
                                 (helper ; If the answer is no, we run helper again with different inputs.
                                  (add-to-end part-before firsty) ; We change part-before by adding firsty to its end.
                                  (without-first part-after)))))))) ; We change part-after by removing its first item.
      (helper empty-list sorted-ls)))) ; This is the initialization line. We start helper with its original inputs.
                                       ; We start part-before as an empty-list.
                                       ; And we start part-after starts as sorted-ls.

                       ; Insertion-sort takes an unsorted list and returns a sorted list.
                       ; We use the Insert program to sort the items, one at a time.
                       ; We make a helper program to keep track of the part that has already been sorted.
                       ; The helper program moves the items one at a time from the unsorted-list to the sorted-list.
                       ; We know we are done when the unsorted-list is empty.
(define insertion-sort ; We use define to create a program, in this case we name it insertion-sort.
  (lambda (input-ls) ; We use lambda to name our inputs, in this case we have one named input-ls.
    (letrec ((helper ; We use letrec to create helper programs, in this case we have one named helper.
              (lambda (unsorted-list sorted-list) ; We use lambda to name helper's inputs, in this case we have unsorted-list and sorted-list.
                (if ; We use if to set up a fork in the road.
                 (empty? unsorted-list) ; We use empty? to ask if unsorted-list is empty.
                    sorted-list ; If the answer is yes, we return sorted-list and we are done. EXIT.
                    (let ; If the answer is no, we use let to create local variables: in this case we have one named item.
                      ((item (first unsorted-list))) ; We assign item to the first item of the unsorted-list.
                     (helper ; We run helper again with different inputs.
                       (without-first unsorted-list) ; We change unsorted-list by removing its first item.
                       (insert item sorted-list))))))); We change sorted-list by inserting item into it.
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






























