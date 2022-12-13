; How to use the sorter:
; We use parentheses to run programs.
; But the sorter takes a list as its input.
; So we run the sorter like this: (insertion-sort (listify 3 2 1 6 5 4 9 8 7))
; The inside parentheses create a list.
; And the outside parentheses run the insertion-sort program on the list.
; If you type that into any Scheme-dialect repl (the same type of instant interpretter that Python uses) it will return a sorted list.
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
  (lambda (item sorted-ls) ; We use lambda to name our inputs: in this case we have two named item and orig-ls.
    (letrec ((helper ; We use letrec to create helper programs. In this case we have one named helper.
              (lambda (part-before part-after) ; We use lambda to name helper's inputs, in this case we have two part-before and part-after.
                       (if ; We use if to set up a fork in the road.
                        (empty? part-after) ; We use empty? to ask if part-after is empty.
                           (add-to-end part-before item) ; If the answer is yes, we return part-before with item added to its end. Done. EXIT.
                           (let ; If the answer is no, we use let to create local variables. In this case we have one named firsty.
                               ((firsty (first part-after))) ; We assign firsty to the first item of part-after.
                             (if ; We use another if to set up another fork in the road.
                              (less-than? item firsty) ; We use less-than? to ask if item is less than firsty.
                                 (combine (add-to-end part-before item) ; If the answer is yes, we add item to the end or part-before,
                                          part-after) ; and we combine that with part after and we return that. And we are done.
                                 (helper ; If the answer is no, we run helper again with different inputs.
                                  (add-to-end part-before firsty) ; We change part-before by adding firsty to its end.
                                  (without-first part-after)))))))) ; We change part-after by removing its first item.
      (helper empty-list sorted-ls)))) ; This is the initialization line. We start helper with its original inputs.
              ; In this case part-before starts as an empty-list and part-after starts as orig-ls.

                       ; Insertion-sort takes an unsorted list and returns a sorted list.
                       ; We use the Insert program to sort the items into an empty list, one at a time.
                       ; We use a helper program with two lists.
                       ; A list to keep track of what is already sorted, which we start as an empty list.
                       ; And a list to keep track of what stills needs to be sorted, which we start as the input list.
                       ; We use the insert program to move the items one at a time from the unsorted-list to the sorted-list.
(define insertion-sort ; We use define to create a program, in this case we name it insertion-sort.
  (lambda (orig-ls) ; We use lambda to name our inputs, in this case we have one named orig-ls.
    (letrec ((helper ; We use letrec to create helper programs, in this case we have one named helper.
              (lambda (unsorted-ls sorted-ls) ; We use lambda to name helper's inputs, in this case we have unsorted-ls and sorted-ls.
                (if ; We use if to set up a fork in the road.
                 (empty? unsorted-ls) ; We use empty? to ask if unsorted-ls is empty.
                    sorted-ls ; If the answer is yes, we return sorted-ls and we are done. EXIT.
                    (helper ; If the answer is no, we run helper again with different inputs.
                     (without-first unsorted-ls) ; We change unsorted-ls by removing its first item.
                     (insert (first unsorted-ls) ; We change sorted-ls by inserting the first item of unsorted-ls into it.
                             sorted-ls))))))
      (helper orig-ls empty-list)))) ; This is the initialization line, it starts helper with its original inputs,
                                     ; In this case unsorted-ls starts as orig-ls and sorted-ls starts as an empty-list.

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
(define without-first-item without-first)
(define remove-first without-first)
(define remove-first-item without-first)
(define combine-lists combine)
(define add-item-to-end-of-list add-to-end)






























