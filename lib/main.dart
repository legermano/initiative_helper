import 'package:flutter/material.dart';
import 'package:initiative_helper/app/app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:initiative_helper/plugins/desktop/desktop.dart';

void main() {
  setTargetPlatformForDesktop();
  runApp(ModularApp(module: AppModule()));
}
