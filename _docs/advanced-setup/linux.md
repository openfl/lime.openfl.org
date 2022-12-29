---
title: Setup Linux
---

Create native Linux desktop applications with Lime and OpenFL by [compiling to C++](https://haxe.org/manual/target-cpp-getting-started.html).

## Automatic Install

There is no automatic setup available for Linux.

## Manual Install

No additional setup is required for most Linux systems.

You may need to install `g++` if it is not present already, and if you intend to compile 32-bit applications from a 64-bit distribution, you will also want `gcc-multilib` and `g++-multilib`, or their equivalents.

If you build Lime from the source, you will also need `libgl1-mesa-dev` and `libglu1-mesa-dev`.

You can only target Linux from a Linux system right now. If you are interested in contributing to cross-desktop builds to Linux, please open a topic on the forums.

## Build & Run

To compile a Linux executable, run `lime build linux`. Add the `-debug` option to create a build that can connect to the HXCPP debugger. Add the `-release` option to create a release build.

To compile and launch a Linux executable with one command, run `lime test linux`.

> _Note:_ The first time that you compile a project for C++, it will take a noticably long time. However, compiling the same project again should be significantly faster because parts of your code that have not changed do not need to be recompiled. To force all of code to be recompiled for C++, use the `-clean` option.

## Forums

If you encounter problems setting up Lime to compile on Linux, please visit the [forums](http://community.openfl.org/c/help).
