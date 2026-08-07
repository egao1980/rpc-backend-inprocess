# rpc-backend-inprocess

In-process transport for [`rpc-protocol`](https://github.com/egao1980/rpc-protocol).

```lisp
(asdf:load-system "rpc-backend-inprocess")
(stack-rpc:rpc-serve (lambda (method params) (declare (ignore method)) params))
(stack-rpc:rpc-call "echo" "hi")
```

OCI: `ghcr.io/egao1980/cl-systems/rpc-backend-inprocess:0.1.0`

## License

MIT
