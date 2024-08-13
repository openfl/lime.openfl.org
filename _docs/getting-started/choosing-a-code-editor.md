---
title: Choosing a Code Editor
---

After installing Lime or OpenFL, selecting the right integrated development environment (IDE) or code editor can greatly enhance your coding experience. While you can technically write code with a basic text editor, a quality IDE provides features like code completion, build shortcuts, and debugging tools, which are invaluable for efficient development.

## Visual Studio Code

[Visual Studio Code](https://code.visualstudio.com) (VSCode) is a highly recommended code editor for Lime and OpenFL development. It's a flexible, open-source editor available on Windows, macOS, and Linux. Despite its lightweight design, VSCode offers robust code intelligence for many programming languages.

To set up VSCode for Lime and OpenFL:

- Install the [Haxe extension](https://marketplace.visualstudio.com/items?itemName=nadako.vshaxe).
- Add the [Lime extension](https://marketplace.visualstudio.com/items?itemName=openfl.lime-vscode-extension).

These extensions will enable code completion, simplify project builds, and make debugging more accessible. VSCode does not require its own project files—just use the **Open Folder** option for any Lime or OpenFL project to get started.

## Vim

[vim](https://www.vim.org) is a highly configurable text editor built to enable efficient text editing. It's especially popular among developers who prefer keyboard-centric workflows. While vim is minimalistic in its default form, it can be extended to support Lime and OpenFL development through plugins.

To set up vim for Haxe, Lime, and OpenFL:

- Install the [vaxe](https://github.com/jdonaldson/vaxe) plugin for Haxe syntax highlighting and autocompletion.
- Optionally, use [ALE](https://github.com/dense-analysis/ale) for asynchronous linting and completion.
  
Vim is cross-platform, running on Windows, macOS, and Linux, and is favored by those who appreciate a fast and customizable coding environment.

## Sublime Text

[Sublime Text](http://www.sublimetext.com) is a lightweight, cross-platform code editor that supports Lime and OpenFL through the [Haxe Sublime Bundle](https://github.com/clemos/haxe-sublime-bundle). Sublime Text works on Windows, macOS, and Linux.

Although Sublime Text doesn’t always offer accurate code completion and lacks traditional project management features, it's more powerful than a simple text editor. If other editors feel too heavy for your needs, Sublime Text might be the right choice. It's free to try, with reminders to purchase a license for extended use.

## IntelliJ IDEA

[IntelliJ IDEA](https://www.jetbrains.com/idea/) is a robust IDE, primarily known for Java development but increasingly popular within the Haxe community, including use by large teams like TiVo. Both the full and free community editions support the [Haxe plugin](https://plugins.jetbrains.com/plugin/6873?pr=idea).

While the plugin setup can be tricky, IntelliJ IDEA offers a fully native IDE experience on all platforms once configured.

## Other Options

Other editors, such as up-and-coming Haxe-based editors, are also available. You can explore more options at the [Haxe documentation site](http://haxe.org/documentation/introduction/editors-and-ides.html).
