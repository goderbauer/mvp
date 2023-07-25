// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <flutter/dart_project.h>
#include <flutter/flutter_view_controller.h>
#include <flutter/generated_plugin_registrant.h>
#include <windows.h>

#include "flutter_window.h"
#include "utils.h"

int APIENTRY wWinMain(_In_ HINSTANCE instance, _In_opt_ HINSTANCE prev,
                      _In_ wchar_t *command_line, _In_ int show_command) {
  // Attach to console when present (e.g., 'flutter run') or create a
  // new console when running with a debugger.
  if (!::AttachConsole(ATTACH_PARENT_PROCESS) && ::IsDebuggerPresent()) {
    CreateAndAttachConsole();
  }

  // Initialize COM, so that it is available for use in the library and/or
  // plugins.
  ::CoInitializeEx(nullptr, COINIT_APARTMENTTHREADED);

  flutter::DartProject project(L"data");

  std::vector<std::string> command_line_arguments =
      GetCommandLineArguments();

  project.set_dart_entrypoint_arguments(std::move(command_line_arguments));

  std::shared_ptr<flutter::FlutterEngine> engine
    = std::make_shared<flutter::FlutterEngine>(project);

  RegisterPlugins(engine.get());

  Win32Window::Point origin1(10, 10);
  Win32Window::Point origin2(50, 50);
  Win32Window::Size size(1280, 720);

  FlutterWindow window1(engine);
  FlutterWindow window2(engine);
  if (!window1.Create(L"Mvp", origin1, size)
    || !window2.Create(L"Window #2", origin2, size)) {
    return EXIT_FAILURE;
  }

  window1.SetQuitOnClose(true);

  ::MSG msg;
  while (::GetMessage(&msg, nullptr, 0, 0)) {
    ::TranslateMessage(&msg);
    ::DispatchMessage(&msg);
  }

  ::CoUninitialize();
  return EXIT_SUCCESS;
}
