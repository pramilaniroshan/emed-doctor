import 'package:get/state_manager.dart';

class DoctorController extends GetxController {
  String firstName = 'user'; //no need for .obs

  void setFirstname(String name) {
    firstName = name;
    // use update method to update all count variables
    update();
  }
}
