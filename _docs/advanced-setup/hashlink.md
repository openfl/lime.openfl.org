---
title: Setup HashLink
---

[HashLink](https://hashlink.haxe.org) is a cross-platform virtual machine for [Haxe](https://haxe.org/). It is often used by Lime and OpenFL developers as an alternative to compiling to native C++.

## Automatic Install

HashLink is included in Lime, and no additional setup is necessary to use this version on most platforms.

On macOS specifically, you will have to run `lime setup hashlink` if you want to use the HashLink debugger. However, this step isn't needed simply to compile and run apps.

## Manual Install

If building HashLink from source or using a [HashLink release](https://github.com/HaxeFoundation/hashlink/releases) other than the one included in Lime, run `lime setup hashlink` to let Lime know where you put it. To change this path or go back to the bundled version of HashLink, run `lime setup hashlink` again.

## Build & Run

To compile a HashLink application, run `lime build hl`. Add the `-debug` option to create a debug build. Add the `-release` option to create a release build.

To compile and launch a HashLink application with one command, run `lime test hl`.

## Help & Forums

If you encounter any problems when setting up Lime for HashLink, please visit the [forums](http://community.openfl.org/c/help) or [Discord](https://discord.gg/tDgq8EE).
