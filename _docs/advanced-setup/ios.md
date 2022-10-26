---
title: Setup iOS
---

Create native [iOS and iPadOS](https://developer.apple.com/ios/) mobile applications with Lime and OpenFL by [compiling to C++](https://haxe.org/manual/target-cpp-getting-started.html).

## Automatic Install

There is no automatic setup available for iOS.

## Manual Install

In order to build applications for iOS, you must have a current version of Xcode installed.

You can find Xcode in the macOS App Store.

Before you can build for a device, you will also need to connect your device and make sure that you have valid developer certificates set up in Xcode, and that you have provisioned the device.

Due to the nature of Apple's developer tools, there is only support for iOS development when running macOS. We do not have plans to support iOS development from other host systems at this time, however, you can use the Flash target (if you prefer) to publish Lime applications to iOS, using AIR. If you are interested in contributing a stable way to develop iOS applications from other host systems, please open a topic on the forums.

## Build & Run

Run `lime test ios` to compile an iOS or iPadOS application bundle, and run it on a device connected to your computer with USB.

_Note:_ The first time that you compile a project for C++, it will take a noticably long time. However, compiling the same project again should be significantly faster because parts of your code that have not changed do not need to be recompiled. To force all of code to be recompiled for C++, use the `-clean` option.

## Forums

You should not need to install the Xcode command-line tools. If this is not the case, or if you encounter other problems when setting up Lime for iOS, please visit the [forums](http://community.openfl.org/c/help).
