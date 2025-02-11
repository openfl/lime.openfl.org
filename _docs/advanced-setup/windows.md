---
title: Setup Windows
---

Create native [Windows](https://developer.microsoft.com/en-us/windows/) desktop applications with Lime and OpenFL by [compiling to C++](https://haxe.org/manual/target-cpp-getting-started.html).

## Automatic Install

There is no automatic setup available for Windows.

## Manual Install

In order to build C++ applications for Windows, you must have a compatible version of Visual Studio C++ installed on your system.

Currently, Lime requires a version of Visual Studio capable of targeting Win32. For newer versions of Visual Studio, this requires the "Windows Desktop" version of the software.

You can only target Windows from a Windows system right now. If you are interested in contributing to cross-desktop builds to Windows, please open a topic on the forums.

## Build & Run

To compile a Windows _.exe_ file, run `lime build windows`. Add the `-debug` option to create a build that can connect to the HXCPP debugger. Add the `-release` option to create a release build.

To compile and launch a Windows _.exe_ file with one command, run `lime test windows`.

> _Note:_ The first time that you compile a project for C++, it will take a noticably long time. However, compiling the same project again should be significantly faster because parts of your code that have not changed do not need to be recompiled. To force all of code to be recompiled for C++, use the `-clean` option.

## Advanced Configuration

The `<config:cpp />` element in your [_project.xml_](../../project-files/xml-format/) file is used to specify advanced configuration options for C++. For a complete list of these advanced option, see [Config Values: C++](../../project-files/xml-format/config/#c).

## Help & Forums

If you encounter any problems when setting up Lime for targeting Windows, please visit the [community forums](http://community.openfl.org/c/help) or our [Discord server](https://discord.gg/tDgq8EE).
