# MVP - The Multi View Playground

This repository contains samples to experiment with rendering into multiple views from Flutter. Some samples are
aspirational and may not actually work. Some samples may require a custom engine build to run. Some samples may be
outdated and/or have other issues. DO NOT DEPEND ON ANYTHING IN THIS REPOSITORY.

## How to use?

This sample must be used with the correct revision of a custom engine.
Currently, it only supports macOS.

## Setup
1. Set up the Engine development environment: See [the wiki page](https://github.com/flutter/flutter/wiki/Setting-up-the-Engine-development-environment).
2. In **the engine repo**, add the prototype remote:
```
git remote add loic-sharma https://github.com/loic-sharma/flutter-engine/
```
3. In **this repo**, edit `pubspec.yaml`, and add the following dependency override:
```
dependency_overrides:
  sky_engine:
    path: /path/to/flutter/engine/out/host_debug/gen/dart-pkg/sky_engine
```
This allows the sample to use the custom `dart:ui` library.

## Build
1. In **the engine repo**, checkout the prototype branch
```
git fetch loic-sharma
git checkout 087d63a3d1f01da5646e4e76b8d81766fbaa79c6
```
2. Build the custom engine: See [the wiki page](https://github.com/flutter/flutter/wiki/Compiling-the-engine#compiling-for-macos-or-linux).
3. In **this repo**, run the sample file with the custom engine. For example,
```
$ flutter run --local-engine=host_debug_unopt -d macos -t lib/raw_dynamic.dart
```
See below for the list of sample apps.

4. If everything goes well, the app should start up with a window, then another window after 1 second.

## Samples

### raw_static.dart

Renders some view-specific information into each `FlutterView` available in `PlatformDispatcher.views` using only APIs
exposed by `dart:ui`. A new frame is only scheduled if the metrics of a `FlutterView` change or if a view is
added/removed.

### raw_dynamic.dart

Renders a spinning rectangular into each `FlutterView` available in `PlatformDispatcher.views` using only APIs exposed
by `dart:ui`. Frames are continuously scheduled to keep the animation running.
