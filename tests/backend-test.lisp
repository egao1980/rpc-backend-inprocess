(in-package #:rpc-backend-inprocess/tests)

(deftest echo-call
  (rpc-protocol:rpc-serve
   (lambda (method params)
     (ok (equal "echo" method))
     params))
  (ok (equalp #(1 2 3) (rpc-protocol:rpc-call "echo" #(1 2 3)))))

(deftest method-can-signal
  (rpc-protocol:rpc-serve
   (lambda (method params)
     (declare (ignore method params))
     (error 'rpc-protocol:rpc-method-not-found)))
  (ok (signals (rpc-protocol:rpc-call "nope" nil)
               'rpc-protocol:rpc-method-not-found)))

(deftest transport-bound
  (ok (typep rpc-protocol:*rpc-transport*
             'rpc-backend-inprocess:inprocess-rpc-transport)))
