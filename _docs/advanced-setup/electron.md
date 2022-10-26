---
title: Setup Electron
---

[Electron](https://www.electronjs.org) allows developers to build cross-platform desktop apps with JavaScript, HTML, and CSS. Electron can run on Windows, macOS, and Linux.

## Automatic Install

There is no automatic setup available for Electron.

## Manual Install

In order to build Lime applications using Electron, you must install Node.js and Electron.

[Download Node.js](https://nodejs.org/en/download/) and run the installer.

Then, open a command-prompt or terminal and run the following command to install Electron globally:

```sh
npm install -g electron
```

## Build & Run

Run `lime test electron` to compile and run the Electron application.

## Using JavaScript libraries

To use an external JavaScript library with Lime, you need [Haxe externs](https://haxe.org/manual/lf-externs.html). See also [Haxe: Using external JavaScript libraries](https://haxe.org/manual/target-javascript-external-libraries.html).

Members of the Haxe community have already created open source externs for a number of popular JavaScript libraries, so be sure to search [Haxelib](https://lib.haxe.org/search) or [Github](https://github.com/search) to see if JS externs exist for your library before you try to create your own.

## Forums

If you encounter any problems when setting up Lime for Electron, please visit the [forums](http://community.openfl.org/c/help).
