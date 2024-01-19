// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/widgets.dart';
import 'src/widgets.dart';

void main() {
  runWidget(MultiViewApp(
    viewBuilder: (BuildContext context) => const SpinningSquare(),
  ));
}

class SpinningSquare extends StatefulWidget {
  const SpinningSquare({super.key});

  @override
  State<SpinningSquare> createState() => _SpinningSquareState();
}

class _SpinningSquareState extends State<SpinningSquare> with SingleTickerProviderStateMixin {
  late final AnimationController _animation = AnimationController(
    duration: const Duration(milliseconds: 3600),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int viewId = View.of(context).viewId;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Center(
        child: RotationTransition(
          turns: _animation,
          child: Container(
            width: 200.0,
            height: 200.0,
            color: _colors[viewId % _colors.length],
            child: Center(
              child: Text('View#$viewId'),
            )
          ),
        ),
      ),
    );
  }
}

const List<Color> _colors = <Color>[
  Color(0xFFC70039),
  Color(0xFF581845),
  Color(0xFFFFC305),
  Color(0xFFFF5733),
  Color(0xFF900C3F),
];
