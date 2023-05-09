// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/widgets.dart';
import 'src/widgets.dart';

void main() {
  runAppWithoutImplicitView(MultiViewApp(
    viewBuilder: (BuildContext context) => const HelloWorld(),
  ));
}

class HelloWorld extends StatelessWidget {
  const HelloWorld({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Center(
        child: Text(
          'Hello World from View#${View.of(context).viewId}\n'
          'Logical ${MediaQuery.sizeOf(context)}\n'
          'DPR: ${MediaQuery.devicePixelRatioOf(context)}'
        ),
      ),
    );
  }
}
