;; day-05.lisp

(in-package #:aoc-2022)

(defsolution (input-file) 5 1
  (with-open-file (in input-file)
    (let ((lines '())
	  (state '()))
      (loop for line = (read-line in nil)
	    while (string/= line "")
	    do (push line lines))

      (setf state (parse-initial-state lines))

      (format t "Initial state: ~a~%" state)

      (loop for line = (read-line in nil)
	    while (string/= line nil)
	    do (setf state (next-state state line)))

      (format t "Stack tops: ")

      (loop for stack in state
	    do (format t "~a" (first stack)))

      (format t "~%"))))

(defsolution (input-file) 5 2
  (with-open-file (in input-file)
    (let ((lines '())
	  (state '()))
      (loop for line = (read-line in nil)
	    while (string/= line "")
	    do (push line lines))

      (setf state (parse-initial-state lines))

      (format t "Initial state: ~a~%" state)

      (loop for line = (read-line in nil)
	    while (string/= line nil)
	    do (setf state (next-state-v2 state line)))

      (format t "Stack tops: ")

      (loop for stack in state
	    do (format t "~a" (first stack)))

      (format t "~%"))))

(defun number-of-stacks (first-line)
  (cl-ppcre:count-matches "[0-9]" first-line))

(defun parse-initial-state (lines)
  (let* ((n-stacks (number-of-stacks (first lines)))
	 (state (make-list n-stacks)))
    (loop for line in (rest lines)
	  do (loop for i from 0 below n-stacks
		   do (let ((c (char line (1+ (* i 4)))))
			(if (not (eq c #\Space))
			    (push c (nth i state))))))
    state))

(defun next-state-v2 (state action)
  (cl-ppcre:register-groups-bind (amount from to) ("move ([\\d]+) from ([\\d]+) to ([\\d]+)" action)
    (let ((stack '())
	  (amount (parse-integer amount))
	  (from (1- (parse-integer from)))
	  (to (1- (parse-integer to))))
      (dotimes (i amount)
	(push (pop (nth from state)) stack))

      (dotimes (i amount)
	(push (pop stack) (nth to state)))
      state)))

(defun next-state (state action)
  (cl-ppcre:register-groups-bind (amount from to) ("move ([\\d]+) from ([\\d]+) to ([\\d]+)" action)
    (let ((amount (parse-integer amount))
	  (from (1- (parse-integer from)))
	  (to (1- (parse-integer to))))
      (dotimes (i amount)
	(push (pop (nth from state)) (nth to state)))
      state)))
