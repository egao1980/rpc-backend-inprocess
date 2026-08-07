(in-package #:rpc-backend-inprocess)

(defclass inprocess-rpc-transport (rpc-protocol:rpc-transport)
  ((handler :initform nil :accessor transport-handler)
   (next-id :initform 0 :accessor transport-next-id)))

(defun make-inprocess-rpc-transport ()
  (make-instance 'inprocess-rpc-transport))

(defun use-inprocess-rpc-transport ()
  (setf rpc-protocol:*rpc-transport* (make-inprocess-rpc-transport)))

(defun %next-id (transport)
  (incf (transport-next-id transport)))

(defmethod rpc-protocol:backend-rpc-serve
    ((transport inprocess-rpc-transport) handler &key)
  (setf (transport-handler transport) handler)
  transport)

(defmethod rpc-protocol:backend-rpc-call
    ((transport inprocess-rpc-transport) method params &key timeout id)
  (declare (ignore timeout))
  (let ((handler (transport-handler transport))
        (id (or id (%next-id transport))))
    (unless handler
      (error 'rpc-protocol:rpc-error
             :message "no handler — call rpc-serve first"
             :code rpc-protocol:+internal-error+))
    (handler-case
        (funcall handler method params)
      (rpc-protocol:rpc-error (c)
        (error c))
      (error (c)
        (error 'rpc-protocol:rpc-error
               :message (format nil "~a" c)
               :code rpc-protocol:+internal-error+
               :data (list :id id :method method))))))

(defmethod rpc-protocol:backend-rpc-notify
    ((transport inprocess-rpc-transport) method params)
  (let ((handler (transport-handler transport)))
    (unless handler
      (error 'rpc-protocol:rpc-error
             :message "no handler — call rpc-serve first"
             :code rpc-protocol:+internal-error+))
    (funcall handler method params)
    t))

(use-inprocess-rpc-transport)
