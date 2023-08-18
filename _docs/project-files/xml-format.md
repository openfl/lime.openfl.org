---
title: XML Format
---

## Overview

Usually a simple project file is all you need to build projects using Lime or OpenFL, but it can be extended based on your needs. Here is a reference of what you can do.

### XML Schema

If you are using an XSD aware XML editor you can use the following declaration to enable XML validation and type hinting/auto completion.

```xml
<?xml version="1.0" encoding="utf-8"?>
<project
	xmlns="http://lime.openfl.org/project/1.0.4"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://lime.openfl.org/project/1.0.4 http://lime.openfl.org/xsd/project-1.0.4.xsd">
</project>
```

### Conditionals

First, every node in the project file format supports `if` and `unless` attributes. These are conditional values to help you customize your build process, based upon a number of values. Here are some of the default values:

 * mobile, desktop or web
 * ios, android, windows, mac, linux or html5
 * cpp, neko, flash or js

You can [`<set />`](#set) or [`<define />`](#define) values for conditional logic:

```xml
<set name="red" />
<window background="#FF0000" if="red" />

<define name="fullscreen" />
<window fullscreen="true" if="fullscreen" />
```

Both also support a `value` attribute, which can be retrieved later using the `${}` syntax.

```xml
<set name="color" value="#FF0000" if="red" />
<define name="color" value="#0000FF" if="blue" />

<window background="${color}" if="color" />
```

You can also check values that were defined on the command line:

```sh
lime test flash -Dblue
```

```xml
<window background="#0000FF" if="blue" />
```

If you need to have multiple values in a conditional, spaces imply an "and" and vertical bars imply an "or", like this:

```xml
<window width="640" height="480" if="define define2" unless="define3 || define4" />
```

### Build info

The `${}` syntax can get information about the build. You can use this data in a condition, print it, or pass it along to Haxe:

```
<set name="buildOrTest" if="${project.command == build} || ${project.command == test}" />
<echo value="Building for ${project.target} on a ${project.host} machine" if="buildOrTest" />
<define name="projectDirectory" value="${project.workingDirectory}" />
```

### Duplicates

You can include more than one copy of each tag, so do not worry about putting it all in one place. All of the values you define will be used. If you define the same value more than once, the last definition will be used.

```xml
<window width="640" />
<window height="480" />
```

### include.xml

If you create a haxelib, you can add _include.xml_ to the top-level directory. The build tools will automatically add the contents of the file to the user's project. You can use this to add binary dependencies, additional classpaths, etc.

## XML Tag Glossary

### app 

The `<app />` tag sets values important to building your project, including the entry point (main class), the output file directory, or if you want to customize the executable filename or define a custom preloader for a web platform:

```xml
<app main="com.example.MyApplication" file="MyApplication" path="Export" preloader="CustomPreloader" />
<app swf-version="11" />
```

You can retrieve this information later:

```xml
<echo value="App info: ${app.file} ${app.path}" />
```



### architecture 

Use `<architecture />` tags to set or exclude target-specific architectures. Depending on the target, values can include `arm64`, `armv7`, `armv7s`, `armv6`, `armv5`, `x86`, and `x64`.

By default, the only architecture built for Android will be `armv7`. For example, if you want to enable `armv6` and disable `armv7` you would set the `<architecture />` tag to:

```xml
<architecture name="armv6" exclude="armv7" if="android" />
```




### assets 

Use asset nodes to add resources to your project, available using `lime.Assets`.

The path attribute can point to either a file or a directory. These files will be copied (or embedded) in your final project, and can be accessed using the `lime.Assets` class.

For example, if you include the following node in your project file:

```xml
<assets path="images/MyImage.jpg" />
```

You can access it in your application like this:

```haxe
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





### certificate 

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

You can retrieve this information later:

```xml
<echo value="Certificate info: ${keystore.path} ${keystore.alias}" />
```




### classpath 

Same as [`<source/>`](#source).



### compilerflag 

Same as [`<haxeflag/>`](#haxeflag).



### config 

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

**One must append a suffix to the tag depending on the platform.**

For example, use `<config:android />` tags to set Android-specific values:

```xml
<config:android install-location="preferExternal" />
<config:android permission="android.permission.INTERNET" />
<config:android target-sdk-version="16" />
```

A complete list of Android permissions can be found at [Android: `Manifest.permission` API Reference](https://developer.android.com/reference/android/Manifest.permission.html).

Use `<config:ios />` tags to set iOS-specific values when compiling. The `deployment` attribute can set the minimum iOS version you wish to target. The `prerendered-icon` attribute can help control the style of your icon.

```xml
<config:ios deployment="5.1" />
<config:ios prerendered-icon="false" />
```

You can retrieve this information later:

```xml
<echo value="Android config info: ${config.android.target-sdk-version} ${config.android.minimum-sdk-version}" />
<echo value="iOS config info: ${config.ios.compiler} ${config.ios.deployment}" />
```




### define 

Sets a value to be used later. See the [Conditionals](#conditionals) section above.

```xml
<define name="color" value="blue" />
<define name="custom-value" />
```

These values will be available in Haxe and [templates](#template) using the syntax `::DEFINE_custom_value::`. Hyphens are converted to underscores in both cases.



### dependency 

Use `<dependency />` tags to specify native frameworks or references that are required to compile your project, as well as additional libraries you need copied.

When targeting [iOS](../../advanced-setup/ios/), it may be used to add a native framework.

```xml
<dependency name="GameKit.framework" if="ios" />
```

When targeting [Android](../../advanced-setup/android/), it may be used to add a native library.

```xml
<dependency name="example-sdk" path="dependencies/android/example-sdk" if="android" />
```

When targeting [Adobe AIR](../../advanced-setup/air/), it may be used to add a native extension.

```xml
<dependency name="com.example.MyNativeExtension" path="path/to/com.example.MyNativeExtension.ane" if="air"/>
```



### echo 

Prints a specified message to the console.

```xml
<echo value="Some output message" />
```

The `<echo/>` element is often combined with `if` or `unless`.

```xml
<echo value="You are using advanced mode. Proceed with caution!" if="advanced_mode"/>
```

Or it may be added inside a `<section/>` element:

```xml
<section if="advanced_mode">
	<error value="You are using advanced mode. Proceed with caution!" />
</section>
```




### error 

Logs an error with `lime.utils.Log.error()` which by default throws `value` message and stops compilation (if `lime.utils.Log.throwErrors` is set to `true`).

The `<error/>` element is often combined with `if` or `unless`.

```xml
<error value="html5 isn't supported!" if="html5 />
```

Or it may be added inside a `<section/>` element:

```xml
<section if="html5">
	<error value="html5 isn't supported!" />
</section>
```




### haxedef 

Use `<haxedef />` tags to add Haxe defines (similar to using a [`<haxeflag />`](#haxeflag) with "-D"):

```xml
<haxedef name="define" />
```




### haxeflag 

Use `<haxeflag />` tags to add additional [Haxe compiler arguments](https://haxe.org/manual/compiler-usage.html):

```xml
<haxeflag name="-dce" value="std" />
```




### haxelib 

Use `<haxelib />` tags to include [Haxe libraries](https://lib.haxe.org):

```xml
<haxelib name="actuate" />
```

You can also specify a version, if you prefer:

```xml
<haxelib name="actuate" version="1.0.0" />
```




### icon 

Use `<icon />` nodes to add icon files to your project. When the command-line tools request icons for a target platform, it will either use an exact size match you have provided, or it will attempt to find the closest match possible and resize. If you include an SVG vector icon, it should prefer this file over resizing bitmap files.

```xml
<icon path="icon.png" size="64" />
<icon path="icon.png" width="96" height="96" />
<icon path="icon.svg" />
```




### include 

Use `<include />` tags to add the tags found in another project file, or to find an _include.xml_ file in the target directory:

```xml
<include path="to/another/project.xml" />
<include path="to/shared/library" />
```




### java 

Use `<java />` tags to add Java classes to the project when targeting Android:

```xml
<java path="to/classes" />
```




### language 

Adds a language to the list of supported languages (by default the list is empty).

```xml
<language name="en-US" />
```




### launchImage 

Sets the path to launch image of the app (image which will be shown at application start up)

```xml
<launchImage path="launchImage.png" />
```
	



### launchStoryboard 

Sets the launch screen storyboard (useful only for iOS development).

```xml
<launchStoryboard path="image.png" />
```

or

```xml
<launchStoryboard name="image.png" />
```

You can also use `template` for this purpose.

**The default template**

The launch storyboard feature uses Haxe templates and your _project.xml_ configuration to generate an Xcode storyboard file. Lime includes one default storyboard template `splash.storyboard`, which can be configured with the following options.

```xml
<launchStoryboard template="splash.storyboard" assetsPath="Images/splash"
	bg:RGB="0xFFFFFF"
	contentMode="center"
	ipad="ipad-splash-sb.png"
	portrait="iphone-splash-sb.png">
	
	<imageset name="ipad-splash-sb.png" />
	<imageset name="iphone-splash-sb.png" />
	
</launchStoryboard>
```

`template` is the specific storyboard template you’re using, chosen from the templates available at `templates/ios/storyboards`.

`assetsPath` is the path from your openfl/lime project root to where your launch storyboard images are saved.

`bg` is a hexadecimal formatted color to use as the background, in case you’re not using a full-screen content mode.

`contentMode` determines how the image scales to fit the screen.

- `center` is unscaled
- `scaleAspectFill` scales to fill the entire screen, with original aspect ratio
- `scaleAspectFit` scales to fit inside the screen (letterbox), with original aspect ratio
- `scaleToFill` stretches the image to fill the screen

There are three optional attributes, (`portrait`, `landscape` and `ipad`) which you can choose from based on the target devices and orientation of your game. (The above example includes just ipad and portrait.)

- `ipad` determines the image to use for iPads.
- `portrait` determines the image to use for iPods and iPhones in portrait orientation.
- `landscape` determines the image to use for iPods and iPhones in landscape orientation.

Finally, you have the `imageset` child elements. For each imageset, lime looks for `{name}.png`, `{name}@2x.png`, and `{name}@3x.png` in the specified `assetsPath`, copying any of those that exist into an Xcode imageset. Most iPhones these days require the @2x or @3x image, while iPads require @2x.

**About templates and custom storyboard**

`template`, `assetsPath`, and the `imageset` elements are standard parts of the configuration. All the other attributes listed above are available based on the chosen default template, `splash.storyboard`.

If the default template doesn’t meet your needs, you have two options, but both require you to open your exported iOS project in Xcode and create your own storyboard.

1. Take the storyboard you built in Xcode and put it into your project. In this case, you would use the name or path attribute instead of template, and you would have no template-specific attributes to set, but you would still need to provide the appropriate imagesets.

```xml
<launchStoryboard path="custom.storyboard" assetsPath="Images/splash">	
	<imageset name="ipad-splash-sb.png" />
</launchStoryboard>
```

2. Using the default template as an example, take the storyboard you built in Xcode and add it to your lime templates. You would use it in the same manner as the default template, but use any attributes you specified instead.



### library 

All assets go into the "default" library, but by adding `<library>` tags it is possible to modify the default library and also define additional libraries and load/unload them as needed.

To disable preloading on the default library:

```xml
<library name="default" preload="false" />
```

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

You can easily add assets to libraries other than the "default" library. These are not preloaded by default, unless you add:

```xml
<library name="myOtherLibrary" preload="true" />
```

Then to have certain assets allocated to the above library:

```xml
<assets path="assets/other" library="myOtherLibrary" />
```

Be sure to specify the correct library when retrieving the assets in your code. See the above example for using the library prefix.

You can also use `Assets.unloadLibrary` when you are doing using those resources.




### log 

Logs an error (see [`<error/>`](#error)), warning or info message.

Examples:

```xml
<log error="error message" />
<log warn="warn message" />
<log info="info message" />
<log value="your message" />
<log verbose="verbose message" />
```

The `<log/>` element is often combined with `if` or `unless`.

```xml
<log info="You are using advanced mode. Proceed with caution!" if="advanced_mode"/>
```
	
```xml
<log error="Missing this_is_required" unless="this_is_required"/>
```

Or it may be added inside a `<section/>` element:

```xml
<section if="advanced_mode">
	<log info="You are using advanced mode. Proceed with caution!" />
</section>
```



### meta 

Use `<meta />` tags to add information about your application, which usually will not affect how the application runs, but how it is identified to the target operating system or on an application store:

```xml
<meta title="My Application" package="com.example.myapplication" version="1.0.0" company="My Company" />
```

You can retrieve this information later:

```xml
<echo value="Metadata: ${meta.title} ${meta.version}" />
```


### module 

More to come.



### ndll 

You can use `<ndll />` tags to include native libraries. These are usually located under an "ndll" directory, with additional directories based upon the target platform. Usually an `<ndll />` tag will be included as a part of an extension, and is rare to be used directly:

```xml
<ndll name="std" haxelib="hxcpp" />
```




### output 

**Deprecated!** Use the [`<app/>`](#app) element instead.

Can be used for setting app file name, app path and app swf-version:

```xml
<output name="app file name" />
<output name="app path" />
<output swf-version="11" />
```




### path 

Use `<path />` tags to add directories to your system's PATH environment variable.

```xml
<path value="path/to/add/to/system/PATH" />
```




### postbuild 

Lets you set post-build commands such as Haxe code (interpeted by the Haxe interpreter), a run file command, or a console command.

```xml
<postbuild haxe="Haxe code"/>
<postbuild open="file to run"/>
<postbuild command="command to run"/>
<postbuild cmd="command to run"/>
```




### prebuild 

Lets you set pre-build commands such as Haxe code (interpeted by the Haxe interpreter), a run file command, or a console command:

```xml
<prebuild haxe="Haxe code"/>
<prebuild open="file to run"/>
<prebuild command="command to run"/>
<prebuild cmd="command to run"/>
```



### preloader 

**Deprecated!** Use [`<app preloader="preloaderClass" />`](#app) instead.
	
```xml
<preloader name="preloaderClass" />
```




### sample 

In a library that targets Lime, makes a sample available using the `lime create` command.

```xml
<sample path="${haxelib:flixel-demos}/Arcade" />
```

Then you can use:

```sh
lime create flixel:Arcade
```


### section 

The `<section />` tag is used to group other tags together. This is usually most valuable when combined with "if" and/or "unless" logic:

```xml
<section if="html5">
	<source path="extra/src/html5" />
</section>
```



### set 

Use `<set />` tags to set variables for conditional logic. See the [Conditionals](#Conditionals) section above.

```xml
<set name="color" value="red" />
<set name="custom-value" />
```

These values will be available in [templates](#template) using the syntax `::SET_custom_value::`. (Hyphens are converted to underscores.)




### setenv 

Use `<setenv />` tags to set environment variables. See the [Conditionals](#Conditionals) section above.

```xml
<setenv name="GLOBAL_DEFINE" />
```




### source 

Use `<source />` tags to add Haxe class paths:

```xml
<source path="Source" />
```

If you are using `@:file`, `@:bitmap`, `@:sound` or `@:file` tags in your project, be sure that the asset files are available within your Haxe source paths.




### splashscreen 

Same as [`<launchimage/>`](#launchimage).



### ssl 

Not implemented



### swf 

See [`<library/>`](#library).



### target 

Lets you redefine the build process for a specific target by running a custom haxelib command. This might be useful if you want to use your own library for building your project, i.e. you know what you're doing and you know how the Lime build system works.
	
```xml
<target name="customTarget" handler="yourHandler" />
```




### template 

Use `<template />` tags to add paths which can override the templates used by the command-line tools.

You can add a full template path like this:

```xml
<template path="templates" />
```

Otherwise, you can override a single file like this:

```xml
<template path="Assets/index.html" rename="index.php" />
```



### templatepath 

See [`<template/>`](#template).

```xml
<templatepath name="path"/>
```




### undefine 

Unsets a previously defined flag. See entry for [`<define/>`](#define).

```xml
<undefine name="red" />
```




### unset 

Unsets a previously set value. See entry for [`<set/>`](#set).
	
```xml
<set name="red" value="0xff0000" />
<unset name="red" />
```




### window 

You can use `<window />` tags to control how an application will be initialized. This includes the screen resolution and background color, as well as other options, such as whether hardware should be allowed or display mode flags.

By default, mobile platforms use a window width and height of 0, which is a special value that uses the resolution of the current display. This is available on desktop platforms, but usually it is recommended to enable the `fullscreen` flag instead, and to set the `width` and `height` values to a good windowed resolution. There is a special `fps="0"` value for HTML5, which is default, which uses "requestAnimationFrame" instead of forcing a frame rate.

```xml
<window width="640" height="480" background="#FFFFFF" fps="30" />
<window hardware="true" allow-shaders="true" require-shaders="true" depth-buffer="false" stencil-buffer="false" />
<window fullscreen="false" resizable="true" borderless="false" vsync="false" />
<window orientation="portrait" />
```

The `orientation` value expects either "portrait" or "landscape" ... the default is "auto" which allows the operating system to decide which orientation to use.

You can retrieve this information later:

```xml
<echo value="Window info: ${window.fps} ${window.allowShaders}" />
```



