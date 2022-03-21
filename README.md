Pandoc in WebAssembly ([Try It](https://y-taka-23.github.io/wasm-pandoc/))
====

![Pandoc](screenshot.png)

Serving Locally
----

```bash
// test in broswer
git clone https://github.com/pasicopan/wasm-pandoc
cd wasm-pandoc
make start

// test in nodejs
git clone https://github.com/pasicopan/wasm-pandoc
cd wasm-pandoc
make startNode
cd _build/asterius
node --experimental-wasi-unstable-preview1 --trace-warnings wasm-pandoc.mjs
```

### TODO
1. - [ ] convert BSL.ByteString to T.Text in wasm from haskell, [see detail](https://github.com/y-taka-23/wasm-pandoc/issues/6)
1. - [ ] convert 'docx' to 'html in browser and nodejs
1. - [ ] reduce *.wasm file size, less than 8M
1. - [ ] reduce BSL.ByteString  or T.Text to BSL.ByteString in wasm from haskell