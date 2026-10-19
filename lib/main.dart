
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:streetbite/l10n/app_localizations.dart';

import 'firebase_options.dart';
import 'injection.dart';

import 'core/theme/theme_cubit.dart';
import 'core/bloc/locale_cubit.dart';

import 'presentation/blocs/auth/auth_cubit.dart';
import 'presentation/blocs/meal/meal_bloc.dart';
import 'presentation/blocs/cart/cart_bloc.dart';

import 'presentation/screens/splash/splash_screen.dart';
import 'presentation/widgets/language_switcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
        BlocProvider<LocaleCubit>(
          create: (context) => LocaleCubit(),
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
          return BlocBuilder<LocaleCubit, Locale>(
            builder: (context, locale) {
              return MaterialApp(
                title: 'StreetBite V1.0',
                debugShowCheckedModeBanner: false,

                // اللغة الحالية
                locale: locale,

                // اللغات المدعومة
                supportedLocales: AppLocalizations.supportedLocales,

                // ملفات الترجمة
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],

               
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

                // زر تغيير اللغة على مستوى التطبيق كله
                builder: (context, child) {
                  return LanguageSwitcher(
                    child: child ?? const SizedBox.shrink(),
                  );
                },

                home: const SplashScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
