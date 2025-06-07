import 'package:bytecart/screens/login.dart';
import 'package:bytecart/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProv, _) {
        final theme = themeProv.themeData;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme.copyWith(
            splashFactory: NoSplash.splashFactory,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            navigationBarTheme: const NavigationBarThemeData(
              indicatorColor: Color(0x4D007BFF),
            ),
          ),
          home: const LoginPage(),
        );
      },
    );
  }
}
