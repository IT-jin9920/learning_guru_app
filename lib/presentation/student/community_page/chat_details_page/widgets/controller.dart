import 'package:get/get.dart';

class DialController extends GetxController {
  var isDialOpen = false.obs;

  void toggleDial() => isDialOpen.value = !isDialOpen.value;

  void closeDial() => isDialOpen.value = false;

  void selectOption(String option) {
    print('$option Selected');
    closeDial();
  }
}
