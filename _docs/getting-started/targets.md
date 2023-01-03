---
title: Targets
---

Lime and OpenFL can compile for many target platforms and operating systems. To display a complete list of targets and command line options, run the following command in a terminal:

```sh
lime help build
```

## Targets

* air -- Create an Adobe AIR application
* android -- Create an Android application
* emscripten -- Create an Emscripten application
* flash -- Create a Flash SWF application
* html5 -- Create an HTML5 application
* ios -- Create an iOS application
* linux -- Create a Linux application
* mac -- Create a macOS application
* tvos -- Create a tvOS application
* windows -- Create a Windows application

## Target Aliases

* cpp -- Alias for host platform (using -cpp)
* neko -- Alias for host platform (using -neko)
* macos -- Alias for mac
* nodejs -- Alias for host platform (using -nodejs)
* java -- Alias for host platform (using -java)
* cs -- Alias for host platform (using -cs)
* hl/hashlink -- Alias for host platform (using -hl)
* uwp/winjs -- Alias for windows -uwp
* rpi/raspberrypi -- Alias for linux -rpi
* electron -- Alias for html5 -electron
* webassembly/wasm -- Alias for emscripten -webassembly