# MVP - The Multi View Playground

This repository contains samples to experiment with rendering into multiple views from Flutter. Some samples are
aspirational and may not actually work. Some samples may require a custom engine build to run. Some samples may be
outdated and/or have other issues. DO NOT DEPEND ON ANYTHING IN THIS REPOSITORY.

To run a sample, execute:

```
$ flutter run -d <windows|linux|macos> -t lib/<sample_file_name>.dart
```

## Samples 

### raw_static.dart

Renders some view-specific information into each `FlutterView` available in `PlatformDispatcher.views` using only APIs
exposed by `dart:ui`. A new frame is only scheduled if the metrics of a `FlutterView` change or if a view is
added/removed.

### raw_dynamic.dart

Renders a spinning rectangular into each `FlutterView` available in `PlatformDispatcher.views` using only APIs exposed
by `dart:ui`. Frames are continuously scheduled to keep the animation running.
