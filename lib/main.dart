import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:melebazaar_app/common/pt_colors.dart';
import 'package:melebazaar_app/features/product_detail/provider/product_provider.dart';
import 'package:melebazaar_app/features/product_detail/screens/product_detail_screen.dart';
import 'package:melebazaar_app/utils/notification_handler.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationHandler.requestNotificationPermissions();
  await Hive.initFlutter();
  runApp(const MyApp());
}

// final GoRouter _router = GoRouter(
//   routes: [
//     GoRoute(
//       path: '/',
//       builder: (context, state) => const ProductDetailPage(),
//     ),
//   ],
// );

ThemeData _darkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
  );
}

ThemeData _lightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      backgroundColor: PTColor.primary,
      foregroundColor: Colors.white,
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: ScreenUtilInit(
        designSize: ScreenUtil.defaultSize,
        builder: (context, child) => MaterialApp(
          home: ProductDetailPage(toggleTheme: _toggleTheme),
          // routerConfig: _router,

          title: 'Product Detail App',
          theme: _isDarkMode ? _darkTheme() : _lightTheme(),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }
}
