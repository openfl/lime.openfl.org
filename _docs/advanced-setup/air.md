---
title: Setup AIR
---

[Adobe AIR](https://airsdk.dev) is a cross-platform framework used by a wide range of applications and games. While AIR was originally created by Adobe, it is currently maintained with active development of new features by HARMAN. See [The future of Adobe AIR](https://theblog.adobe.com/the-future-of-adobe-air/) and [HARMAN's AIR SDK Website](https://airsdk.dev) for more details.

## Automatic Install

There is no automatic setup available for Adobe AIR.

## Manual Install

In order to build applications using Adobe AIR, you must have the Adobe AIR SDK installed.

[Download the Adobe AIR SDK from HARMAN](https://airsdk.harman.com/download), and extract it on your system.

Next, open a command-prompt or terminal and run the following command (using the path to your AIR SDK):

```sh
lime config AIR_SDK path/to/air/sdk
```

## Using SWC libraries

To use a _.swc_ library with Haxe that was compiled from ActionScript, add Haxe's `-swf-lib` command line option. For instance, you can add it to your [_project.xml_](../project-files/xml-format.md) file using the [`<haxeflag/>`](../project-files/xml-format.md#haxeflag) element.

```xml
<haxeflag name="-swf-lib" value="path/to/example.swc"/>
```

## Using AIR Native Extensions

To use a _.ane_ native extension, use the [`<dependency/>`](../project-files/xml-format.md#dependency) element.

```xml
<dependency name="com.example.MyNativeExtension" path="path/to/com.example.MyNativeExtension.ane" if="air"/>
```

The `name` attribute is the extension ID. The `path` attribute is the relative path to the _.ane_ file.

## Forums

If you encounter any problems when setting up Lime for AIR, please visit the [forums](http://community.openfl.org/c/help).