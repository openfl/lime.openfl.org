---
title: Defines
---

## Overview

Lime reads a number of defines for [conditional compilation](https://haxe.org/manual/lf-condition-compilation.html). Some of them are set by Lime for every build, so your code and project file can check which target, renderer or audio backend is in use. Others are yours to set, to choose a renderer, turn a feature off, or change a default.

To add a define, use the `-D` option on the command line:

```sh
lime test html5 -Dcanvas
```

Or add it to your [_project.xml_](../xml-format/) file:

```xml
<define name="lime-default-timeout" value="10000" />
<haxedef name="lime_disable_gpu_hint" />
<set name="FULL_LOGCAT" />
```

- `-D` on the command line and [`<define />`](../xml-format/#define) reach both your Haxe code and the [conditionals](../xml-format/#conditionals) in your project file.
- [`<haxedef />`](../xml-format/#haxedef) reaches Haxe code only.
- [`<set />`](../xml-format/#set) reaches the project file and the command-line tools, but not Haxe code.

In Haxe code, write hyphens as underscores. A define added with `-Dlime-default-timeout` is checked with `#if lime_default_timeout`:

```haxe
#if lime_webgl
trace("Rendering with WebGL");
#elseif lime_opengl
trace("Rendering with OpenGL");
#end
```

In a project file, a condition matches the name exactly as it was written, so use the spelling shown on this page:

```xml
<haxedef name="lime_skip_invisible_windows" if="desktop" />
<dependency path="lib/extra.js" if="lime-webgl" />
```

This page lists the defines that are specific to Lime. Haxe and hxcpp have many more of their own, such as `debug`, `js`, `cpp` and `HXCPP_M64`. See [Global Compiler Flags](https://haxe.org/manual/compiler-usage-flags.html) in the Haxe manual for those. OpenFL adds defines of its own, listed in [OpenFL Defines](https://www.openfl.org/learn/haxelib/docs/defines/).

Defines marked _Lime 8.4.0_ are not available in earlier versions.

## Set by Lime

### Targets and platforms

Each build defines the name of its target and the type of platform it runs on.

| Define | Set when building for |
|---|---|
| `windows`, `mac`, `linux` | That desktop operating system. Using `macos` as the target name also sets `macos`. |
| `android`, `ios`, `tvos` | That mobile operating system. |
| `html5` | [HTML5](../../advanced-setup/html5/), including [Electron](../../advanced-setup/electron/), which also sets `electron`. |
| `flash`, `air` | Flash Player, or [Adobe AIR](../../advanced-setup/air/), which sets both. |
| `webassembly`, `wasm`, `emscripten` | [WebAssembly](../../advanced-setup/webassembly/). All three are set together. |
| `rpi` | The Raspberry Pi. Pressing Ctrl+Escape quits the application. |
| `desktop` | Windows, macOS, Linux and AIR on the desktop. |
| `mobile` | Android, iOS, tvOS and AIR with `-ios` or `-android`. |
| `web` | HTML5, Flash and WebAssembly. |
| `native` | Any target that compiles to native code: C++, [HashLink](../../advanced-setup/hashlink/) or [Neko](../../advanced-setup/neko/). |
{: .table}

The language a target compiles to is a Haxe define, such as `cpp`, `hl`, `neko`, `js` or `flash`. On desktop targets, Lime chooses it from flags such as `-hl` or `-neko`. In a project file, `hlc` is also set when building HashLink/C with `-hlc`.

### Build type and project values

| Define | Description |
|---|---|
| `debug`, `release`, `final` | The build type. `debug` is set by `-debug` and `final` by `-final`. `release` is set when neither is used, and is only available in the project file. |
| `lime` | Lime is in use. In Haxe code it holds the Lime version, as with any haxelib. |
| `tools` | The project was compiled by the Lime command-line tools. Holds the tools version. It is not set when building from a plain _.hxml_ file, in which case Lime sets the target and backend defines below with a macro. |
| `static_link` | Building with the `-static` flag, which links Lime's native library into the executable. |
| `lime-tools`, `hxp` | The project is being read by Lime's command-line tools. Project file only. |
| `setup`, `create`, `rebuild` | Lime is running `lime setup`, `lime create` or `lime rebuild`. Project file only. |
{: .table}

A few more values are available in the project file with the `${}` syntax, for example `<echo value="${targetType}" />` or `if="${buildType == final}"`:

| Value | Description |
|---|---|
| `target`, `platform` | The target name, such as `windows` or `html5`. |
| `targetType` | What the target compiles to: `cpp`, `hl`, `neko`, `js` or `swf`. |
| `platformType` | `desktop`, `mobile`, `web` or `console`. |
| `buildType` | `debug`, `release` or `final`. |
| `host` | The operating system running the tools: `windows`, `mac` or `linux`. |
{: .table}

### Backends

These defines say which of Lime's backends the current target uses, so you can write code for one backend in particular.

| Define | Description |
|---|---|
| `lime-native`, `lime-html5` | Lime's native or HTML5 backend. |
| `lime-cffi` | Lime's native library is available. Set on native targets. |
| `lime-opengl` | Desktop OpenGL. Native desktop targets. |
| `lime-opengles` | OpenGL ES. Android, iOS, tvOS and WebAssembly. |
| `lime-webgl` | WebGL. HTML5. |
| `lime-canvas`, `lime-dom` | The Canvas 2D and DOM render contexts. HTML5. |
| `lime-cairo` | Cairo software rendering. Native targets. |
| `lime-vulkan` | Vulkan support. Set for C++ on Windows and Linux, and on other native targets with `vulkan`. _Lime 8.4.0_ |
| `lime-harfbuzz` | HarfBuzz text shaping. Native targets. |
| `lime-curl` | HTTP requests through libcurl. Native targets except WebAssembly. |
| `lime-openal` | OpenAL audio. Native targets. |
| `lime-openalsoft` | OpenAL Soft. Windows, macOS, Linux and Android, unless built with `-static`. |
| `lime-mojoal` | MojoAL, an OpenAL built on SDL audio. Used in place of OpenAL Soft for static builds. |
| `lime-vorbis` | Ogg Vorbis decoding. Native targets. |
| `lime_sdl_sound` | Audio decoding and streaming through SDL_sound. Native targets. _Lime 8.4.0_ |
| `lime-howlerjs`, `howlerjs` | Audio through [howler.js](https://howlerjs.com/). HTML5. `howlerjs` adds the script to the page. |
| `lime-webview` | Native support for `lime.ui.WebView`. Native targets, unless `no-webview` is defined. _Lime 8.4.0_ |
| `lime-threads` | Background work, such as `ThreadPool` and `Future`, runs on other threads, or in web workers on HTML5. Set for C++, HashLink, Neko and HTML5, except WebAssembly. |
| `disable_preloader_assets` | The project has no assets, so the asset manifest is not loaded or preloaded. |
| `hxcpp_mbedtls_provider` | For static C++ builds, such as iOS, tvOS and `-static`, hxcpp's `sys.ssl` is built on Lime's copy of mbedTLS, so the application links only one. Lime leaves it alone if you define it yourself. _Lime 8.4.0_ |
| `no-compilation` | Haxe writes the C++ sources and Lime runs hxcpp itself. |
{: .table}

## Defines you can set

### Rendering

| Define | Description |
|---|---|
| `canvas` | HTML5: draw with the Canvas 2D API instead of WebGL. |
| `dom` | HTML5: draw with the HTML DOM instead of WebGL. |
| `webgl` | HTML5: always ask for WebGL, even if the window attributes prefer software rendering. |
| `webgl1` | HTML5: use WebGL 1 even where WebGL 2 is available. |
| `cairo` | Native: draw with Cairo in software instead of OpenGL. |
| `vulkan` | Native: windows that do not name a context type use Vulkan, and fall back to OpenGL where Vulkan is not available. On native targets other than Windows and Linux, such as Android, it also turns on `lime-vulkan`. _Lime 8.4.0_ |
| `no-vulkan` | Build without Vulkan. `lime-no-vulkan` does the same. _Lime 8.4.0_ |
| `software-gl` | Windows, macOS and Linux: when OpenGL cannot create a window, try OpenGL drawn in software before falling back to Cairo. On Windows this copies Mesa from the `lime-mesa` haxelib into a _mesa_ folder next to the application. Set the environment variable `LIME_SOFTWARE_GL=1` to test it. _Lime 8.4.0_ |
| `angle` | Windows: copy the [ANGLE](https://chromium.googlesource.com/angle/angle) libraries next to the application, to draw OpenGL ES through Direct3D. Lime's native library must be rebuilt with `lime rebuild windows -Dangle`. |
| `webgl-debug` | HTML5: wrap the WebGL context with the WebGL debug utilities, which report errors as they happen. |
| `stats` | HTML5: show a [stats.js](https://github.com/mrdoob/stats.js/) frame rate panel. |
{: .table}

### Audio

| Define | Description |
|---|---|
| `force_html5_audio` | HTML5: have howler.js play sounds with HTML5 audio elements instead of the Web Audio API. |
| `native_audio_buffers` | Native: the number of buffers queued for streamed audio, such as `-Dnative_audio_buffers=4`. The default is 3. |
| `lime_audio_no_stream_thread` | Native: refill streamed audio from the main thread instead of a thread of its own. _Lime 8.4.0_ |
{: .table}

### Threads and memory

| Define | Description |
|---|---|
| `force-synchronous` | Do not define `lime-threads`, so background work runs on the main thread. |
| `HXCPP_GC_INCREMENTAL` | C++: with the `libhxcpp` haxelib, use its incremental garbage collector, and advance a collection in the time left before each frame. Without libhxcpp, the compiler warns that hxcpp ignores it. _Lime 8.4.0_ |
| `no-idle-gc` | Do not advance the incremental collector between frames. _Lime 8.4.0_ |
{: .table}

### Networking

| Define | Description |
|---|---|
| `lime-default-timeout` | The default `HTTPRequest.timeout`, in milliseconds, such as `-Dlime-default-timeout=10000`. The default is 30000. |
| `lime-insecure-https` | Make `false` the default for `HTTPRequest.verifyCertificates`, for servers with self-signed certificates. _Lime 8.4.0_ |
| `allow_status_0` | HTML5: treat an HTTP status of 0 as success, as when loading from `file://`. |
| `curl_verbose` | Native: have libcurl print the details of each request. |
{: .table}

### Windows and input

| Define | Description |
|---|---|
| `lime_disable_gpu_hint` | Windows (C++): do not ask laptops with two graphics cards to run the application on the faster one. |
| `lime_disable_window_override` | Native: ignore `--window-*` arguments passed to the application, such as `--window-fullscreen=true`, which otherwise override the window attributes in the project file. |
| `lime_disable_window_scale_change` | Keep the scale a window was created with, instead of following changes to the display scale. _Lime 8.4.0_ |
| `lime_skip_invisible_windows` | Native: do not render windows that are hidden. _Lime 8.4.0_ |
| `lime_enable_html5_ime` | HTML5: use a text field for text input on Android, so input methods work. By default Lime uses a password field there, to avoid IME issues. |
{: .table}

### Assets

| Define | Description |
|---|---|
| `lime-assets-version` | Web targets add a number to the URL of each asset, so browsers do not use an old copy after an update. By default the number changes with every build; this define sets it, such as `-Dlime-assets-version=3`. |
| `lime_disable_assets_version` | Do not add a version number to asset URLs. |
| `simulate_preloader` | Make preloading take longer, to test a preloader. Takes a time in milliseconds, or 3000 when no value is given. |
{: .table}

### Debugging

| Define | Description |
|---|---|
| `lime_debug` | C++: build Lime's own classes as debug code in debug builds. Otherwise they are built as release code, which keeps debug builds fast, and the debugger does not step into them. |
| `verbose` | Start `lime.utils.Log` at the verbose level. |
| `no_traces` | Haxe removes `trace` calls, and Lime sets `lime.utils.Log` to print nothing. |
| `simulate_uptime` | Start the timer this many milliseconds in, to test what happens to an application that keeps running for days. _Lime 8.4.0_ |
| `neko_cffi_trace` | Neko: trace each call into Lime's native library. |
| `suppress_devtools` | Electron: do not open the developer tools in debug builds. |
| `lime-warn-portability` | HTML5: warn when a function given to `ThreadPool` or `BackgroundWorker` is not a static function, which a web worker needs. |
{: .table}

### Flash and AIR

| Define | Description |
|---|---|
| `haxe-trace` | Keep Haxe's own trace output. Otherwise Lime defines `native-trace`. `haxetrace` does the same. |
| `nofdb` | Debug builds define `fdb`, which adds information for the Flash debugger. This define leaves it out. |
| `enable_flash_right_click` | Listen for right mouse events. This is the default unless OpenFL is in use. |
| `disable_flash_right_click` | Do not listen for right mouse events. |
{: .table}

### HTML5 modules

The `lime-modular` define builds Lime and part of the Haxe standard library as separate JavaScript modules.

| Define | Description |
|---|---|
| `lime-modular` | Turn on modular output. |
| `haxe-module-name`, `lime-module-name` | The names of the two modules, `haxe` and `lime` by default. |
| `exclude-haxe-module`, `exclude-lime-module` | Leave out one of the two modules. |
{: .table}

### Command-line tools

These are read by the command-line tools rather than by your Haxe code.

| Define | Description |
|---|---|
| `MACOSX_DEPLOYMENT_TARGET` | macOS: the oldest version of macOS to support. The default is 10.9. |
| `IPHONE_VER`, `TVOS_VER` | iOS and tvOS: the SDK version to build against. The default is the newest one installed. |
| `FULL_LOGCAT` | Android: `lime test` and `lime run` show the whole device log instead of only your application's messages. |
| `ANDROID_GRADLE_TASK` | Android: the Gradle task to run. The default is `assembleDebug`, or `assembleRelease` when the project has a keystore. |
| `SHOW_CONSOLE` | HashLink on Windows: keep the console window, which is hidden otherwise. |
| `SWF_PLAYER` | Flash: the path to the Flash Player projector used by `lime test flash`. |
| `lime-ignore-stale-files` | Do not delete files left in the output directory by an earlier build. |
{: .table}

`FULL_LOGCAT`, `ANDROID_GRADLE_TASK` and `SHOW_CONSOLE` are read from the environment, so set them in your project file or as environment variables.

The paths to SDKs and other tools are defines too, normally saved to Lime's config file by `lime setup` and shown by `lime config`. They include `ANDROID_SDK`, `ANDROID_NDK_ROOT`, `JAVA_HOME`, `AIR_SDK`, `EMSCRIPTEN_SDK`, `HL_PATH` and `ELECTRON_PATH`. The config file is _.lime/config.xml_ in your home directory, or the file named by the `LIME_CONFIG` environment variable.

## Rebuilding Lime

When you rebuild Lime's native library with `lime rebuild`, your defines are passed along to the C++ build. These change what is built:

| Define | Description |
|---|---|
| `no-webview` | Leave out the web view engine. `lime-no-webview` does the same. _Lime 8.4.0_ |
| `no-vulkan` | Leave out Vulkan. `lime-no-vulkan` does the same. _Lime 8.4.0_ |
| `angle` | Windows: draw OpenGL ES through ANGLE. |
{: .table}

Pass the same define when you build your application, so that its Haxe code matches the native library:

```sh
lime rebuild windows -Dno-webview
lime build windows -Dno-webview
```

## Other defines

Lime also checks a few defines while building its own tools, documentation and tests. These are not meant for applications, and may change without notice: `lime-doc-gen`, `doc_gen`, `optional-cffi`, `crossbyte`, `lime-threads-deque`, `lime_audio_test_hooks` and `munit`.

Defines for targets that are no longer maintained, such as `tizen`, `blackberry`, `webos`, `firefox`, `winrt` and `uwp`, and for the console targets provided by separate haxelibs, still appear in Lime's source but are not covered here.
