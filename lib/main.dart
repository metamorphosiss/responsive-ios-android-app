import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/expenses.dart';
// import 'package:flutter/services.dart';

var kcolorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 96, 59, 181));
var darkColorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 5, 99, 125),
    brightness: Brightness.dark);

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]).then((fn) {
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: darkColorScheme,
        cardTheme: const CardTheme().copyWith(
            //this color
            color: darkColorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: darkColorScheme.onPrimaryContainer,
          foregroundColor: darkColorScheme.primaryContainer,
          centerTitle: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: darkColorScheme.primaryContainer,
                foregroundColor: darkColorScheme.onPrimaryContainer)),
        // textTheme: ThemeData().textTheme.copyWith(
        //     titleLarge: TextStyle(
        //         fontWeight: FontWeight.bold,
        //         color: darkColorScheme.onSecondaryContainer,
        //         fontSize: 14))
      ),
      theme: ThemeData().copyWith(
          useMaterial3: true,
          colorScheme: kcolorScheme,
          scaffoldBackgroundColor: kcolorScheme.onPrimary,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kcolorScheme.onPrimaryContainer,
            foregroundColor: kcolorScheme.primaryContainer,
            centerTitle: true,
          ),
          cardTheme: const CardTheme().copyWith(
              color: kcolorScheme.secondaryContainer,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: kcolorScheme.primaryContainer)),
          textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kcolorScheme.onSecondaryContainer,
                  fontSize: 14))),
      themeMode: ThemeMode.dark,
      // themeMode: ThemeMode.system,   default
      home: const Expenses(),
    ));
  // });
}
