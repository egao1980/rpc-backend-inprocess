(defsystem "rpc-backend-inprocess"
  :version "0.1.0"
  :description "In-process transport for rpc-protocol"
  :author "egao1980"
  :license "MIT"
  :depends-on ("rpc-protocol")
  :properties (:cl-repo (:ci (:sources (("yason" :ql) ("rove" :ql)))))
  :serial t
  :pathname "src"
  :components ((:file "package")
               (:file "backend"))
  :in-order-to ((test-op (test-op "rpc-backend-inprocess/tests"))))

(defsystem "rpc-backend-inprocess/tests"
  :depends-on ("rpc-backend-inprocess" "rove")
  :pathname "tests"
  :serial t
  :components ((:file "package")
               (:file "backend-test"))
  :perform (test-op (o c)
             (unless (symbol-call :rove :run c)
               (error "tests failed for ~A" (component-name c)))))
