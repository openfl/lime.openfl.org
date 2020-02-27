---
title: XML Format
---

## Overview

Usually a simple project file is all you need to build projects using Lime, but it can be extended based on your needs. Here is a reference of what you can do.

### Conditionals

First, every node in the project file format supports `if` and `unless` attributes. These are conditional values to help you customize your build process, based upon a number of values. Here are some of the default values:

 * mobile, desktop or web
 * ios, android, windows, mac, linux or html5
 * cpp, neko, flash or js

You can `<set />` or `<unset />` values for conditional logic:

```xml
<set name="red" />
<window background="#FF0000" if="red" />
```

This can also be used to pass special values:

```xml
<set name="color" value="#FF0000" if="red" />
<set name="color" value="#0000FF" if="blue" />

<window background="${color}" if="color" />
```

Similarly, you can `<define />` which also passes values to Haxe

```xml
<define name="red" />
<window background="#FF0000" if="red" />
```

```java
#if red
trace ("Background is red");
#end
```

You can add defines using the command-line as well:

```bash
lime test flash -Ddefine
```

If you need to have multiple values in a conditional, spaces imply an "and" and vertical bars imply an "or", like this:

```xml
<window width="640" height="480" if="define define2" unless="define3 || define4" />
```

### Duplicates

You can include more than one copy of each tag, so do not worry about putting it all in one place. All of the values you define will be used. If you define the same value more than once, the last definition will be used.

```xml
<window width="640" />
<window height="480" />
```

### include.xml

If you create a haxelib, you can add "include.xml" to the top-level directory. The build tools will automatically add the contents of the file to the user's project. You can use this to add binary dependencies, additional classpaths, etc.

## XML Tag Glossary (click to expand)
<details>
<summary>&lt;app /&gt;</summary>

The `<app />` tag sets values important to building your project, including the entry point (main class), the output file directory, or if you want to customize the executable filename or define a custom preloader for a web platform:

```xml
<app main="com.example.MyApplication" file="MyApplication" path="Export" preloader="CustomPreloader" />
<app swf-version="11" />
```
</details>

<details>
<summary>&lt;architecture /&gt;</summary>

Use `<architecture />` tags to set or exclude Android-specific architectures. These can be `ARMv7`, `ARMv6`, `ARMv5` and `X86`.

By default the only architecture built will be `ARMv7`.

For example, if you want to enable `ARMv6` and disable `ARMv7` you would set the `<architecture />` tag to:

```xml
<architecture name="armv6" exclude="armv7" if="android" />
```

</details>

<details>
<summary>&lt;assets /&gt;</summary>

Use asset nodes to add resources to your project, available using `lime.Assets`.

The path attribute can point to either a file or a directory. These files will be copied (or embedded) in your final project, and can be accessed using the `lime.Assets` class.

For example, if you include the following node in your project file:

```xml
<assets path="images/MyImage.jpg" />
```

You can access it in your application like this:

```java
var bitmapData = Assets.getBitmapData ("images/MyImage.png");
```

The target path will mirror the source path by default, but you also can include a rename attribute, if you wish to use a different target path. The `lime.Assets` class will use the *target* path by default, so using the rename attribute will alter the names you use to reference your files.

If you would prefer to set the ID for your asset file yourself, use an "id" attribute. This only applies to asset nodes which point to a file, not a directory path.

When pointing to a directory, you can use the include or exclude attributes to specify patterns for including files automatically. Wildcards are supported. To include all the files under the directory, for example, use an include value of "*". You can separate multiple patterns using "|" characters.

You can nest assets nodes inside of each other. If you specify a directory in the top assets node, its path will be appended to the paths you specify in subsequent nodes.

The type for each file will be determined automatically, based on each file extension, but you can use the type attribute to set it for the file or directory yourself. If you are nesting a node inside of another assets node, you can also use the name of the type as the name of your node.

These are the current types:

 * binary
 * font
 * image
 * music
 * sound
 * template
 * text

Some targets can only support playing one music file at a time. You should use "music" for files which are designed to play as background music, and "sound" for all other audio. "binary" and "text" are generic types which are available as a ByteArray or String in your application. Most targets can use them interchangeably.

If an asset is specified as "template", it will not be copied/embedded as an ordinary asset, but instead will be copied to the root directory of your project, so you can replace any of the template HX, HXML or platform-specific files for the target.

```xml
<assets path="assets" include="*" />
<assets path="../../assets" rename="assets" include="*" />
<assets path="assets/images" rename="images" include="*.jpg|*.png" exclude="example.jpg" />
<assets path="assets">
<assets path="images" include="*" type="image" />
<assets path="assets">
	<sound path="sound/MySound.wav" id="MySound" />
	<music path="sound/BackgroundMusic.ogg" />
</assets>
```


</details>

<details>
<summary>&lt;certificate /&gt;</summary>

Use `<certificate />` tags to add a keystore for release signing on certain platforms.

If you do not include the password attribute, you will be prompted for your certificate password at the command-line.

For Android, the alias will be set to the file name of your certificate by default, without the extension. If the alias name is different, you can use the alias attribute.

If you have set the password attribute, the alias_password attribute will default to the same value. Otherwise you can add an alias-password attribute to specify a different value.

```xml
<certificate path="to/certificate.crt" password="1234" alias="my-alias" alias-password="4321" />
```

iOS does not use a certificate `path` and `password`, but instead uses a `team-id` attribute matching the ID provided in the Apple Developer portal for your team:

```xml
<certificate team-id="SK12FH34" />
```

</details>

<details>
<summary>&lt;classpath /&gt;</summary>
Same as “source”.
</details>

<details>
<summary>&lt;compilerflag /&gt;</summary>
Same as "haxeflag".
</details>

<details>
<summary>&lt;config /&gt;</summary>
Use `<config />` tags to set platform-specific values. These targets are currently supported:
- air
- android
- blackberry
- console-pc
- firefox
- flash
- html5
- ios
- linux
- mac
- ps3
- ps4
- tizen
- vita
- windows
- webos
- wiiu
- xbox1
- emscripten
- tvos

**One must append a suffix to the tag depending on the platform. **

For example, use `<config:android />` tags to set Android-specific values:

```xml
<config:android install-location="preferExternal" />
<config:android permission="com.android.vending.BILLING" />
<config:android target-sdk-version="16" />
```

Use `<config:ios />` tags to set iOS-specific values when compiling. The `deployment` attribute can set the minimum iOS version you wish to target. The `prerendered-icon` attribute can help control the style of your icon.

```xml
<config:ios deployment="5.1" />
<config:ios prerendered-icon="false" />
```

</details>

<details>
<summary>&lt;define /&gt;</summary>

Similar to `<set />` tag, use `<define />` to also pass values to Haxe. See the “Conditionals” section above.

```xml
<dependency name="GameKit.framework" if="ios" />
```

</details>

<details>
<summary>&lt;dependency /&gt;</summary>

Use `<dependency />` tags to specify native frameworks or references that are required to compile your project, as well as additional libraries you need copied.

```xml
<dependency name="GameKit.framework" if="ios" />
```

</details>

<details>
<summary>&lt;echo /&gt;</summary>
Prints specified message to the console:

```
<echo value="Some output message" />
```

</details>

<details>
<summary>&lt;error /&gt;</summary>

Logs error with `lime.utils.Log.error()`, which by default throws `value` message and stops compilation (if `lime.utils.Log.throwErrors` is set to `true`)

Example:

```
<section if="html5">
	<error value="html5 isn't supported!" />
</section>
```

</details>

<details>
<summary>&lt;haxedef /&gt;</summary>

Use `<haxedef />` tags to add Haxe defines (similar to using a `<haxeflag />` with "-D"):

```xml
<haxedef name="define" />
```

</details>

<details>
<summary>&lt;haxeflag /&gt;</summary>

Use `<haxeflag />` tags to add additional arguments in the Haxe compile process:

```xml
<haxeflag name="-dce" value="std" />
```

</details>

<details>
<summary>&lt;haxelib /&gt;</summary>

Use `<haxelib />` tags to include Haxe libraries:

```xml
<haxelib name="actuate" />
```

You can also specify a version, if you prefer:

```xml
<haxelib name="actuate" version="1.0.0" />
```

</details>

<details>
<summary>&lt;icon /&gt;</summary>

Use `<icon />` nodes to add icon files to your project. When the command-line tools request icons for a target platform, it will either use an exact size match you have provided, or it will attempt to find the closest match possible and resize. If you include an SVG vector icon, it should prefer this file over resizing bitmap files.

```xml
<icon path="icon.png" size="64" />
<icon path="icon.png" width="96" height="96" />
<icon path="icon.svg" />
```

</details>

<details>
<summary>&lt;include /&gt;</summary>

Use `<include />` tags to add the tags found in another project file, or to find an "include.xml" file in the target directory:

```xml
<include path="to/another/project.xml" />
<include path="to/shared/library" />
```

</details>

<details>
<summary>&lt;java /&gt;</summary>

Use `<java />` tags to add Java classes to the project when targeting Android:

```xml
<java path="to/classes" />
```

</details>

<details>
<summary>&lt;language /&gt;</summary>

Adds language to the list of supported languages (by default the list is empty)

`<language name="en-US" />`

</details>

<details>
<summary>&lt;launchimage /&gt;</summary>
Sets the path to launch image of the app (image which will be shown at application start up)

`<launchimage path="launchImage.png" />`
	
</details>

<details>
<summary>&lt;launchstoryboard /&gt;</summary>
Sets launch screen storyboard (useful only for iOS development)

`<launchstoryboard path="image.png" />`

or

`<launchstoryboard name="image.png" />`

You can also use `template` for it (will be documented in the future)

</details>

<details>
<summary>&lt;library /&gt;</summary>

All assets go into the “default” library, but by adding `<library>` tags it is possible to modify the default library and also define additional libraries and load/unload them as needed.

To disable preloading on the default library:

`<library name="default" preload="false" />`

To load assets at runtime,:

```haxe
Assets.loadLibrary ("default").onComplete (function (library) {

    var bitmapData = Assets.getBitmapData ("default:image.png");
    // or
    var bitmapData = Assets.getBitmapData ("image.png");
    // "default:" prefix is implied, if no library prefix is included
});
```

**Using Additional Asset Libraries**

You can easily add assets to libraries other than the “default” library. These are not preloaded by default, unless you add: `<library name="myOtherLibrary" preload="true" />`

Then to have certain assets allocated to the above library:
`<assets path="assets/other" library="myOtherLibrary" />`

Be sure to specify the correct library when retrieving the assets in your code. See the above example for using the library prefix.

You can also use `Assets.unloadLibrary` when you are doing using those resources.

</details>

<details>
<summary>&lt;log /&gt;</summary>
Logs error (see "error"), warning or info message.

Examples:

```
<log error="error message" />
<log warn="warn message" />
<log info="info message" />
<log value="your message" />
<log verbose="verbose message" />
```
	
</details>

<details>
<summary>&lt;meta /&gt;</summary>

Use `<meta />` tags to add information about your application, which usually will not affect how the application runs, but how it is identified to the target operating system or on an application store:

```xml
<meta title="My Application" package="com.example.myapplication" version="1.0.0" company="My Company" />
```
</details>

<details>
<summary>&lt;module /&gt;</summary>
More to come.
</details>

<details>
<summary>&lt;ndll /&gt;</summary>

You can use `<ndll />` tags to include native libraries. These are usually located under an "ndll" directory, with additional directories based upon the target platform. Usually an `<ndll />` tag will be included as a part of an extension, and is rare to be used directly:

```xml
<ndll name="std" haxelib="hxcpp" />
```

</details>

<details>
<summary>&lt;output /&gt;</summary>
More to come.
</details>

<details>
<summary>&lt;path /&gt;</summary>

Use `<path />` tags to add directories to your system's PATH environment variable.

```xml
<path value="path/to/add/to/system/PATH" />
```

</details>

<details>
<summary>&lt;postbuild /&gt;</summary>
More to come.
</details>

<details>
<summary>&lt;prebuild /&gt;</summary>
More to come.
</details>

<details>
<summary>&lt;preloader /&gt;</summary>
More to come.
</details>

<details>
<summary>&lt;sample /&gt;</summary>
More to come.
</details>

<details>
<summary>&lt;section /&gt;</summary>

The `<section />` tag is used to group other tags together. This is usually most valuable when combined with "if" and/or "unless" logic:

```xml
<section if="html5">
	<source path="extra/src/html5" />
</section>
```
</details>

<details>
<summary>&lt;set /&gt;</summary>

Use `<set />` tags to set variables for conditional logic. See the “Conditionals” section above.

```xml
<set name="red" />
```

</details>

<details>
<summary>&lt;setenv /&gt;</summary>

Use `<setenv />` tags to set environment variables:

```xml
<setenv name="GLOBAL_DEFINE" />
```

</details>

<details>
<summary>&lt;source /&gt;</summary>

Use `<source />` tags to add Haxe class paths:

```xml
<source path="Source" />
```

If you are using `@:file`, `@:bitmap`, `@:sound` or `@:file` tags in your project, be sure that the asset files are available within your Haxe source paths.

</details>

<details>
<summary>&lt;splashscreen /&gt;</summary>
Same as “launchimage”.
</details>

<details>
<summary>&lt;ssl /&gt;</summary>
More to come.
</details>

<details>
<summary>&lt;swf /&gt;</summary>
See “library“.
</details>

<details>
<summary>&lt;target /&gt;</summary>
More to come.
</details>

<details>
<summary>&lt;template /&gt;</summary>

Use `<template />` tags to add paths which can override the templates used by the command-line tools.

You can add a full template path like this:

```xml
<template path="templates" />
```

Otherwise, you can override a single file like this:

```xml
<template path="Assets/index.html" rename="index.php" />
```
</details>

<details>
<summary>&lt;templatepath /&gt;</summary>
More to come.
</details>

<details>
<summary>&lt;undefine /&gt;</summary>
More to come.
</details>

<details>
<summary>&lt;unset /&gt;</summary>
More to come.
</details>

<details>
<summary>&lt;window /&gt;</summary>

You can use `<window />` tags to control how an application will be initialized. This includes the screen resolution and background color, as well as other options, such as whether hardware should be allowed or display mode flags.

By default, mobile platforms use a window width and height of 0, which is a special value that uses the resolution of the current display. This is available on desktop platforms, but usually it is recommended to enable the `fullscreen` flag instead, and to set the `width` and `height` values to a good windowed resolution. There is a special `fps="0"` value for HTML5, which is default, which uses "requestAnimationFrame" instead of forcing a frame rate.

```xml
<window width="640" height="480" background="#FFFFFF" fps="30" />
<window hardware="true" allow-shaders="true" require-shaders="true" depth-buffer="false" stencil-buffer="false" />
<window fullscreen="false" resizable="true" borderless="false" vsync="false" />
<window orientation="portrait" />
```

The `orientation` value expects either "portrait" or "landscape" ... the default is "auto" which allows the operating system to decide which orientation to use.

</details>

