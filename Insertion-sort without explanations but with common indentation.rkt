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
(define insert 
  (lambda (item sorted-ls) 
    (letrec ((helper 
              (lambda (part-before part-after) 
                (if 
                 (empty? part-after) 
                 (add-to-end part-before item) 
                 (let 
                     ((firsty (first part-after))) 
                   (if 
                    (less-than? item firsty) 
                    (combine (add-to-end part-before item) 
                             part-after) 
                    (helper 
                     (add-to-end part-before firsty) 
                     (without-first part-after)))))))) 
      (helper empty-list sorted-ls)))) 
              

                       ; Insertion-sort takes an unsorted list and returns a sorted list.
                       ; We use the Insert program to sort the items into an empty list, one at a time.
                       ; We use a helper program with two lists.
                       ; A list to keep track of what is already sorted, which we start as an empty list.
                       ; And a list to keep track of what stills needs to be sorted, which we start as the input list.
                       ; We use the insert program to move the items one at a time from the unsorted-list to the sorted-list.
(define insertion-sort 
  (lambda (orig-ls) 
    (letrec ((helper 
              (lambda (unsorted-ls sorted-ls) 
                (if 
                 (empty? unsorted-ls) 
                 sorted-ls 
                 (helper 
                  (without-first unsorted-ls) 
                  (insert (first unsorted-ls) 
                          sorted-ls))))))
      (helper orig-ls empty-list)))) 
                                     

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



























