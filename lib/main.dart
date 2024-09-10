import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:melebazaar_app/common/notification_service.dart';
import 'package:melebazaar_app/features/product_detail/provider/product_provider.dart';
import 'package:melebazaar_app/features/product_detail/screens/product_detail_screen.dart';
import 'package:melebazaar_app/hive_provider/theme_hive_provider.dart';
import 'package:melebazaar_app/utils/notification_handler.dart';
import 'package:melebazaar_app/utils/theme_mode.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationHandler.requestNotificationPermissions();
  NotificationService notificationService = NotificationService();
  notificationService.initializeNotifications();

  await Hive.initFlutter();
  await Hive.openBox('settings');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => HiveProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HiveProvider>(
      builder: (context, hiveProvider, child) {
        final appTheme = AppTheme();
        return ScreenUtilInit(
          designSize: ScreenUtil.defaultSize,
          builder: (context, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            home: ProductDetailScreen(),
            title: 'Mela Bazar App',
            theme: hiveProvider.isDarkMode
                ? appTheme.darkTheme()
                : appTheme.lightTheme(),
          ),
        );
      },
    );
  }
}
