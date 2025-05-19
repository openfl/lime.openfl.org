---
title: Setup WebAssembly
---

Create native [WebAssembly](https://webassembly.org/) web applications with Lime and OpenFL by [compiling to C++](https://haxe.org/manual/target-cpp-getting-started.html). WebAssembly is often abbreviated as WASM.

## Automatic Install

There is no automatic setup available for WebAssembly.

## Manual Install


In order to build Lime applications using WebAssembly, you must install the Emscripten SDK.

[Download the Emscripten SDK](https://emscripten.org/docs/getting_started/downloads.html)


Lime must be configured with the Emscripten SDK's file system path. Open a command prompt or terminal, and run the following command:

```sh
lime setup emscripten
```

When prompted, specify the absolute path to the Emscripten SDK.


## Build & Run

To compile a WebAssembly application, run `lime build WebAssembly`. Add the `-debug` option to create a debug build. Add the `-release` option to create a release build.

To compile and launch a WebAssembly with one command, run `lime test WebAssembly`.

## Help & Forums

If you encounter any problems when setting up Lime for WebAssembly, please visit the [community forums](http://community.openfl.org/c/help) or our [Discord server](https://discord.gg/tDgq8EE).