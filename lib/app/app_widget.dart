import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:initiative_helper/theme/custom_themes.dart';
import 'package:initiative_helper/theme/theme_notifier.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, value) {      
        print(value.getTheme());
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: Modular.navigatorKey,
          title: 'Initiative Helper',
          theme: value.getTheme(),
          // darkTheme: darkTheme,
          initialRoute: '/',
          onGenerateRoute: Modular.generateRoute,
        );
      }
    );
  }
}
