import 'package:get/get.dart';
import 'package:final_tpc_app/app/bindings/initial_binding.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    InitialBinding().dependencies(); // Call dependencies from InitialBinding
    // Call dependencies from NotificationBinding
    // Add more bindings as needed
  }
}
