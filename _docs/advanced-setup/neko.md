---
title: Setup Neko
---

[Neko](https://nekovm.org) is a cross-platform virtual machine that is bundled with [Haxe](https://haxe.org/). It is often used during development of Lime and OpenFL projects as a faster alternative to compiling to native C++.

## Automatic Install

There is no automatic setup available for Neko.

## Manual Install

There is generally no setup required for the Neko target.

## Build & Run

To compile a Neko application, run `lime build neko`.

To compile and launch a Neko application with one command, run `lime test neko`.

## Advanced Configuration

### Cairo rendering

To force software rendering with Cairo instead of OpenGL, add the `-Dcairo` option to your build command.

```sh
lime build neko -Dcairo
```

## Help & Forums

If you encounter any problems when setting up Lime for Neko, please visit the [community forums](http://community.openfl.org/c/help) or our [Discord server](https://discord.gg/tDgq8EE).
