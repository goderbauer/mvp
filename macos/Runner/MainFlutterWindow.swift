// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  static var engine: FlutterEngine?

  override func awakeFromNib() {
    super.awakeFromNib()
    let flutterViewController = FlutterViewController()
    MainFlutterWindow.engine = flutterViewController.engine;
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)

    RegisterGeneratedPlugins(registry: flutterViewController)
  }
}

class SideFlutterWindow: NSWindow {
  init(engine: FlutterEngine) {
    super.init(contentRect: .init(origin: .zero,
                                  size: .init(width: 400,
                                              height: 400)),
               styleMask: [.titled, .closable, .miniaturizable, .resizable],
               backing: .buffered,
               defer: false)
    let windowFrame = self.frame
    self.contentViewController  = FlutterViewController(engine: engine, nibName: nil, bundle: nil)
    self.setFrame(windowFrame, display: true)
  }
}
