---
title: Setup HashLink
---

[HashLink](https://hashlink.haxe.org) is a cross-platform virtual machine for [Haxe](https://haxe.org/). It is often used by Lime and OpenFL developers as an alternative to compiling to native C++.

## Automatic Install

There is no automatic setup available for HashLink.

## Manual Install

- Donwload latest binary [HashLink release](https://github.com/HaxeFoundation/hashlink/releases)
- Extract it where you want (e.g. *C:/HashLink*)
- Run `lime setup hashlink` within your terminal and provide HashLink path (e.g. *C:/HashLink*)

## Build & Run

To compile a HashLink application, run `lime build hl`. Add the `-debug` option to create a debug build. Add the `-release` option to create a release build.

To compile and launch a HashLink application with one command, run `lime test hl`.

## Forums

If you encounter any problems when setting up Lime for HashLink, please visit the [forums](http://community.openfl.org/c/help).
