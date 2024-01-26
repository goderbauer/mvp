// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// This sample talks to dart:ui directly without utilizing the Flutter framework.
import 'dart:ui';

void main() {
  PlatformDispatcher.instance
    ..onMetricsChanged = _handleOnMetricsChanged
    ..onDrawFrame = _handleOnDrawFrame;
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

int _frameNumber = 0;

void _handleOnDrawFrame() {
  _frameNumber++;

  for (final FlutterView view in PlatformDispatcher.instance.views) {
    final Size logicalSize = view.physicalSize / view.devicePixelRatio;
    final Color color = _colors[view.viewId % _colors.length];

    final ParagraphBuilder paragraphBuilder = ParagraphBuilder(
      ParagraphStyle(textDirection: TextDirection.ltr, fontSize: 24),
    )
      ..pushStyle(TextStyle(color: color))
      ..addText(
        'Frame: $_frameNumber\n'
        'View ID: ${view.viewId}\n'
        'Physical ${view.physicalSize}\n'
        'DPR: ${view.devicePixelRatio}',
      );
    final Paragraph paragraph = paragraphBuilder.build()
      ..layout(ParagraphConstraints(width: logicalSize.width));

    final Path topLeft = Path()
      ..moveTo(0,   0)
      ..lineTo(100, 0)
      ..lineTo(100, 20)
      ..lineTo(20,  20)
      ..lineTo(20,  100)
      ..lineTo(0,   100)
      ..close();
    final Path bottomRight = Path()
      ..moveTo(logicalSize.width,       logicalSize.height)
      ..lineTo(logicalSize.width - 100, logicalSize.height)
      ..lineTo(logicalSize.width - 100, logicalSize.height - 20)
      ..lineTo(logicalSize.width - 20,  logicalSize.height - 20)
      ..lineTo(logicalSize.width - 20,  logicalSize.height - 100)
      ..lineTo(logicalSize.width,       logicalSize.height - 100)
      ..close();
    final Paint paint = Paint()..color = color;

    final PictureRecorder recorder = PictureRecorder();
    Canvas(recorder, Offset.zero & view.physicalSize)
      ..scale(view.devicePixelRatio)
      ..drawPath(topLeft, paint)
      ..drawPath(bottomRight, paint)
      ..drawParagraph(paragraph, Offset(
        (logicalSize.width - paragraph.maxIntrinsicWidth) / 2.0,
        (logicalSize.height - paragraph.height) / 2.0,
      ));
    final Picture picture = recorder.endRecording();

    final SceneBuilder sceneBuilder = SceneBuilder()
      ..addPicture(Offset.zero, picture);

    view.render(sceneBuilder.build());
  }
}

const List<Color> _colors = <Color>[
  Color(0xFF0092CC),
  Color(0xFFDCD427),
  Color(0xFFFF3333),
  Color(0xFF779933),
  Color(0xFFF0F0F0),
];
