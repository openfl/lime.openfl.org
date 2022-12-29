---
title: Setup Flash
---

[Adobe ended support for Flash Player on December 31, 2020.](https://www.adobe.com/products/flashplayer/end-of-life-alternative.html) However, contributors to OpenFL often test their changes with old versions of Adobe Flash Player to ensure backwards compatibility. The instructions below explain how that can be done.

If you want to target web browsers with OpenFL, consider following the [Setup HTML5](../html5/) instructions instead.

## Automatic Install

There is no automatic setup available for the Flash target.

## Manual Install

There is generally no setup required for the Flash target. However, you will need the **standalone** version of Adobe Flash Player (the plugin for web browsers is no longer available). You should download a "Content Debugger" version of the standalone Flash Player on your system, configured as your operating system's default application for _*.swf_ files:

 *  [Adobe Flash Player 32 Content Debugger for Windows](https://fpdownload.macromedia.com/pub/flashplayer/updaters/32/flashplayer_32_sa_debug.exe)
 *  [Adobe Flash Player 32 Content Debugger for macOS](https://fpdownload.macromedia.com/pub/flashplayer/updaters/32/flashplayer_32_sa_debug.dmg)

## Build & Run

To compile a Flash _.swf_ file, run `lime build flash`. Add the `-debug` option to create a build that can connect to a SWF debugger. Add the `-release` option to create a release build.

To compile and launch a Flash _.swf_ file with one command, run `lime test flash`.

## Using SWC libraries

To use a _.swc_ library with Haxe that was compiled from ActionScript, add Haxe's `-swf-lib` command line option. For instance, you can add it to your [_project.xml_](../../project-files/xml-format/) file using the [`<haxeflag/>`](../../project-files/xml-format/#haxeflag) element.

```xml
<haxeflag name="-swf-lib" value="libs/example.swc"/>
```

## Forums

If you encounter any problems when setting up Lime for Flash, please visit the [forums](http://community.openfl.org/c/help).
