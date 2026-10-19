import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'injection.dart';
import 'core/theme/theme_cubit.dart';
import 'presentation/blocs/auth/auth_cubit.dart';
import 'presentation/blocs/meal/meal_bloc.dart';
import 'presentation/blocs/cart/cart_bloc.dart';
import 'presentation/screens/splash/splash_screen.dart';

// ملاحظة: سيتم توليد هذا الملف تلقائياً بعد تشغيل flutter gen-l10n أو flutter run
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // تهيئة Firebase
  await Firebase.initializeApp();

  // تهيئة حقن التبعيات GetIt
  await initServiceLocator();

  runApp(const StreetBiteApp());
}

class StreetBiteApp extends StatelessWidget {
  const StreetBiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (context) => sl<ThemeCubit>(),
        ),
        BlocProvider<AuthCubit>(
          create: (context) => sl<AuthCubit>(),
        ),
        BlocProvider<MealBloc>(
          create: (context) => sl<MealBloc>(),
        ),
        BlocProvider<CartBloc>(
          create: (context) => sl<CartBloc>(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            title: 'StreetBite V1.0',
            debugShowCheckedModeBanner: false,
            
            // إعداد الثيمات (Light & Dark)
            themeMode: themeMode,
            theme: ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.orange,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.orange,
              scaffoldBackgroundColor: const Color(0xFF121212),
              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xFF1F1F1F),
                foregroundColor: Colors.white,
              ),
            ),

            // إعداد اللغات (Localization) - الإنجليزية والعربية
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              // AppLocalizations.delegate, // سيتم تفعيلها عند توليد ملفات الترجمة
            ],
            supportedLocales: const [
              Locale('en', ''), // English
              Locale('ar', ''), // Arabic
            ],

            // الشاشة الابتدائية (Splash Screen)
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}