;;; Some missing bits to get McCLIM to build & work under SBCL.
;;; Raymond Wiker, 23/4/2001

;;; SBCL is stricter than (most?) other CL implementations in that it
;;; requires eq-ness of multiple defconstants for the same
;;; symbol. This is supposedly correct behaviour, but incompatible
;;; with (almost) everybody else.

;;; The solution below works, but is ugly. The real solution would
;;; probably to change the McCLIM code to use defparameter instead of
;;; defconstant...

;;; This one doesn't work, because defconstant-eqx is defined in terms
;;; of defconstant.
#||
(defmacro defconstant (name val &optional comment-string)
  (if comment-string
      `(sb-int:defconstant-eqx ,name ,val #'equal ,comment-string)
      `(sb-int:defconstant-eqx ,name ,val #'equal)))
||#

;;; This is not good. 
(defmacro defconstant (var val) `(defparameter ,var ,val))
