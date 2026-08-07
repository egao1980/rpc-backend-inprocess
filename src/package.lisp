(defpackage #:rpc-backend-inprocess
  (:use #:cl)
  (:export #:inprocess-rpc-transport
           #:make-inprocess-rpc-transport
           #:use-inprocess-rpc-transport))

(in-package #:rpc-backend-inprocess)
