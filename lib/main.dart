import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'app/bindings/app_binding.dart';
import 'app/controllers/theme_controller/app_color_controller.dart';
import 'app/routes/app_routes.dart';
import 'app/ui/pages/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ThemeController());
  OneSignal.initialize('91cd9786-2a9d-42af-b368-7b67b75bfe45');
  OneSignal.Notifications.requestPermission(true);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final ThemeController themeController = Get.find();
      // Set global status bar theme
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: themeController.primaryColor, // Status bar background
          statusBarIconBrightness: themeController.isDarkMode
              ? Brightness.light // Light icons for dark mode
              : Brightness.dark, // Dark icons for light mode
        ),
      );
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialBinding: AppBindings(),
        home: SplashScreen(),
        theme: ThemeData(
          primaryColor: themeController.primaryColor,
          hintColor: themeController.secondaryColor,
        ),
        darkTheme: ThemeData(
          primaryColor: themeController.primaryColor,
          hintColor: themeController.secondaryColor,
        ),
        themeMode: themeController.isDarkMode
            ? ThemeMode.dark
            : ThemeMode.light, // Toggle based on isDarkMode
        getPages: AppRoutes.pages, // Centralized route management
      );
    });
  }
}
