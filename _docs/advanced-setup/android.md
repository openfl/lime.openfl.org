---
title: Setup Android
---

Create native [Android](https://developer.android.com) mobile applications with Lime and OpenFL by [compiling to C++](https://haxe.org/manual/target-cpp-getting-started.html).

## Automatic Install

There is no automatic setup available for Android.

## Manual Install

Similar to standard Android native development, you will need the following installed:

 * [Android SDK](http://developer.android.com/sdk/index.html)
 * [Android NDK](http://developer.android.com/tools/sdk/ndk/index.html)
 * Java JDK

A variety of vendors offer free Java OpenJDK builds that work well with Lime, OpenFL, and Android. If you're not sure which one to choose, a good option is [Temurin OpenJDK from Adoptium.net](https://adoptium.net/).

After installing the Android SDK, you should install the `Android SDK platform-tools` and `Android API 26` packages from the Android SDK Manager. Gradle requires specific versions of the `Android SDK Build Tools`, and Lime will try to find the latest version installed. You can override this by setting `<config:android build-tools-version="" />` in your project file.

Lime uses API 26 to support modern Android features, but is still compatible with API 16 devices. You only need to install the newer API package.

Using the latest HXCPP, and targeting modern Android platforms properly, requires NDK version r15c. Newer versions are not compatible with the release version of HXCPP, but an update is coming soon that will support later releases.

The Android build tools did not properly support new versions of Java for a long time, but now Java 8 is recommended to work properly with the current Android Gradle build system. Make sure that you have a JDK version installed.

After these tools are installed, Lime still needs to know where they are installed. Open a command-prompt or terminal and run the following command:

```sh
lime setup android
```

When prompted to automatically download and install each component, type "n" and press enter. At the end, the setup process will ask for each location. When prompted, enter the path to where the Android SDK, NDK and other components are installed.

If you intend to use an Android emulator, create an AVD with hardware acceleration that targets Android 4.1 or greater. You may also need to install drivers for your Android device, before you can deploy to it. Note that x86 emulators and devices are supported.

## Build & Run

To compile an Android application bundle, run `lime build android`. Add the `-debug` option to create a debug build. Add the `-release` option to create a release build.

To compile and launch an Android application with one command, run `lime test android`. The app will run on a device connected to your computer with USB. Add the `-emulator` option to target the Android emulator included with the Android SDK instead of a device.

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

## Help & Forums

If you encounter any problems when setting up Lime for Android, please visit the [forums](http://community.openfl.org/c/help) or [Discord](https://discord.gg/tDgq8EE).
