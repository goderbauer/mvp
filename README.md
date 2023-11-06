# MVP - The Multi View Playground

This repository contains samples to experiment with rendering into multiple views from Flutter. Some samples are
aspirational and may not actually work. Some samples may require a custom engine build to run. Some samples may be
outdated and/or have other issues. DO NOT DEPEND ON ANYTHING IN THIS REPOSITORY.

This playground does not demonstrate a windowing API and creating/managing windows from a Flutter app is not yet
supported. However, the rendering APIs demonstrated in this playground will form the foundation for future multi-window
support in Flutter. Nothing in this repository shall be seen as a definite or "official" decision on windowing APIs,
though. This is just an exploratory playground.

Please [report any bugs](https://github.com/flutter/flutter/issues/new?assignees=&labels=a%3A%20multi%20window,team-framework&projects=&template=2_bug.yml)
you may encounter.

## Supported platforms

The demos in this repository run on the following platforms:

| Platform | Support                                               |
|----------|-------------------------------------------------------|
| macOS    | ⚠️ with custom engine branch (see instructions below) |
| Windows  | ⚠️ with custom engine branch (see instructions below) |
| Linux    | ❌                                                    |

## How to use?

The samples are meant to be used with a custom (prototype) engine using the master branch of the framework.

0. Set up the Framework development environment: See [the wiki page](https://github.com/flutter/flutter/wiki/Setting-up-the-Framework-development-environment).

1. In **the framework repo**, switch to the master branch:
```
git checkout master
```

2. Set up the Engine development environment: See [the wiki page](https://github.com/flutter/flutter/wiki/Setting-up-the-Engine-development-environment).

3. In **the engine repo**, add the prototype remote and switch to the prototype branch:
```
git remote add loic-sharma https://github.com/dkwingsmt/flutter-engine/
git fetch dkwingsmt
git checkout fffa6e19f5b71bedd55ac3a7fa6acfd85eda5983
```

4. In **this repo**, edit `pubspec.yaml`, and add the following dependency override to use the custom `dart:ui` library:
```
dependency_overrides:
  sky_engine:
    path: /path/to/flutter/engine/out/host_debug_unopt/gen/dart-pkg/sky_engine
```

5. Build the custom engine: See [the wiki page](https://github.com/flutter/flutter/wiki/Compiling-the-engine#compiling-for-macos-or-linux).

6. In **this repo**, update packages.
```
flutter pub get
```

7. Run a sample file (see below for options) with the custom engine. For example,
```
flutter run --local-engine=host_debug_unopt --local-engine-host=host_debug_unopt -d macos -t lib/raw_dynamic.dart
```

8. If everything goes well, the app should start up with a number of windows.

## Samples

### raw_static.dart

Renders some view-specific information into each `FlutterView` available in `PlatformDispatcher.views` using only APIs
exposed by `dart:ui`. A new frame is only scheduled if the metrics of a `FlutterView` change or if a view is
added/removed.

### raw_dynamic.dart

Renders a spinning rectangular into each `FlutterView` available in `PlatformDispatcher.views` using only APIs exposed
by `dart:ui`. Frames are continuously scheduled to keep the animation running.

### widgets_static.dart

Renders some view-specific information into each `FlutterView` available in `PlatformDispatcher.views` using the Flutter
widget framework (`package:flutter/widgets.dart`). A new frame is only scheduled if the metrics of a `FlutterView`
change or if a view is added/removed.

### widgets_dynamic.dart

Renders a spinning rectangular into each `FlutterView` available in `PlatformDispatcher.views` using the Flutter
widget framework (`package:flutter/widgets.dart`). Frames are continuously scheduled to keep the animation running.

### widgets_counter.dart

Renders the Counter app (an interactive Material Design app) into each `FlutterView` available in
`PlatformDispatcher.views`.
