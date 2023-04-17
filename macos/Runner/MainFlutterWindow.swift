// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import Cocoa
import FlutterMacOS
import Darwin.C

class MainFlutterWindow: NSWindow {
  static var engine: FlutterEngine?

  override func awakeFromNib() {
    super.awakeFromNib()
    let flutterViewController = FlutterViewController()
    print("awakeFromNib! \(flutterViewController.viewId)")
    MainFlutterWindow.engine = flutterViewController.engine;
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)

    RegisterGeneratedPlugins(registry: flutterViewController)
  }
}

class SideFlutterWindow: NSWindow {
  init(engine: FlutterEngine) {
    print("SideFlutterWindow.init 1")
    let rect = NSRect.init(origin: .zero,
                                  size: .init(width: 400,
                                              height: 400))
    super.init(contentRect: rect,
               styleMask: [.titled, .closable, .miniaturizable, .resizable],
               backing: .buffered,
               defer: false)
    print("SideFlutterWindow.init 2")
    fflush(stdout)
    self.flutterViewController = FlutterViewController(engine: engine, nibName: nil, bundle: nil)
    print("SideFlutterWindow.init 3")
    fflush(stdout)
    self.setFrame(rect, display: true)
    print("SideFlutterWindow.init 4")
    fflush(stdout)
  }

  var flutterViewController: FlutterViewController?

  func activate() {
    self.contentViewController = self.flutterViewController
  }
}
