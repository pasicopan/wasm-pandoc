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
