import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:initiative_helper/theme/custom_themes.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final window = WidgetsBinding.instance.window;    
    return DynamicTheme(
      defaultBrightness: window.platformBrightness,
      data: (brightness) {
        if (brightness == Brightness.light) {
          return lightTheme;
        } else {
          return darkTheme;
        }
      },
      themedWidgetBuilder: (context, data) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: Modular.navigatorKey,
          title: 'Initiative Helper',
          theme: data,
          // darkTheme: darkTheme,
          initialRoute: '/',
          onGenerateRoute: Modular.generateRoute,
        );
      },
    );
  }
}
