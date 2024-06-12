---
title: config values
---

## Overview

The [`<config />` tag](/docs/project-files/xml-format/#config) has a large number of options, too many to document in the XML Format glossary.

Most targets share the `output-directory` option, which allows you to choose where in your Export folder that target goes.

```xml
<config:android output-directory="android" /> <!-- Export/android/ -->
<config:windows output-directory="my-windows-folder" /> <!-- Export/my-windows-folder/ -->
<config:flash output-directory="swf" /> <!-- Export/swf/ -->
```

The following targets have additional unique options.

### C++

These options are shared by all targets that use C++, including Android, iOS, Windows, Mac, and Linux.

```xml
<config:cpp requireBuild="true" />
<config:cpp buildLibrary="hxcpp" />
```

These options configure how `lime rebuild` compiles a C++ library project.

```xml
<config:project>
	<rebuild path="project" /> <!-- C++ code is stored in project/. -->
	<rebuild file="Build.xml" /> <!-- Get build info from project/Build.xml. -->
	<rebuild fullDebug="true" /> <!-- Also build debug NDLL if debug/release not specified. -->
</config:project>
```

### Adobe AIR

```xml
<config:air sdk-version="28.0" />
<config:air profile="extendedDesktop" /> <!-- set a custom AIR device profile -->
<config:air connect="hostString" /> <!-- connect to a remote debugger at the specified host -->
<config:air listen="port" /> <!-- listen for a connection from a remote debugger on the specified port  -->

<config:ios device="universal" /> <!-- See iOS section. -->
```

### Android

```xml
<config:android install-location="auto" />
<config:android minimum-sdk-version="21" />
<config:android target-sdk-version="30" />
<config:android build-tools-version="30.0.2" />

<!-- <https://developer.android.com/reference/android/Manifest.permission.html> -->
<config:android permission="android.permission.INTERNET" />
<config:android permission="android.permission.ACCESS_NETWORK_STATE" />

<!-- Use `openfl create extension` to create an extension. This will also generate the correct config tag. -->
<config:android extension="path/to/extension" />

<config:android gradle-version="7.4.2" />
<config:android gradle-plugin="7.3.1" />
<config:android useAndroidX="true" />
<config:android enableJetifier="false" />
<!-- Build files will be created in gradle-build-directory. This helps work around Windows's file path length limit, and shouldn't be needed unless you run into that limit. -->
<config:android gradle-build-directory="C:/gradle-builds" />
```

### HTML5

```xml
<config:html5 dependency-path="lib" />
```

### iOS

```xml
<config:ios device="universal" /> <!-- Other options: "iphone", "ipad" -->
<config:ios deployment="9.0" />

<config:ios prerenderedIcon="false" />

<config:ios identity="iPhone Developer" />
<config:ios provisioning-profile="12345678-9012-3456-7890-123456789012" />
<config:ios team-id="ABCDEFGHIJ" />

<config:ios non-exempt-encryption="true" />
<config:ios allow-insecure-http="*" />

<config:ios enable-bitcode="false" />
<config:ios compiler="clang" />
<config:ios linker-flags="-stdlib=libc++" />
```

### tvOS

```xml
<config:tvos device="appletv" />
<config:tvos deployment="9.0" />

<config:tvos identity="tvOS Developer" />

<config:tvos prerenderedIcon="false" />

<config:tvos non-exempt-encryption="true" />

<config:tvos compiler="clang" />
<config:tvos linker-flags="-stdlib=libc++" />
```

### Webassembly

```xml
<config:webassembly dependency-path="lib" />
```
