---
title: Setup AIR
---

[Adobe AIR](https://airsdk.dev) is a cross-platform framework used by a wide range of applications and games on desktop and mobile. AIR can run on Windows, macOS, Linux, iOS, and Android. While AIR was originally created by Adobe, it is currently maintained with active development of new features by HARMAN. See [The future of Adobe AIR](https://theblog.adobe.com/the-future-of-adobe-air/) and [HARMAN's AIR SDK Website](https://airsdk.dev) for more details.

## Automatic Install

There is no automatic setup available for Adobe AIR.

## Manual Install

In order to build applications using Adobe AIR, you must have the AIR SDK installed.

[Download the Adobe AIR SDK from HARMAN](https://airsdk.harman.com/download), and extract it on your system.

Next, open a command-prompt or terminal and run the following command (using the path to your AIR SDK):

```sh
lime config AIR_SDK path/to/air/sdk
```

## Build & Run

To compile an Adobe AIR application, run `lime build air`. Add the `-debug` option to create a build that can connect to a SWF debugger. Add the `-release` option to create a release build.

To compile and launch an Adobe AIR application with one command, run `lime test air`. The application will run on your computer using the AIR Debug Launcher (ADL).

To build an AIR app targeting Android, add the `-android` option. This will package an _.apk_ file.

To build an AIR app targeting iOS, add the `-ios` option. This will package an _.ipa_ file.

To build an AIR app for either Android or iOS, but test it in the AIR Debug Launcher (ADL) instead a device, add the `-air-simulator` option to skip packaging the _.apk_ or _.ipa_ file.

When targeting AIR for iOS, specify the `-appstore` option to create a build to be submitted to the iOS App Store. Alternatively, specify the `-adhoc` option for ad hoc distribution to specific devices outside of the App Store.

### Code Signing

During development, AIR builds will automatically use a self-signed certificate. To distribute AIR apps, you must specify [code signing](https://help.adobe.com/en_US/air/build/WS5b3ccc516d4fbf351e63e3d118666ade46-7f72.html) options. Code signing options may may be added to a `<certificate/>` element in your [_project.xml_](../../project-files/xml-format/) file. You may need to add the `if="air"` attribute, if your app targets any other platforms besides AIR.

To use a specific certificate file, specify the `path` attribute.

```xml
<certificate path="path/to/keystore.p12" if="air"/>
```

You should **not** save a keystore password in your [_project.xml_](../../project-files/xml-format/) file because it is a serious security risk. It is technically allowed, though.

```xml
<!-- you should NOT specify the password like this -->
<certificate path="path/to/keystore.p12" password="hunter2" if="air"/>
```

Instead, you have two options.

1. Specify the password on the command line. Example: `--certificate-password=hunter2`

2. Don't specify the password, and wait for the build to request it automatically.

Instead of using a certificate file, developers on macOS may sign iOS and macOS apps using credentials stored in their Keychain.

```xml
<certificate type="KeychainStore" alias="Apple Development: Team Name (XXXXXXXXXX)" if="air ios"/>
```

## Packaging for distribution

For projects targeting mobile, `lime build air -android` and `lime build air -ios` compile the _.swf_, copy all necessary assets, and package the Adobe AIR app as either _.apk_ or _.ipa_ for distribution to app stores. However, when targeting desktop, `lime build air` compiles the _.swf_ file and copies assets only. This is enough for debugging in the AIR Debug Launcher (ADL), but it is not enough to distribute the app to users.

To package an Adobe AIR desktop app for distrubution, run `lime build air` and then run `lime deploy air`.

## Using SWC libraries

To use a _.swc_ library with Haxe that was compiled from ActionScript, add Haxe's `-swf-lib` command line option. For instance, you can add it to your [_project.xml_](../../project-files/xml-format/) file using the [`<haxeflag/>`](../../project-files/xml-format/#haxeflag) element.

```xml
<haxeflag name="-swf-lib" value="path/to/example.swc"/>
```

## Using AIR Native Extensions

To use _.ane_ native extension files, add each one to your project's native dependencies. For instance, you can add it to your [_project.xml_](../../project-files/xml-format/) file using the [`<dependency/>`](../../project-files/xml-format/#dependency) element.

```xml
<dependency name="com.example.MyNativeExtension" path="path/to/com.example.MyNativeExtension.ane" if="air"/>
```

The `name` attribute is the native extension's ID. The `path` attribute is the relative path to the _.ane_ file.

## Advanced Configuration

The `<config:air />` element in your [_project.xml_](../../project-files/xml-format/) file is used to specify advanced configuration options for Adobe AIR. For a complete list of these advanced option, see [Config Values: Adobe AIR](../../project-files/xml-format/config/#adobe-air).

## Help & Forums

If you encounter any problems when setting up Lime for AIR, please visit the [forums](http://community.openfl.org/c/help) or [Discord](https://discord.gg/tDgq8EE).
