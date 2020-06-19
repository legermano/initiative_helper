import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: Modular.navigatorKey,
      title: 'Initiative Helper',
      theme: ThemeData(
        primarySwatch: Colors.red,
        // use the good-looking updated material text style
        typography: Typography.material2018(
            englishLike: Typography.englishLike2018,
            dense: Typography.dense2018,
            tall: Typography.tall2018,
        ), 
      ),
      initialRoute: '/',
      onGenerateRoute: Modular.generateRoute,
    );
  }
}
