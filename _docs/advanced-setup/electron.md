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

To compile an Electron application, run `lime build electron`.

To compile and launch an Electron application with one command, run `lime test electron`.

## Using JavaScript libraries

To use an external JavaScript library with Lime, you need [Haxe externs](https://haxe.org/manual/lf-externs.html). See also [Haxe: Using external JavaScript libraries](https://haxe.org/manual/target-javascript-external-libraries.html).

Members of the Haxe community have already created open source externs for a number of popular JavaScript libraries, so be sure to search [Haxelib](https://lib.haxe.org/search) or [Github](https://github.com/search) to see if JS externs exist for your library before you try to create your own.

## Electron Processes and IPC with Lime

Electron is designed to be a [multi-process system](https://www.electronjs.org/docs/latest/tutorial/process-model), with a _main_ process that integrates at a lower-level with the operating system, and a _renderer_ process that displays HTML/CSS/JS like a web browser. For security reasons, the renderer process typically can't access Electron's operating system integrations directly, and Electron provides [inter-process communication (IPC)](https://www.electronjs.org/docs/latest/tutorial/ipc) facilities to communicate safely between the main process and the renderer process.

The `electron` target in Lime is not designed to provide deep integration with Electron's main process or IPC system. Instead, the `electron` target is basically a simple variation of the `html5` target with some extra templates to quickly get your project running in Electron instead of a web browser. However, this does **not** prevent Lime users from creating more advanced Electron apps that take advantage of Electron's main process, preload scripts, and IPC.

To build a more advanced Electron app with main and preload scripts, you need to compile them separately from your Lime app. You can still use Haxe for the main and preload scripts (typically, using _.hxml_ files to define compiler options) because Electron APIs are available in Haxe thanks to the [electron Haxelib](https://lib.haxe.org/p/electron/).

For the renderer process, you can use Lime's regular `html5` target. If you need access to functions exposed from a preload script, you can define them by creating custom [Haxe externs](https://haxe.org/manual/lf-externs.html), similar to [using external JavaScript libraries from Haxe](https://haxe.org/manual/target-javascript-external-libraries.html).

Full Electron integration with Lime requires some extra steps, but that's the nature of targeting Electron with _any_ language that can compile to JavaScript, due to Electron's strict design of process separation for security.

For packaging a final app bundle for distribution, you may be able to use tools such as [Electron Forge](https://www.electronforge.io/) or [Electron Builder](https://www.electron.build/).

## Help & Forums

If you encounter any problems when setting up Lime for Electron, please visit the [community forums](http://community.openfl.org/c/help) or our [Discord server](https://discord.gg/tDgq8EE).
