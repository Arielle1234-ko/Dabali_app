import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'controllers/app_controller.dart';
import 'screens/splash_screen.dart';
import 'widgets/app_scope.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final controller = await AppController.create();
  runApp(MyApp(controller: controller));
}

class MyApp extends StatelessWidget {
  final AppController controller;

  const MyApp({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AppScope(
      controller: controller,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: controller.themeMode,
            theme: _buildTheme(Brightness.light),
            darkTheme: _buildTheme(Brightness.dark),
            home: const SplashScreen(),
          );
        },
      ),
    );
  }

  ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final base = ThemeData(
      useMaterial3: true,
      brightness: brightness,
      textTheme: GoogleFonts.poppinsTextTheme(
        ThemeData(brightness: brightness).textTheme,
      ),
      primaryTextTheme: GoogleFonts.poppinsTextTheme(
        ThemeData(brightness: brightness).primaryTextTheme,
      ),
    );

    return base.copyWith(
      scaffoldBackgroundColor: isDark
          ? const Color(0xff111827)
          : const Color(0xffF8FAFC),
      colorScheme: base.colorScheme.copyWith(
        primary: const Color(0xffFF6B00),
        secondary: const Color(0xff10B981),
        surface: isDark ? const Color(0xff1F2937) : Colors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: isDark ? const Color(0xff111827) : Colors.white,
        foregroundColor: isDark ? Colors.white : const Color(0xff111827),
        surfaceTintColor: Colors.transparent,
      ),
    );
  }
}
