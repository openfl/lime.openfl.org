---
title: Setup HTML5
---

Lime and OpenFL may be used to create [HTML5](https://developer.mozilla.org/en-US/docs/Glossary/HTML5) applications and games for web browsers by [compiling to JavaScript](https://haxe.org/manual/target-javascript.html).

## Automatic Install

There is no automatic setup available for HTML5.

## Manual Install

There is generally no setup required to get started with the HTML5 target. However, to use `-minify` or `-final` option, refer the Java JDK requirement in the [Minification](#minification) section.

## Build & Run

To compile an HTML5 application, run `lime build html5`.

To compile and launch an HTML5 application with one command, run `lime test html5`. This will start a local development server, and launch the page in a web browser.

### Minification

Adding either the `-minify` option or the `-final` option to your build command will apply more advanced minification to the generated JavaScript. By default, [Closure Compiler](https://developers.google.com/closure/compiler) will be used to minify, but you can specify `-yui` to use [YUI Compressor](https://yui.github.io/yuicompressor/) instead.

**Note:** Both minification tools require a _Java JDK_ to be installed. A variety of vendors offer free Java OpenJDK builds that work well with Lime and OpenFL. If you're not sure which one to choose, a good option is [Temurin OpenJDK from Adoptium.net](https://adoptium.net/).

### Launch Options

The default port used by the local development server is port `3000`. To customize this port, specify the `--port` option with a value such as `--port=8080`.

To compile and start the local development server, but skip launching in a web browser, add the `-nolaunch` option.

## Using JavaScript libraries

To use an external JavaScript library with Lime, you need [Haxe externs](https://haxe.org/manual/lf-externs.html). See also [Haxe: Using external JavaScript libraries](https://haxe.org/manual/target-javascript-external-libraries.html).

Members of the Haxe community have already created open source externs for a number of popular JavaScript libraries, so be sure to search [Haxelib](https://lib.haxe.org/search) or [Github](https://github.com/search) to see if JS externs exist for your library before you try to create your own.

### Adding dependencies

To actually use external JS libraries you must include them in _project.xml_. There are three options:

1. Ship the library with your project as a separate file:

    ```xml
    <dependency path="js-libs/someLibrary.js" />
    ```

    The _js-libs/someLibrary.js_ file will be copied into the compiled project's _lib_ directory. You can change the dependency export path (e.g. from _lib_ to _js_) with this config:

    ```xml
    <config:html5 dependency-path="js" />
    ```
  
2. Embed the library:
  
    ```xml
    <dependency path="js-libs/someLibrary.js" embed="true"/>
    ```

    The content of _js-libs/someLibrary.js_ will be embedded into compiled application's _.js_ file.

3. Add a remote link to the library:

    ```xml
    <dependency name="https://unpkg.com/simple-peer@5.9.0/simplepeer.min.js" />
    ```
    
    The resulting _index.html_ will have an appropriate `<script>` tag.

### _index.html_ template

Another possible way of adding JS files is to link them directly inside your custom _index.html_ template. With this you must [configure _project.xml_ to use a custom template](../../project-files/xml-format/#template) and probably handle copying JS files to the project export directory by yourself. Similar to `<dependency />` but less convenient.

### _include.xml_

Some Haxe externs support Lime out of the box, like [haxe-simple-peer](https://github.com/ixiagames/haxe-simple-peer). You just include it with `<haxelib name="simple-peer" />` and that's all. This works because it has an [_include.xml_](../../project-files/xml-format/#includexml) file with a `<dependency />` tag so Lime knows how to include the external _simplepeer.min.js_ file.

## Advanced Configuration

The `<config:html5 />` element in your [_project.xml_](../../project-files/xml-format/) file is used to specify advanced configuration options for HTML/JS. For a complete list of these advanced option, see [Config Values: HTML5](../../project-files/xml-format/config/#html5).

## Forums

If you encounter any problems when setting up Lime for HTML5, please visit the [forums](http://community.openfl.org/c/help) or [Discord](https://discord.gg/tDgq8EE).
