import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:final_tpc_app/app/data/api/user_requests.dart';
import 'package:final_tpc_app/app/data/models/user_model.dart';
import 'package:final_tpc_app/app/services/splashscreen_navigation_service.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../data/token/token_storage.dart';

class SplashScreenController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final _isLoading = true.obs;
  late final AnimationController animationController;

  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _simulateLoading();
      }
    });
    animationController.forward();
  }

  Future<void> _simulateLoading() async {
    await Future.delayed(const Duration(seconds: 2));
    _checkTokenAndNavigate();
  }

  Future<void> _checkTokenAndNavigate() async {
    String? savedToken = await TokenStorage.getAccessToken();

    if (savedToken.isEmpty || JwtDecoder.isExpired(savedToken)) {
      NavigationService.navigateToHomeScreen(null);
    } else {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(savedToken);
      String userID = decodedToken['id'].toString();
      User theUser = await UserRequests.getUserData(userID);
      NavigationService.navigateToHomeScreen(theUser);
    }
    _isLoading.value = false;
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
