---
title: Setup macOS
---

Create native [macOS](https://developer.apple.com/macos/) desktop applications with Lime and OpenFL by [compiling to C++](https://haxe.org/manual/target-cpp-getting-started.html).

## Automatic Install

There is no automatic setup available for macOS.

## Manual Install

In order to build C++ applications for macOS, you must have a current version of Xcode installed.

You can find Xcode in the macOS App Store.

You can only target macOS from an Apple system right now. If you are interested in contributing to cross-desktop builds to macOS, please open a topic on the forums.

## Build & Run

Run `lime test mac` to compile an _.app_ file and run it.

_Note:_ The first time that you compile a project for C++, it will take a noticably long time. However, compiling the same project again should be significantly faster because parts of your code that have not changed do not need to be recompiled. To force all of code to be recompiled for C++, use the `-clean` option.

## Forums

You should not need to install the Xcode command-line tools. If this is not the case, or if you encounter other problems when setting up Lime for macOS, please visit the [forums](http://community.openfl.org/c/help).
