import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import 'controllers/user_controller.dart';
import 'pages/login_page.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarBrightness: Brightness.dark,
  ));

  GetIt getIt = GetIt.instance;
  getIt.registerSingleton<UserController>(UserController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Credit Card Challenge',
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.black,
          accentColor: Colors.pinkAccent,
          textSelectionColor: Colors.grey,
          scaffoldBackgroundColor: Colors.grey[900],
          inputDecorationTheme: InputDecorationTheme(
            fillColor: Colors.grey[850],
            filled: true,
            border: _getBorder(),
            enabledBorder: _getBorder(),
            disabledBorder: _getBorder(),
            focusedBorder: _getBorder(),
            labelStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 20,
            ),
          ),
        ),
        home: ChangeNotifierProvider(
          create: (_) => UserController(),
          child: LoginPage(),
        ),
      ),
    );
  }

  _getBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.grey));
  }
}
