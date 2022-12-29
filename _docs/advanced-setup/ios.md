---
title: Setup iOS
---

Create native [iOS and iPadOS](https://developer.apple.com/ios/) mobile applications with Lime and OpenFL by [compiling to C++](https://haxe.org/manual/target-cpp-getting-started.html).

## Automatic Install

There is no automatic setup available for iOS.

## Manual Install

In order to build applications for iOS, you must have a current version of Xcode installed.

You can find Xcode in the macOS App Store.

Before you can build for a device, you will also need to connect your device to your computer with USB. Then, make sure that you have valid developer certificates set up in Xcode, and that you have provisioned the device.

> Due to the restrictive nature of Apple's developer tools, building iOS apps is supported on computers running macOS only. iOS apps cannot be built from Windows or Linux. There are currently no plans to support iOS development from non-macOS host systems at this time. However, you can technically use the AIR target to build iOS apps on Windows. If you are interested in contributing a stable way to develop C++ iOS applications from other host systems, please open a topic on the forums to discuss your implementation plans.

## Build & Run

Run `lime test ios` to compile an iOS or iPadOS application bundle, and run it on a device connected to your computer with USB. Add the `-simulator` option to target the iOS simulator included with Xcode instead.

> _Note:_ The first time that you compile a project for C++, it will take a noticably long time. However, compiling the same project again should be significantly faster because parts of your code that have not changed do not need to be recompiled. To force all of code to be recompiled for C++, use the `-clean` option.

Specify the `-appstore` option to create a build to be submitted to the iOS App Store. Alternatively, specify the `-adhoc` option for ad hoc distribution to specific devices outside of the App Store. For enterprise distribution within your organization, specify the `-enterprise` option.

## Forums

You should not need to install the Xcode command-line tools. If this is not the case, or if you encounter other problems when setting up Lime for iOS, please visit the [forums](http://community.openfl.org/c/help).
