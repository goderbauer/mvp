// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import Cocoa
import FlutterMacOS
import Darwin.C

@NSApplicationMain
class AppDelegate: FlutterAppDelegate {
  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }

  override func applicationDidFinishLaunching(_ aNotification: Notification) {
      DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
        print("start of async!")
        print("========SideFlutterWindow::ctor start========\n");
        let newWindow = SideFlutterWindow(engine: MainFlutterWindow.engine!)
        print("========SideFlutterWindow::ctor end========\n");
        print("created")
        fflush(stdout)
        newWindow.title = "New Window"
        newWindow.isOpaque = false
        newWindow.center()
        newWindow.isMovableByWindowBackground = true
        newWindow.isReleasedWhenClosed = false
        newWindow.backgroundColor = NSColor(calibratedHue: 0, saturation: 1.0, brightness: 0, alpha: 0.7)
        print("before makeKeyAndOrderFront!")
        fflush(stdout)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
          newWindow.activate()
          newWindow.makeKeyAndOrderFront(nil)
          print("madeKeyAndOrderFront!")
          fflush(stdout)
        }
        // print("makeKeyAndOrderFront! \(newWindow.screen)")
          // self.sideWindow2 = SideFlutterWindow(label: self.mainWindow!.label)
          // self.sideWindow2?.makeKeyAndOrderFront(nil)
      }
  }
}
