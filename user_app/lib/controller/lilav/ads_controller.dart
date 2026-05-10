import 'package:get/get.dart';

class AdsController extends GetxController {
  var currentIndex = 0.obs;

  final List<String> ads = [
    'assets/images/ads1.jpg',
    'assets/images/ads2.jpg',
    'assets/images/ads3.jpg',
  ];

  void changeIndex(int index) {
    currentIndex.value = index;
  }
}