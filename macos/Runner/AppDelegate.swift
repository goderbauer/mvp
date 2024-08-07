// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import Cocoa
import FlutterMacOS

@main
class AppDelegate: FlutterAppDelegate {
  lazy var flutterEngine = FlutterEngine(name: "io.flutter", project: nil, allowHeadlessExecution: true)

  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }

  override func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
    return true
  }

  override func applicationDidFinishLaunching(_ aNotification: Notification) {
    flutterEngine.run(withEntrypoint: nil)
    RegisterGeneratedPlugins(registry: self.flutterEngine)

    let mainWindow = self.mainFlutterWindow as! MainFlutterWindow
    mainWindow.showFlutter(engine: flutterEngine)

    let _ = SideFlutterWindow(engine: self.flutterEngine)
    DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
      let _ = SideFlutterWindow(engine: self.flutterEngine)
    }
  }
}
