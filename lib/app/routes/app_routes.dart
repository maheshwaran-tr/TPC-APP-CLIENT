import 'package:final_tpc_app/app/ui/pages/splash_screen/splash_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: '/push-page', page: () => SplashScreen()),
    // Add more routes as needed
  ];
}
