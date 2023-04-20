// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import Cocoa
import FlutterMacOS

@NSApplicationMain
class AppDelegate: FlutterAppDelegate {
  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }

  override func applicationDidFinishLaunching(_ aNotification: Notification) {
      DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
        let newWindow = SideFlutterWindow(engine: MainFlutterWindow.engine!)
        newWindow.center()
        newWindow.makeKeyAndOrderFront(nil)
      }
  }
}
