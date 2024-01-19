// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math' as math;
// This sample talks to dart:ui directly without utilizing the Flutter framework.
import 'dart:ui';

void main() {
  PlatformDispatcher.instance
    ..onMetricsChanged = _handleOnMetricsChanged
    ..onBeginFrame = _handleOnBeginFrame;
  // If no view is available, the first frame wil be scheduled in
  // _handleOnMetricsChanged when a view is added.
  if (PlatformDispatcher.instance.views.isNotEmpty) {
    PlatformDispatcher.instance.scheduleFrame();
  }
}

void _handleOnMetricsChanged() {
  // A view's dimensions may have changed or a new view may have been added.
  // Let's schedule a new frame for a chance to update the content in the views.
  if (PlatformDispatcher.instance.views.isNotEmpty) {
    PlatformDispatcher.instance.scheduleFrame();
  }
}

void _handleOnBeginFrame(Duration timeStamp) {
  for (final FlutterView view in PlatformDispatcher.instance.views) {
    final Size logicalSize = view.physicalSize / view.devicePixelRatio;
    final Color color = _colors[view.viewId % _colors.length];

    final ParagraphBuilder paragraphBuilder = ParagraphBuilder(
      ParagraphStyle(textDirection: TextDirection.ltr, fontSize: 24),
    )
      ..pushStyle(TextStyle(color: color))
      ..addText(
          'Timestamp: $timeStamp\n'
          'View ID: ${view.viewId}',
      );
    final Paragraph paragraph = paragraphBuilder.build()
      ..layout(ParagraphConstraints(width: logicalSize.width));

    final double t = timeStamp.inMicroseconds / Duration.microsecondsPerMillisecond / 1800.0;
    final double rotation = math.pi * (t % 1.0);
    final double squareSize = 0.5 * math.min(
      math.max(logicalSize.width - 300, 100),
      math.max(logicalSize.height - 300, 100),
    );

    final PictureRecorder recorder = PictureRecorder();
    Canvas(recorder, Offset.zero & view.physicalSize)
      ..scale(view.devicePixelRatio)
      ..drawParagraph(paragraph, Offset.zero)
      ..translate(logicalSize.width / 2, logicalSize.height / 2)
      ..rotate(rotation)
      ..drawRect(
        Rect.fromLTRB(-1 * squareSize, -1 * squareSize, squareSize, squareSize),
        Paint()..color = color,
      );
    final Picture picture = recorder.endRecording();

    final SceneBuilder sceneBuilder = SceneBuilder()
      ..addPicture(Offset.zero, picture);

    view.render(sceneBuilder.build());
  }
  // Requesting another frame at the end of this frame to keep the animation going.
  if (PlatformDispatcher.instance.views.isNotEmpty) {
    PlatformDispatcher.instance.scheduleFrame();
  }
}

const List<Color> _colors = <Color>[
  Color(0xFF0092CC),
  Color(0xFFDCD427),
  Color(0xFFFF3333),
  Color(0xFF779933),
  Color(0xFFF0F0F0),
];
