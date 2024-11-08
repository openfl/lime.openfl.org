---
title: Setup Android
---

Create native [Android](https://developer.android.com) mobile applications with Lime and OpenFL by [compiling to C++](https://haxe.org/manual/target-cpp-getting-started.html).

## Automatic Install

There is no automatic setup available for Android.

## Manual Install

> **Warning!** Haxe 4.3 with hxcpp 4.3.2 on Haxelib cannot build working Lime apps for Android. The app builds, but when run on a device, it results in an SDL error about `__atomic_compare_exchange_4` on app startup.
> 
> There are two known workarounds:
> 
> * Downgrade to Haxe 4.2 and hxcpp 4.2
> * Install a development build of hxcpp from GitHub to use Haxe 4.3
>
> At the time that you are reading this, if there is a newer version of hxcpp than 4.3.2 on Haxelib, you should be able to use that newer version without any of the above workarounds.

Similar to standard Android native development, you will need the following installed:

 * Java JDK
 * Android SDK
 * Android NDK

### Java JDK

JDK version 11 or newer is recommended.

A variety of vendors offer free Java OpenJDK builds that work well with Lime, OpenFL, and Android. If you're not sure which one to choose, a good option is [Temurin OpenJDK from Adoptium.net](https://adoptium.net/).

### Android SDK and NDK

To install the Android SDK and NDK, using [Android Studio](https://developer.android.com/studio) is recommended. Android Studio contains an **SDK Manager** that allows you to install all of the SDK and NDK components that you need (including the ability to select specific versions, if necessary).

#### SDK Platforms

In the **SDK Platforms** tab in Android Studio's SDK Manager, you should generally be able to install the newest **API Level**.

_Note:_ See [Meet Google Play's target API level requirement](https://developer.android.com/google/play/requirements/target-sdk) for details about which API levels Google currently requires for new apps and for updates.

#### SDK Tools

In the **SDK Tools** tab in Android Studio's SDK Manager, you will need to install a few items.

You should generally be able to install the newest **Android SDK Build-Tools**.

**NDK (Side by side)** version r21e (21.4.7075529) is currently recommended for Lime.

> _Warning:_ hxcpp 4.3.2 and older on Haxelib do not support newer NDKs than r21e. When the next update after hxcpp 4.3.2 is released, it should support newer NDKs (at least up to NDK version 25).

You should generally be able to install the newest **Android SDK Platform-Tools**.

#### Configuring Lime for Android development

After all of the Android SDK and NDK tools are installed, Lime must be configured with their file system paths. Open a command prompt or terminal, and run the following command:

```sh
lime setup android
```

If prompted to automatically download and install any components, type the letter `n` (for "no") and press Enter. Then, the setup process will ask for the location of each component. When prompted, enter the path to where the Android SDK, NDK and any additional components are installed.

Typically, when the Android SDK is installed by Android Studio, it is located at a standard location on each platform (specify the appropriate _username_ and _version_, as necessary):

- Windows: _C:\Users\\**username**\AppData\Local\Android\Sdk_
- macOS: _~/Library/Android/sdk_
- Linux: _~/Android/Sdk_

Android Studio installs the NDK inside the SDK. The default location for each platform should be similar to below (specify the appropriate _username_ and _version_, as necessary):

- Windows: _C:\Users\\**username**\AppData\Local\Android\Sdk\ndk\\**version**_
- macOS: _~/Library/Android/sdk/ndk/**version**_
- Linux: _~/Android/Sdk/ndk/**version**_

The Java JDK may be installed to a variety of locations, depending on the current operating system, and which JDK distribution was selected:

- Windows: Typically, Java is installed somewhere in _C:\Program Files_, such as _C:\Program Files\Java_ or _C:\Program Files\Temurin_.
- macOS: Run the **/usr/libexec/java_home** command in the Terminal app to find the JDK location.
- Linux: The location depends on your distribution and package manager.

## Build & Run

To compile an Android application bundle, run `lime build android`. Add the `-debug` option to create a debug build. Add the `-release` option to create a release build.

To compile and launch an Android application with one command, run `lime test android`. The app will run on a device connected to your computer with USB.

> _Note:_ In some cases, you may need to install drivers on your computer for your Android device before you can deploy an app to it.

> _Note:_ The first time that you compile a project for C++, it will take a noticably long time. However, compiling the same project again should be significantly faster because parts of your code that have not changed do not need to be recompiled. To force all of code to be recompiled for C++, use the `-clean` option.

### Code Signing

During development, Android builds will automatically use a self-signed certificate. To distribute an Android app, you must specify [code signing](https://developer.android.com/studio/publish/app-signing) options. These may be added to a `<certificate/>` element in your [_project.xml_](../../project-files/xml-format/) file. You may need to add the `if="android"` attribute, if your app targets any other platforms besides Android.

Specify the `path` and `alias` attributes for your certificate.

```xml
<certificate path="path/to/keystore.p12" alias="1" if="android"/>
```

> **Need to know which aliases are included in your certificate?**
> 
> Open a terminal, and run the following command to list the keystore entries, including alias names:
>
> ```sh
> keytool -list -v -keystore path/to/keystore.p12
> ```
>
> If the **keytool** command is not available on the system path, you may be able to find it in a Java JDK.

You should **not** save a keystore password in your [_project.xml_](../../project-files/xml-format/) file because it is a serious security risk. It is technically allowed, though.

```xml
<!-- you should NOT specify the password like this -->
<certificate path="path/to/keystore.p12" alias="1" password="hunter2" if="android"/>
```

Instead, you have two options.

1. Specify the password on the command line. Example: `--certificate-password=hunter2`

2. Don't specify the password, and wait for the build to request it automatically.

## Advanced Configuration

The `<config:android />` element in your [_project.xml_](../../project-files/xml-format/) file is used to specify advanced configuration options for Android. A few of the more commonly-used advanced configuration options for Android are documented below. For more details about the available advanced options, see [Config Values: Android](../../project-files/xml-format/config/#android).

The `<config:cpp />` element in your [_project.xml_](../../project-files/xml-format/) file is used to specify advanced configuration options for C++. For a complete list of these advanced option, see [Config Values: C++](../../project-files/xml-format/config/#c).

### Target and Minimum SDK Versions

If Lime's default values for Android's `targetSdkVersion` and `minSdkVersion` don't meet your project's needs, you can specify custom values in your [_project.xml_](../../project-files/xml-format/) file.

```xml
<config:android target-sdk-version="23"/>
```

```xml
<config:android minimum-sdk-version="14"/>
```

### Android Build Tools Version

Gradle requires specific versions of the **Android SDK Build-Tools**, and Lime will try to find the latest version installed.

If Lime's default values for Android's build tools version doesn't meet your project's needs, you can specify a custom value in your [_project.xml_ file](../project-files/xml-format/).

```xml
<config:android build-tools-version="35" />
```

### Gradle Versions

If Lime's default values for Gradle versions used to build for Android don't meet your project's needs, you can specify custom values in your [_project.xml_](../../project-files/xml-format/) file.

```xml
<config:android gradle-version="7.4.2" gradle-plugin="7.3.1" />
```

### Permissions

If Lime's default values for Android permissions don't meet your project's needs, you can specify custom values in your [_project.xml_](../../project-files/xml-format/) file.

```xml
<config:android permission="android.permission.ACCESS_FINE_LOCATION" />
```

Use multiple tags to specify more than one permission.

```xml
<config:android permission="android.permission.INTERNET" />
<config:android permission="android.permission.ACCESS_NETWORK_STATE" />
```

### Gradle Tasks

By default, Lime builds an APK file using the `assembleDebug` or `assembleRelease` task, depending on whether you [provide a certificate file](#code-signing). To build an [Android App Bundle](https://developer.android.com/guide/app-bundle) instead, you can specify the `bundleDebug` or `bundleRelease` task in your [_project.xml_](../../project-files/xml-format/) file.

```xml
<setenv name="ANDROID_GRADLE_TASK" value="bundleRelease" />
```

Once built, the AAB file will appear in your export directory, at _android/bin/app/build/outputs/bundle/`[build type]`/app-`[build type]`.aab_.

You can specify other tasks this way as well, or pass additional space-separated arguments.

## Android Emulator

If you intend to test with the Android emulator, you create an AVD in **Android Studio** in the **Virtual Device Manager**.

Add the `-emulator` option to your `lime build android` or `lime test android` command to target the Android emulator instead of a device.

## Help & Forums

If you encounter any problems when setting up Lime for Android, please visit the [forums](http://community.openfl.org/c/help) or [Discord](https://discord.gg/tDgq8EE).
