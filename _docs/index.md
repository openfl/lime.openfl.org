---
title: Getting Started
permalink: /docs/home/
redirect_from: docs/index.html
---

## Install Haxe

If you have not already, install [Haxe](https://haxe.org/download/) for your current platform. Lime projects can be built on Windows, macOS and Linux.


## Install Lime

Next, open a command-prompt (Windows) or terminal (macOS/Linux) and run the following commands:

```sh
haxelib install lime
haxelib run lime setup
```

To confirm that Lime is installed and working properly, try running the "lime" command:

```sh
lime
```

## Install a Code Editor

We recommend [Visual Studio Code](https://code.visualstudio.com), using the [Lime Extension](https://marketplace.visualstudio.com/items?itemName=openfl.lime-vscode-extension), but many [other code editors](../getting-started/choosing-a-code-editor) are also compatible with Haxe development.

## Run a Sample

Lime includes some simple sample projects to help you get started. For example, the "SimpleImage" sample illustrates an example of rendering graphics for multiple platforms and renderers:

```sh
lime create SimpleImage
cd SimpleImage
lime test html5
lime test html5 -Dcanvas
lime test html5 -Ddom
lime test neko
lime test neko -Dcairo
lime test flash
```

Lime will use a hardware-accelerated OpenGL renderer by default, but attempts to fall back to a software renderer (such as the [HTML5 Canvas API](https://developer.mozilla.org/en-US/docs/Web/API/Canvas_API) or [Cairo for native 2D Graphics](https://www.cairographics.org/)) when OpenGL is unavailable on the current system. You can add the `-Dcanvas` flag to the `html5` target or the `-Dcairo` flag to native targets to force software rendering.

## Use Additional Platforms

Lime and OpenFL support many [target platforms and operating systems](../getting-started/targets/), including:

- Native C++ desktop apps on [Windows](../advanced-setup/windows/), [macOS](../advanced-setup/macos/), [Linux](../advanced-setup/linux/)
- Native C++ mobile apps on [Android](../advanced-setup/android/), and [iOS](../advanced-setup/ios/)
- [HTML5](../advanced-setup/html5/) on the web
- [WebAssembly](../advanced-setup/webassembly/) C++ web apps
- Using cross-platform runtimes like [Electron](../advanced-setup/electron/), the [HashLink](../advanced-setup/hashlink/) virtual machine, and [Adobe AIR](../advanced-setup/air/)

Some target platforms require extra setup before they will work properly with Lime. After you confirm that things are running properly, you can try configuring a new platform:

```sh
lime setup windows
lime setup linux
lime setup mac
lime setup android
lime setup ios
lime setup webassembly
```

Follow the pages under the [Platform Setup](../advanced-setup/) section for more detailed information to setup each platform.


## Problems?

If you have any questions or concerns when you are installing Lime, do not hesitate to visit our friendly [community forums](https://community.openfl.org/c/help) or [Discord server](https://discord.gg/tDgq8EE). Thank you for trying Lime, and please let us help if you have any problems at all.
