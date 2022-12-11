;; day-07.lisp

(in-package #:aoc-2022)

(defparameter *cd-up-regex* "\\$ cd \\.\\.")
(defparameter *cd-down-regex* "\\$ cd (.+)")

(defparameter *ls-regex* "\\$ ls")

(defparameter *dir-regex* "dir (.+)")
(defparameter *file-regex* "([0-9]+) (.+)")

(defclass node ()
  ((name
    :initform (error "Need to provide node name")
    :initarg :name
    :accessor node-name)
   (size
    :initform 0
    :initarg :size
    :accessor node-size)))

(defclass tree ()
  ((nodes
    :accessor tree-nodes
    :initform nil)
   (edges
    :accessor tree-edges
    :initform nil)
   (current-node
    :accessor tree-current-node
    :initform nil)))

(defmethod add-node ((tree tree) node)
  (push node (tree-nodes tree))
  (let ((id (length (tree-nodes tree))))
    (push (cons id nil)
	  (tree-edges tree))
    id))

(defmethod add-edge ((tree tree) from to)
  (with-slots (edges) tree
    (push to (cdr (assoc from edges)))))

(defmethod add-child ((tree tree) node)
  (let ((id (add-node tree node)))
    (add-edge tree (tree-current-node tree) id)))

(defmethod find-parent ((tree tree) node-id)
  (let ((edge-list (delete-if-not #'(lambda (edges)
				      (find node-id (cdr edges)))
				  (tree-edges tree))))
    (car edge-list)))

(defmethod node-id ((tree tree) node-name)
  (ith #'(lambda (node)
	   (string= node-name (node-name node)))
       (tree-nodes tree)))

(defmethod parse-fs-line ((tree tree) line)
  (cond
    ((cl-ppcre:scan *cd-up-regex* line)
     (setf (tree-current-node tree)
	   (find-parent tree (tree-current-node tree))))
    ((cl-ppcre:register-groups-bind (dir) (*cd-down-regex* line)
       (setf (tree-current-node tree) (node-id tree dir))))
    ((cl-ppcre:scan *ls-regex* line))
    ((cl-ppcre:register-groups-bind (dir-name) (*dir-regex* line)
       (add-child tree (make-instance 'node
				      :name dir-name))))
    ((cl-ppcre:register-groups-bind ((#'parse-integer size) file-name) (*file-regex* line)
       (add-child tree (make-instance 'node
				      :name file-name
				      :size size))))))

(defsolution (input-file) 7 1
  (let ((tree (make-instance 'tree)))
    (add-node tree (make-instance 'node :name "/"))
    (setf (tree-current-node tree) 0)
    (with-open-file (in input-file)
      (loop for line = (read-line in)
	    while line do (parse-fs-line tree line)))

    (print tree)))
